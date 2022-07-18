USE NELITO

drop table CUSTOMERS
CREATE TABLE CUSTOMERS (CONTACTNAME VARCHAR(30),ADDRESS VARCHAR(20),email varchar(30))
INSERT INTO CUSTOMERS VALUES('SURESH PAL','MANPADA RD','suresh@gmail.com')
INSERT INTO CUSTOMERS VALUES('HITENDRA THAKUR','BANJARA HILL','hit@hotmail.com')
INSERT INTO CUSTOMERS VALUES('ASIF KHAN','AKBAR ROAD','asif@gmail.com')
INSERT INTO CUSTOMERS VALUES('MOHAN KHANNA','GANDHINAGAR RD','mohan@ymail.com')
INSERT INTO CUSTOMERS VALUES('AKBAR KHAN','GANDHINAGAR RD','mohan@hotmail.com')
SELECT * FROM CUSTOMERS

SELECT SUBSTRING('SURESH',2,3) --Starts from 2, next 3 char
SELECT CHARINDEX(' ','SURESH pal')--Find ' ' in 'Suresh pal'

SELECT SUBSTRING(CONTACTNAME,1,CHARINDEX(' ',CONTACTNAME)) FIRSTNAME  FROM CUSTOMERS
    
select  substring(ContactName,
                       charindex(' ',ContactName)+1 ,
                       len(ContactName)) as LASTNAME FROM CUSTOMERS

select count(*) from CUSTOMERS
	  where CHARINDEX('Rd',Address) > 0 or CHARINDEX('Road',Address) >0

select count(*) from CUSTOMERS
	  where CHARINDEX('Rd',Address) > 0 or CHARINDEX('Road',Address) >1

SELECT * FROM CUSTOMERS
--SELECT * FROM CUSTOMERS WHERE CHARINDEX('Rd',address) 
select CHARINDEX('Rd',address)  from CUSTOMERS
select CHARINDEX('Road',address)  from CUSTOMERS
-------------------------------------------------------------------------
DROP TABLE PRODUCT

create table product (pid int,description varchar(20))

insert into product values(1,'bread')
insert into product values(2,'sweet bread')
insert into product values(3,'PASTA')
insert into product values(4,'CRACKERS')
insert into product values(5,'CEREAL')
insert into product values(6,'Desserts')

select * from product
------------------patindex : PATTERN_INDEX
select Description from product
	  where patindex('%[b,B]read%',description) =0

select Description from product
	  where patindex('%[b,B]read%',description) >0
--select Description from product where patindex('%[b,B]read%',description) <0
-------------------------------------------------------------------------------
SELECT * FROM CUSTOMERS
SELECT a.CONTACTNAME,
             a.email, 
       Substring (a.email, Charindex( '@', email ) + 1, 	-- Start Position
Len(email) 							-- End Position.
       ) AS DOMAINNAME
FROM   CUSTOMERS a
-----------------------------------------
SELECT Count(*), 
       Substring (a.email, Charindex( '@', email ) + 1, Len( 
       email) 
       ) AS [Domain Name] 
FROM   CUSTOMERS a 
GROUP  BY Substring (a.email, Charindex( '@', a.email ) + 1, 
                    Len(a.email))
-------------------------------------------------
-----------------------SOUNDEX
SELECT contactname from CUSTOMERS
		WHERE SOUNDEX('John') = SOUNDEX(contactname)

SELECT SOUNDEX('javascript') soundex_javascript, SOUNDEX('c#') soundex_c#,
DIFFERENCE('javascript', 'c#') similarity;
SELECT SOUNDEX('poor') soundex_poor, SOUNDEX('pour') soundex_pour, 
DIFFERENCE('poor', 'pour') similarity;
SELECT * FROM EMPLOYEE
INSERT INTO EMPLOYEE(DEPTID) VALUES(NULL)
SELECT COUNT(DEPTID) FROM EMPLOYEE


--================================procedure==============================--

--TO DECLARE VARIABLE
DECLARE @RATE INT
SET @RATE =1000
SELECT @RATE

DECLARE @B INT
SET @B=-10
IF @B > 0 
BEGIN
SELECT 'THIS IS POSITIVE NUMBER  '
SELECT 'FINO BANK IS IN MUMBAI'
END
ELSE
BEGIN
SELECT 'THIS IS A NEGATIVE NUMBER'
SELECT 'VASHI'
END
----------------------------------------------------------

DROP TABLE EMP

CREATE TABLE EMP(SAL INT)
ALTER TABLE EMP ADD NO INT

