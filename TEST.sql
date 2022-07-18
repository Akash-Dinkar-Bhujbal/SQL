USE TEST;

CREATE TABLE SALES
(
	salesman_id  INT, 
	name VARCHAR(20),
	city VARCHAR(20), 
	commission INT
);

INSERT INTO SALES
VALUES
(5001,'James Hoog','New York', 15),
(5002,'Nail Knite', 'Paris', 13),
(5005 , 'Pit Alex','London',11),
(5006 , 'Navin', 'Paris', 14),
(5007 , 'Paul Adam','Paris',13),
(5003 ,'Lauson Hen','San Jose', 12);

-----------------------------------------------
--1 display all records where commission is >=  12 
SELECT * FROM sales WHERE commission >= 12;

--2 display all records where city is Paris
SELECT * FROM sales WHERE city = 'Paris';

--3 display all records where name is starting with letter N 
SELECT * FROM sales WHERE name LIKE 'N%';
------------------------------------------------------------------
CREATE TABLE ORDER1 
(
	ord_no INT,
	purchamt INT,
	ord_date DATE,
	customer_id INT,
	salesmanid INT
);

INSERT INTO ORDER1 
VALUES
(70001 ,150,'2012-10-05',3005,5002),
(70009 ,270,'2012-09-10' , 3001 ,5002),
(70002,65,'2012-10-05',3002,5001),
(70004,110,'2012-08-17',3009,5002),
(70007,948,'2012-09-10',3005,5002),
(70005,2400,'2012-07-27',3007,5001),
(70008, 5760, '2012-09-10'  ,3002,5001);
--------------------------------------------------------------------
--1 DISPLAY TOTAL PURCHAMT GROUP BY SALESMANID
SELECT salesmanid , SUM(purchamt) AS TOTAL FROM ORDER1 GROUP BY SALESMANID;

--2 DISPLAY ALL RECORDS WHERE ORDER_NO >=70004
SELECT * FROM ORDER1 WHERE ord_no >= 70004;

--3 DISPLAY ALL RECORDS WHERE ORD_DATE >=2012-09-09
SELECT * FROM ORDER1 WHERE ord_date >= '2012-09-09';

--4 DISPLAY AVERAGE PURCHAMT
SELECT AVG(purchamt) AS AVERAGE FROM ORDER1 ;
---------------------------------------------------------------------------------
CREATE TABLE TEACHER
(
	TEACHERID INT, 
	TEACHERNAME VARCHAR(20)
);

INSERT INTO TEACHER 
VALUES
	(100,'MOHAN'),
	(200,'RAMESH'),
	(300,'AKBAR');

CREATE TABLE STUDENT 
(
	STUDENTID INT,  
	STUDNAME VARCHAR(20), 
	TEACHERID INT
);

INSERT INTO STUDENT 
VALUES
	(10,'SURESH',100),
	(20,'DAVID',200),
	(30,'KARAN',200),
	(40,'PURAN',111);

--DROP TABLE TEACHER;
--DROP TABLE STUDENT;
SELECT * FROM TEACHER;
SELECT * FROM STUDENT

--WRITE LEFT OUTER JOIN FOR THE ABOVE TABLES AND DISPLAY 
--TEACHERID FROM BOTH THE TABLES AND  TEACHERNAME,STUDENTNAME
SELECT TEACHER.TEACHERID,TEACHERNAME, STUDNAME 
	FROM TEACHER LEFT OUTER JOIN STUDENT ON TEACHER.TEACHERID = STUDENT.TEACHERID;
-------------------------------------------------------------------------------------
CREATE TABLE EMP 
(
	EMP_IDNO INT, 
	EMP_FNAME   VARCHAR(20),    
	EMP_LNAME VARCHAR(20),
	EMP_DEPT INT
);

--WRITE A PROCEDURE TO INPUT RECORDS FOR ABOVE TABLE USE PROPER PARAMETERS
CREATE PROC INSERT_EMP
	@EID INT,
	@FNAME VARCHAR(20),
	@LNAME VARCHAR(20),
	@DID INT
AS
	BEGIN
	INSERT INTO EMP 
	(EMP_IDNO, EMP_FNAME,EMP_LNAME,EMP_DEPT) 
	VALUES 
	(@EID, @FNAME,@LNAME,@DID)
	END;

EXEC INSERT_EMP 102, 'AKASH1', 'BHUJBAL1', 300

--5  WRITE A FUNCTION WHICH WILL INPUT TWO NUMBERS AND PRINT THE GREATER NUMBER 
DROP FUNCTION GNO

CREATE FUNCTION GNO(@A INT, @B INT)
RETURNS INT
AS
	BEGIN
	DECLARE @X INT
		IF (@A > @B )
		BEGIN
		SET @X = @A
		END
		ELSE 
		BEGIN
		SET @X = @B
		END
		RETURN @X
	END;

DECLARE @N INT
SET @N = DBO.GNO(90,12)
PRINT @N


--6 WRITE A TRIGGER FOR INSERT FOR DEPARTMENT TABLE IF DEPARTNAME IS NULL THE RECORDS MUST NOT BE INSERTED 
--TABLE STRUCTURE IS AS BELOW DEPTID DEPTNAME 
-- (Alternative Emp)


CREATE TRIGGER CHECKINSERT ON EMP
	FOR INSERT
AS
	DECLARE @NAME VARCHAR(20)
	
	SELECT @NAME = EMP_FNAME+EMP_LNAME FROM INSERTED
		IF @NAME IS NULL OR @NAME = '' 
		BEGIN
			PRINT 'INVALID NAME'
			ROLLBACK TRAN
		END 
		ELSE
		BEGIN
			PRINT 'SUCCESS!'
		END;

INSERT INTO EMP VALUES (102,'SUYOG','KADAM',300)

INSERT INTO EMP VALUES (103,'','',300)

INSERT INTO EMP VALUES (104,NULL,NULL,300)