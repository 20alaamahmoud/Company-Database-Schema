use master;
create database Company;



use Company;
-- creating tabels

CREATE TABLE Employee (
	SNN INT PRIMARY KEY NOT NULL,
	fname VARCHAR (20) ,
	lname VARCHAR (20),
	BDATE DATE,
	ADDR VARCHAR (255) ,	SALARY int 	check (SALARY < 6000) ,	SUPERSNN INT , --FK	DNO INT, --FK	CONSTRAINT CK_ADDR check (  ADDR in ('alex' , 'cairo' , 'mansoura')	),	FOREIGN KEY (SUPERSNN) REFERENCES Employee (SNN),
);
CREATE TABLE DEPARTMENT (

    DNAME VARCHAR (50),
	DNUMBER INT PRIMARY KEY NOT NULL ,
	MGRSNN INT,

   FOREIGN KEY (MGRSNN) REFERENCES Employee (SNN) ON DELETE SET NULL,


);

CREATE TABLE DEPT_loca (

    
	DNUM INT NOT NULL, 
	DLOCA VARCHAR (50) NOT NULL,
	Primary Key (DNUM ,DLOCA),
 FOREIGN KEY (DNUM) REFERENCES DEPARTMENT (DNUMBER) ,

);


CREATE TABLE PROJECT (
	PNAME VARCHAR (50),
	PNUM INT PRIMARY KEY NOT NULL ,
	PLOC VARCHAR (100),
	DNUM INT NOT NULL,
	FOREIGN KEY (DNUM) REFERENCES DEPARTMENT (DNUMBER) ,

);


CREATE TABLE Works_on (
	
	ESNN INT  NOT NULL ,
	PNO INT  NOT NULL,
	HOURS INT NOT NULL,
	Primary Key (ESNN ,PNO),
	FOREIGN KEY (ESNN) REFERENCES Employee (SNN) ,
	FOREIGN KEY (PNO) REFERENCES PROJECT (PNUM) ,
	
);


CREATE TABLE DEPENDENT (
	
	ESNN INT  NOT NULL ,
    DNAME VARCHAR(30),
	SEX VARCHAR(10),
	BDATE DATE,
	Relationship VARCHAR(20),
	Primary Key (ESNN ,DNAME),
	FOREIGN KEY (ESNN) REFERENCES Employee (SNN) ,
	
);

-- insertig
insert into Employee values(2,'yousef','mhmd','2000-11-06','cairo' , 5000 , 6,2 );
insert into Employee values(3,'Ahmed','mhmd','1971-05-29','alex' , 3500 , 3,3 );
insert into Employee values(4,'mariem','mhmd','1991-07-2','alex' , 5500 , 3,3 );
insert into Employee values(1,'estabraq','salman','2002-12-15','cairo' , 5500 , 2,1 );
insert into Employee values(5,'Alaa','mahmoud','2001-10-20','mansoura' , 5700 , 4,2 );
insert into Employee values(6,'soad','Badr','2002-05-11','cairo' , 5600 , 5,4 );
insert into Employee values(7,NULL,NULL,'2002-10-10','cairo' , 3400 , 1,5 );
insert into Employee values(8,'mhmd','salama','2001-01-01','cairo' , 5900 , 1,2 );
insert into Employee values(9,'ragab',NULL,'2002-03-19','alex' , 4000 , 2,1 );
insert into Employee values(10,'mark','jacoub','1999-08-09','cairo' , 5999 , 3,2 );
insert into Employee values(11,'Ahmed','tarek','1994-03-12','cairo' , NULL , 3,4 );

insert into DEPARTMENT values('it',1,2);
insert into DEPARTMENT values('markting',2,1);
insert into DEPARTMENT values('sales',3,4);
insert into DEPARTMENT values('QC',4,6);
insert into DEPARTMENT values('software',5,8);


 insert into DEPT_loca values(1,'first floor');
 insert into DEPT_loca values(2,'first floor');
 insert into DEPT_loca values(3,'sec floor');
 insert into DEPT_loca values(4,'sec floor');
 insert into DEPT_loca values(5,'sec floor');


insert into PROJECT values ('p1',1,'first floor',2);
insert into PROJECT values ('p2',2,'sec floor',3);
insert into PROJECT values ('p3',3,'first floor',1);
insert into PROJECT values ('Bproject',4,'sec floor',4);
insert into PROJECT values ('p5',5,'sec floor',5);

insert into Works_on  values (1,2,19);
insert into Works_on  values (2,3,12);
insert into Works_on  values (3,3,17);
insert into Works_on  values (4,1,20);
insert into Works_on  values (5,2,9);
insert into Works_on  values (6,3,15);
insert into Works_on  values (7,4,10);
insert into Works_on  values (8,5,17);
insert into Works_on  values (9,5,13);
insert into Works_on  values (10,3,13);
insert into Works_on  values (11,4,5);

insert into DEPENDENT  values (1,'lely','Female','2007-08-05','Sister');
insert into DEPENDENT  values (4,'mhmd','male','2009-09-01','Son');
insert into DEPENDENT  values (11,'mona','Female','1998-08-05','wife');
insert into DEPENDENT  values (3,'reem','Female','1973-11-28','wife');
insert into DEPENDENT  values (3,'mhmd','male','2005-07-01','son');
select * from Employee;



-- first  اشخاص معتمده عليه 
 SELECT e.fname ,e.lname, D.DNAME , D.SEX  , D.BDATE , D.Relationship 
 FROM Employee e INNER JOIN DEPENDENT D
  ON e.SNN = D.ESNN