INSERT INTO EMP VALUES(9000)

SELECT * FROM EMPLOYEE

INSERT INTO EMP VALUES(4000,3)

SELECT * FROM EMPLOYEE

DECLARE @A INT
SELECT @A = SALARY FROM EMPLOYEE WHERE ID=100
IF @A < 13000 
PRINT 'REVIEW OF SALARY IS REQUIRED'
ELSE
BEGIN
PRINT 'REVIEW OF THE SALARY  IS NOT REQUIRED'
PRINT 'SALARY = '
PRINT @A
END
----------------------------------------------------
--------------SWITCH CASE---------------------------
----------------------------------------------------
DECLARE @TestVal INT
SET @TestVal = 2
SELECT
CASE @TestVal
WHEN 1 THEN 'First'
WHEN 2 THEN 'Second'
WHEN 3 THEN 'Third'
ELSE 'Other'
END
------------------------------WHILE LOOP-------------------
DECLARE @A INT
SET @A =1
WHILE @A <  12
BEGIN
PRINT @A
SET @A = @A + 1
END
------------------------------
DECLARE @A INT
DECLARE @S INT
SET @S=0
SET @A =1
WHILE @A <  6
BEGIN
SET @S =@S+ @A 
SET @A = @A + 1
END
PRINT @S
---------------------------------------------------------
-------------TRY CATCH-----------------------------------
BEGIN TRY
	DECLARE @A INT
	SET @A =10
	DECLARE @B INT
	SET @B=0
	DECLARE @C INT
	SET @C = @A / @B
	PRINT @C 
END TRY
BEGIN CATCH
	SELECT 'THERE WAS '  +ERROR_MESSAGE(),ERROR_LINE(),ERROR_NUMBER() 
END CATCH
------------procedure
select * from EMPLOYEE

DROP PROCEDURE PR1
---WITHOUT PARAMETER
CREATE PROCEDURE PR1
AS
BEGIN
SELECT * FROM EMPLOYEE
END

EXEC PR1 --TO RUN
PR1
EXECUTE PR1
---------------------------------------------------
---WITH PARAMETER
DROP PROCEDURE PR2
CREATE PROCEDURE PR2 (@A INT)
AS
BEGIN
PRINT 'LIST OF EMPLOYEES '
SELECT * FROM EMPLOYEE WHERE DEPTID=@A
END

EXEC PR2 100
---------------------------------------------------------
--CREATING PROCEDURE OF OUTPUT PARAMETER 
DROP PROC PR3
CREATE PROC PR3 @A INT, @NAME CHAR(20)  OUTPUT
AS
BEGIN
IF EXISTS(SELECT * FROM EMPLOYEE WHERE DEPTID=@A)
BEGIN
SELECT @NAME = EMPNAME FROM EMPLOYEE WHERE DEPTID=@A
RETURN 0
END
ELSE
RETURN 1
END

EXEC PR3 100--NOT WORKING
SELECT * FROM EMPLOYEE
-- CALLING THE PROCEDURE  WITH OUTPUT 
DECLARE @A INT
DECLARE @D VARCHAR(10)
EXEC @A = PR3 111  ,@D OUTPUT --<<--<<--<<--<<--
IF (@A =0)
PRINT 'THE NAME IS ' +@D
ELSE
PRINT 'NO RECORDS WERE FOUND'
----------------------------------------------------
-- CREATING FUNCTION 
DROP FUNCTION FUN22

