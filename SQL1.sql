--DELETE DATABSE
DROP DATABASE TEST;
--CREATE DATABASE
CREATE DATABASE TEST;
--USE DATABASE
USE TEST;
--DELETE TABLE
DROP TABLE WORKER;
--CREATE TABLE
CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY IDENTITY,
	FIRST_NAME VARCHAR(25),
	LAST_NAME VARCHAR(25),
	SALARY INT,
	JOINING_DATE DATE,
	DEPARTMENT VARCHAR(25)
);

--INSERT INTO TABLE 
INSERT INTO Worker 
		( FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) 
	VALUES
		( 'Monika', 'Arora', 100000, '2014-02-20', 'HR'),
		( 'Niharika', 'Verma', 80000, '2014-06-11', 'Admin'),
		( 'Vishal', 'Singhal', 300000, '2014-02-20', 'HR'),
		( 'Amitabh', 'Singh', 500000, '2014-02-20', 'Admin'),
		( 'Vivek', 'Bhati', 500000, '2014-06-11', 'Admin'),
		( 'Vipul', 'Diwan', 200000, '2014-06-11', 'Account'),
		( 'Satish', 'Kumar', 75000, '2014-01-20', 'Account'),
		( 'Geetika', 'Chauhan', 90000, '2014-04-11', 'Admin');

SELECT * FROM Worker;

DROP TABLE Bonus;

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATE,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '2016-02-20'),
		(002, 3000, '2016-06-11'),
		(003, 4000, '2016-02-20'),
		(001, 4500, '2016-02-20'),
		(002, 3500, '2016-06-11');

SELECT * FROM Bonus;

DROP TABLE Title;

CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE VARCHAR(25),
	AFFECTED_FROM DATE,
	FOREIGN KEY (WORKER_REF_ID)--FK
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20'),
 (002, 'Executive', '2016-06-11'),
 (008, 'Executive', '2016-06-11'),
 (005, 'Manager', '2016-06-11'),
 (004, 'Asst. Manager', '2016-06-11'),
 (007, 'Executive', '2016-06-11'),
 (006, 'Lead', '2016-06-11'),
 (003, 'Lead', '2016-06-11');

SELECT * FROM Title;
---------------------------------------------------------------------------------------------------
--1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT FIRST_NAME FROM WORKER AS WORKER_NAME;

--2. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT DEPARTMENT FROM WORKER;

--3. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT SUBSTRING(FIRST_NAME,1,3) FROM WORKER;

--4. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.
SELECT CHARINDEX('A', FIRST_NAME) 'CharIndex of A' FROM WORKER WHERE FIRST_NAME = 'AMITABH';

--5. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) FROM WORKER;

--6. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT DEPARTMENT, LEN(DEPARTMENT) FROM WORKER;

--7. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
-- --||--

--8. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. 
--A space char should separate them.
SELECT FIRST_NAME +' '+ LAST_NAME AS COMPLETE_NAME FROM WORKER;

--9. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM WORKER ORDER BY DEPARTMENT;

--10. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM WORKER WHERE FIRST_NAME ='VIPUL' OR FIRST_NAME = 'SATISH';

--11. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM WORKER WHERE NOT (FIRST_NAME ='VIPUL' OR FIRST_NAME = 'SATISH');

--12. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”
SELECT * FROM WORKER WHERE DEPARTMENT ='ADMIN';

--14. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%A%';

--15. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '_____H';
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '______' AND FIRST_NAME LIKE '%H';

--16. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM WORKER WHERE SALARY BETWEEN 100000 AND 500000;
SELECT * FROM Worker WHERE SALARY >= 100000 AND SALARY <= 500000;