-- 2 اسم الشخص و اسم البروجيكت الي شغال عليه بالترتيب
SELECT e.fname , e.lname ,  p.PNAME
FROM Employee e INNER JOIN Works_on w ON e.SNN = w.ESNN
INNER JOIN PROJECT p ON w.PNO = p.PNUM
ORDER BY p.PNAME;
 
 --3 طلع اعلي اتنين مرتب
 SELECT TOP 2 SALARY
FROM Employee
ORDER BY SALARY DESC;

-- 4 
SELECT e.fname , e.lname , COALESCE(e.SALARY , 3000)   -- Replace NULL with 3000
FROM Employee e

--5 
SELECT e.fname , e.lname , s.SNN , s.fname , s.lname ,s.BDATE , s.ADDR ,s.SALARY , s.DNO
FROM Employee e , Employee s
WHERE s.SNN = e.SUPERSNN


--6 
DECLARE @highest_salary1 INT
DECLARE @highest_salary2 INT

SELECT @highest_salary1 = MAX(SALARY) -- اعلي واحد
FROM Employee

SELECT @highest_salary2 = MAX(SALARY)
FROM Employee
WHERE SALARY < @highest_salary1   --  ادور ف  كل الي اصغر من اعلي مرتب

SELECT * FROM Employee
WHERE SALARY = @highest_salary2;   -- اعرض بيانات الموظف صاحب تاني اعلي مرتب

--7


SELECT PNAME
FROM PROJECT
WHERE PNAME LIKE 'B%'   --Search For a pattern


-- 8

insert into Employee(SNN,SALARY)
values (12,6100)

-- 9 

insert into Employee(SNN,ADDR)
values (12,'fayoum')


-- 10 Scalar Function
create function CKNAME(@id INT) 
--   فانكشن بتاخد (id)
-- و بتشوف ايه ال NULL

returns NVARCHAR(100)  --
AS
BEGIN
    DECLARE @fname VARCHAR(20)
    DECLARE @lname VARCHAR(20)
    DECLARE @message NVARCHAR(100)

    SELECT @fname = fname, @lname = lname
    FROM Employee
    WHERE SNN = @id;
 
 IF @fname IS NULL AND @lname IS NULL
  SET @message = 'First name & last name are null'

 ELSE IF @fname IS NULL
  SET @message = 'first name is null'

 ELSE IF @lname IS NULL
  SET @message = 'last name is null'

 ElSE
  SET @message = 'First name & last name are not null' 

  RETURN @message ;

END;

SELECT dbo.CKNAME(7)


-- 11


drop FUNCTION NAMES
CREATE FUNCTION NAMES (@string VARCHAR(50))
returns @t table  -- فانكشن بترجع table
(
  names varchar(50)  --   table مكون من ايه 
)
as
begin 
    IF @string = 'first name'
	begin
	  insert @t
	  SELECT  ISNULL(FName, '') 
	  FROM Employee
	  End
	ELSE IF @string = 'last name'
	  begin
	  insert @t
	  SELECT  ISNULL(LName, '') 
	  FROM Employee
	  end
	ELSE IF  @string = 'full name'
	  begin
	  insert @t
	  SELECT CONCAT(fname ,' ', lname)   -- CONCAT function that add two or more strings togatger
	  FROM Employee
	  end
return -- 
END;


SELECT * FROM NAMES('first name')
SELECT * FROM NAMES('last name')
SELECT * FROM NAMES('full name')

-- 12

CREATE VIEW ProjectCount 
AS
SELECT p.pname, COUNT(w.ESNN) as Ecount --
FROM Project p
right JOIN Works_On w ON p.PNUM = w.pno
GROUP BY p.pname;

SELECT * FROM ProjectCount


-- 13 -- 1
CREATE VIEW D2 
AS
SELECT e.snn , e.lname 
FROM Employee e
where e.DNO = 2

SELECT * FROM D2 

-- 13 -- 2
SELECT lname 
FROM D2   --Use the previous view created in Q#1
where lname LIKE '%j%'
 
 -- 14
  CREATE PROCEDURE UpdateWorkOn @old_emp_SNN INT, @new_emp_SNN INT,   @project_number INT
  As
   UPDATE Works_On
    SET ESNN = @new_emp_SNN
    WHERE ESNN = @old_emp_SNN AND pno = @project_number;
	PRINT 'Employee updated successfully';

exec UpdateWorkOn 5 , 6 , 2





 -- 15 -- 1 --
 
 
CREATE TABLE EmployeeAudit (
    EAname VARCHAR(100),
    EAdate DATE,
    Note VARCHAR(100)
);

--15 -- 2 --

DELETE FROM Employee WHERE SNN = 12;


CREATE TRIGGER Delete_Employee_Trigger
ON Employee
INSTEAD OF DELETE
AS
BEGIN
    -- Declare variables to store audit information
    DECLARE @Name VARCHAR(100) = SYSTEM_USER;
    DECLARE @Date DATE = GETDATE();
    DECLARE @Note VARCHAR(100);

    -- Insert audit information into EmployeeAudit table
    INSERT INTO EmployeeAudit (EAname, EAdate, Note)
    SELECT @Name, @Date, 'try to delete Row with Key of row = ' + CAST(d.SNN AS VARCHAR(100))
    FROM deleted d;
END;

DELETE FROM Employee WHERE SNN = 12;
select * from EmployeeAudit

drop trigger Delete_Employee_Trigger