CREATE FUNCTION FUN22(@A INT)
RETURNS INT
AS
BEGIN
RETURN (@A *2 )
END
---
PRINT DBO.FUN22(4)
-------------------------------------
DROP  FUNCTION FUN3
CREATE FUNCTION FUN3(@A INT, @B INT)
RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @X VARCHAR(20)
IF (@A > @B )
SET @X =CAST(@A AS VARCHAR)+' IS GREATER '
ELSE 
SET @X =CAST(@B AS VARCHAR)+' IS GREATER '
RETURN @X
END
-------
DECLARE @M VARCHAR(20)
SET @M=DBO.FUN3(9,12)
PRINT @M
-----USING A FUNCTION
DECLARE @B INT
SET @B = DBO.FUN2(2)
PRINT @B
--USING A FUNCTION WHICH RETURN A TABLE
SELECT * FROM EMP
CREATE FUNCTION FUN4 ( @A INT)
RETURNS TABLE
AS
RETURN (SELECT * FROM EMP WHERE NO = @A )
--CALLING THE FUNCTION
SELECT * FROM FUN4(1)
--USING TRIGGER 
CREATE TRIGGER T11 ON EMP
AFTER INSERT AS
BEGIN 
PRINT 'THE RECORD IS INSERTED '
END
--USING TRIGGER
INSERT INTO EMP VALUES(1111,1)
---ANOTHER TRIGGER
CREATE TRIGGER T12 ON EMP
AFTER UPDATE AS
BEGIN 
SELECT * FROM DELETED
SELECT * FROM INSERTED
END
--USING TRIGGER T12
UPDATE EMP SET SAL=1002 WHERE NO=1
--ANOTHER TRIGGER INSERT TRIGGER
CREATE TRIGGER T13
ON EMP
FOR INSERT 
AS
DECLARE @MDATE DATETIME
SELECT @MDATE = DOJ FROM INSERTED 
IF (@MDATE > GETDATE())
BEGIN
PRINT 'THE DATE OF BIRTH SHOULD BE MORE THAN TODAY '
ROLLBACK TRAN
END
---
DROP TABLE EMP
CREATE TABLE EMP (NO INT,DOJ DATETIME)
INSERT INTO EMP VALUES(1,'09-AUG-2010')
SELECT * FROM EMP
SELECT MONTH(DOJ) FROM EMP
INSERT INTO EMP VALUES (2,'09-JAN-2009')
---------INSERT TRIGGER
CREATE TRIGGER T14
ON EM
FOR INSERT 
AS
DECLARE @MPAY INT
SELECT @MPAY = PAY FROM INSERTED 
IF (@MPAY < 1000)
BEGIN
PRINT 'PAY MUST BE MORE THAN   1000 '
ROLLBACK TRAN
END
DROP TABLE EM
CREATE TABLE EM(NO INT,PAY INT)
--USING TRIGGER 
INSERT INTO EM VALUES(1,3200)
-----------------------------UPDATE TRIGGER
CREATE TRIGGER T5
ON EM
FOR UPDATE
AS
IF UPDATE(PAY)
BEGIN
DECLARE @A INT
SELECT @A = AVG(PAY) FROM EM
IF (@A > 2000)
BEGIN
PRINT 'THE AVERAGE PAY CAN NOT BE MORE THAN 2000'
ROLLBACK TRANSACTION
END
END
--------------------------DELETE TRIGGER
CREATE TRIGGER DEL1
ON EM
FOR DELETE
AS 
BEGIN
PRINT 'DELETION OF RECORD IS NOT ALLOWED'
ROLLBACK TRAN
END
------------------------------------------AFTER DELETE
CREATE TRIGGER DEL2 ON EM
AFTER 
DELETE
AS
PRINT 'RECORDS ARE DELETED'
-------------------USING THE TRIGGER
DELETE FROM EM
-------------------




-----------------------------------------------------------------------------
------------------ DATE & TIME ---
-----------------------------------------------------------------------------
DROP TABLE EMPP 

CREATE TABLE EMPP(ID INT,DOJ DATE)

INSERT INTO EMPP VALUES
(1,'2021-09-10'),
(2,'2018-07-12'),
(3,'2017-09-10'),
(4,'2016-04-05')

SELECT * FROM EMPP

---------------------- GEDATE
SELECT GETDATE()

--------------------- DATEADD
select dateadd(month,5,getdate())

select dateadd(year,2,getdate())

select DATEADD(DAY,4,GETDATE())

-------------------- DATEDIFF
SELECT DATEDIFF(MONTH,'02/01/2019',GETDATE())

------------------ COLUMN/TABLE
SELECT DOJ,DATENAME(DAY,DOJ) FROM EMPP

SELECT DOJ,DATENAME(MONTH,DOJ) FROM EMPP

SELECT DATEPART(MONTH,GETDATE())

SELECT DAY(DOJ) FROM EMPP

SELECT MONTH(DOJ) FROM EMPP

SELECT YEAR(DOJ) FROM EMPP

------------------------ OTHER FUNCTIONS OF DATE
SELECT DATEPART(YEAR, GETDATE())        AS 'Year';        
  
SELECT DATEPART(MONTH, GETDATE())       AS 'Month'; 

SELECT DATEPART(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   

SELECT DATEPART(DAY, GETDATE())         AS 'Day';  

SELECT DATEPART(WEEK, GETDATE())        AS 'Week';  

SELECT DATEPART(WEEKDAY, GETDATE())     AS 'WeekDay';   