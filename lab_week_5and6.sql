create database emp_database;
use emp_database;
CREATE TABLE dept (
deptno decimal(2,0) primary key,
dname varchar(14) default NULL,
dloc varchar(13) default NULL
);

CREATE TABLE emp (
empno decimal(4,0) primary key,
ename varchar(10) default NULL,
mgr_no decimal(4,0) default NULL,
hiredate date default NULL,
sal decimal(7,2) default NULL,
deptno decimal(2,0) references dept(deptno) on delete cascade on update cascade
);
create table incentives (
empno decimal(4,0) references emp(empno) on delete cascade on update cascade,
incentive_date date,
incentive_amount decimal(10,2),
primary key(empno,incentive_date)
);
Create table project (
pno int primary key,
pname varchar(30) not null,
ploc varchar(30)
);
Create table assigned_to (
empno decimal(4,0) references emp(empno) on delete cascade on update cascade,
pno int references project(pno) on delete cascade on update cascade,
job_role varchar(30),
primary key(empno,pno)
);
show tables;                    
INSERT INTO dept VALUES (10,'ACCOUNTING','MUMBAI');
INSERT INTO dept VALUES (20,'RESEARCH','BENGALURU');
INSERT INTO dept VALUES (30,'SALES','DELHI');
INSERT INTO dept VALUES (40,'OPERATIONS','CHENNAI');
insert into dept values (60,'ADMIN','MYSURU');
INSERT INTO emp VALUES (7369,'Adarsh',7902,'2012-12-17','80000.00','20');
INSERT INTO emp VALUES (7499,'Shruthi',7698,'2013-02-20','16000.00','30');
INSERT INTO emp VALUES (7521,'Anvitha',7698,'2015-02-22','12500.00','30');
INSERT INTO emp VALUES (7566,'Tanvir',7839,'2008-04-02','29750.00','20');
INSERT INTO emp VALUES (7654,'Ramesh',7698,'2014-09-28','12500.00','30');
INSERT INTO emp VALUES (7698,'Kumar',7839,'2015-05-01','28500.00','30');
INSERT INTO incentives VALUES(7499,'2019-02-01',5000.00);
INSERT INTO incentives VALUES(7521,'2019-03-01',2500.00);
INSERT INTO incentives VALUES(7566,'2022-02-01',5070.00);
INSERT INTO incentives VALUES(7654,'2020-02-01',2000.00);
INSERT INTO incentives VALUES(7654,'2022-04-01',879.00);
INSERT INTO incentives VALUES(7521,'2019-02-01',8000.00);
INSERT INTO project VALUES(101,'AI Project','BENGALURU');
INSERT INTO project VALUES(102,'IOT','HYDERABAD');
INSERT INTO project VALUES(103,'BLOCKCHAIN','BENGALURU');
INSERT INTO project VALUES(104,'DATA SCIENCE','MYSURU');
INSERT INTO project VALUES(105,'AUTONOMUS SYSTEMS','PUNE');
INSERT INTO project values(106,'MACHINE LEARNING','MYSURU');
INSERT INTO assigned_to VALUES(7499,101,'Software Engineer');
INSERT INTO assigned_to VALUES(7521,101,'Software Architect');
INSERT INTO assigned_to VALUES(7566,101,'Project Manager');
INSERT INTO assigned_to VALUES(7654,102,'Sales');
INSERT INTO assigned_to VALUES(7521,102,'Software Engineer');
INSERT INTO assigned_to VALUES(7499,102,'Software Engineer');


-- LAB 5 PROGRAM
select e.empno
from emp e, assigned_to a, project p
where e.empno=a.empno and a.pno=p.pno and
p.ploc in ('Bengaluru','Hyderabad','Mysuru');

select e.empno from emp e left join incentives i on e.empno = i.empno where i.empno is NULL order by e.empno

select e.ename, e.empno , e.deptno , w.job_role , d.dloc as department_location ,p.ploc as project_location from emp e join dept d on e.deptno=d.deptno join assigned_to w on e.empno =w.empno join project p on w.pno = p.pno where d.dloc =p.ploc order by e.empno;

-- LAB 6 PROGRAM
SELECT m.ename, count(*)
FROM emp e,emp m
WHERE e.mgr_no = m.empno
GROUP BY m.ename
HAVING count(*) =(SELECT MAX(mycount)
from (SELECT COUNT(*) mycount
FROM emp
GROUP BY mgr_no) a);


SELECT *
FROM emp m
WHERE m.empno IN
(SELECT mgr_no
FROM emp)
AND m.sal >
(SELECT avg(e.sal)
FROM emp e
WHERE e.mgr_no = m.empno );

select distinct m.mgr_no from emp e,emp m
where e.mgr_no=m.mgr_no and e.deptno=m.deptno and e.empno in (
select distinct m.mgr_no from emp e,emp m
where e.mgr_no=m.mgr_no and e.deptno=m.deptno);

select *
from emp e,incentives i
where e.empno=i.empno and 2 = ( select count(*)
from incentives j
where i.incentive_amount <= j.incentive_amount );

SELECT *
FROM EMP E
WHERE E.DEPTNO = (SELECT E1.DEPTNO
FROM EMP E1
WHERE E1.EMPNO=E.MGR_NO);

