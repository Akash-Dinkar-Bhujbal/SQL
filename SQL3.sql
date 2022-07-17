USE TEST;

DROP TABLE DEPTMASTER;
CREATE TABLE DEPTMASTER (
	DEPTID INT PRIMARY KEY, 
	DEPTNAME VARCHAR(30)
);

INSERT INTO DEPTMASTER VALUES 
	(100,'SALES'),
	(200,'PURCHASE'),
	(300,'PROGRAMMING'),
	(400,'ACCOUNTS');


DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE(
	ID INT, 
	SALARY INT,
	EMPNAME VARCHAR(20), 
	ADDRESS VARCHAR(20), 
	DEPTID INT REFERENCES DEPTMASTER(DEPTID) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO EMPLOYEE VALUES 
	(101,14000,'AKASH', 'KHOPOLI',300),
	(102,1200,'ABHISHEK', 'NAGPUR',400),
	(103,15000,'SIDDHARTH', 'BHUVANESHVAR',200),
	(104,21000,'NEHA', 'NASHIK',100),
	(105,13000,'SAKSHI', 'NAGPUR',200),
	(106,18000,'KAMRAM', 'NAGPUR',100);

SELECT * FROM EMPLOYEE;

SELECT * FROM DEPTMASTER;
---------------------------------------------------------------------------------------------
--1. make a procedure in sql ,which will input 1 parameter OF integer type
--AND ANOTHER OF VARCHAR(20) and INSERT RECORD IN EMPLOYEE TABLE(COLUMNS ARE ID AND NAME) 

DROP PROC INSERT_NAME;

CREATE PROC INSERT_NAME
	@EMPID INT,
	@NAME VARCHAR(20)
AS
	BEGIN
	INSERT INTO EMPLOYEE (ID, EMPNAME) VALUES (@EMPID, @NAME)
	END;

EXEC INSERT_NAME 107, 'KAUSTUBH';
---------------------------------------------------------------------------------------------------------------
--2. make a procedure in sql which will take 2 parameter 1 input integer type  and another output  varchar type 
--we will pass id and input parameter and it must returns name as ouptut paramter 



CREATE PROC GET_EMPLOYEE_NAME
	@ID INT, @NAME VARCHAR(20) OUTPUT
AS
	BEGIN
	SELECT @NAME = EMPNAME FROM EMPLOYEE WHERE ID =@ID
	RETURN 0
	END;

DECLARE @MY_NAME VARCHAR(20);
EXEC GET_EMPLOYEE_NAME 101, @MY_NAME OUTPUT;
PRINT @MY_NAME;

-----------------------------------------------
CREATE PROC PR 
AS 
	BEGIN
	PRINT 'PROC CALLING'
	END;

EXEC PR;


--------------------------------------------------------------------------------------
--3. write a trigger in sql which will
--for insert if the name is blank and salary is less than 10000 then 
--It must NOT allow to inserT the record in the table and display appropriate message 

DROP TRIGGER CHECK_INSERT

CREATE TRIGGER CHECK_INSERT ON EMPLOYEE
	FOR INSERT
AS
	DECLARE @NAME VARCHAR(20)
	DECLARE @SAL INT
	SELECT @SAL = SALARY, @NAME = EMPNAME FROM INSERTED
		IF @NAME IS NULL OR @NAME = '' 
		BEGIN
			PRINT 'INVALID NAME'
			ROLLBACK TRAN
		END 
		ELSE IF @SAL<10000
		BEGIN
			PRINT 'INVALID SALARY'
			ROLLBACK TRAN
		END 
		ELSE
		BEGIN
			PRINT 'SUCCESS!'
		END;

INSERT INTO EMPLOYEE VALUES (107,7000,'SATISH','THANE',300)

INSERT INTO EMPLOYEE VALUES (107,70000,NULL,'THANE',300)

INSERT INTO EMPLOYEE VALUES (108,70000,'','THANE',300)