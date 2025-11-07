create table persons (driver_id varchar(10),
name varchar(20), addresss varchar(30), primary key(driver_id));
create table cars(reg_num varchar(10),model varchar(10),year int, primary
key(reg_num));
create table accidentss(report_num int, accident_date date, location
varchar(20),primary key(report_num));
create table ownss(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references persons(driver_id),
foreign key(reg_num) references cars(reg_num));
create table participateds(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int,
primary key(driver_id, reg_num, report_num),
foreign key(driver_id) references persons(driver_id),
foreign key(reg_num) references cars(reg_num),
foreign key(report_num) references accidentss(report_num));
insert into accidentss values (11, '2003-01-01','Mysore Road');
insert into accidentss values (12, '2004-02-02','South end Circle');
insert into accidentss values (13,'2003-01-21','Bull temple Road');
insert into accidentss values (14,'2008-02-17','Mysore Road');
insert into accidentss values (15,'2004-03-05','Kanakpura Road');
insert into persons values('A01','Richard','Srinivas nagar');
insert into persons values('A02','Pradeep','Rajaji nagar');
insert into persons values('A03','Smith','Ashok nagar');
insert into persons values('A04','Venu','N R Colony');
insert into persons values('A05','Jhon','Hanumanth nagar');
insert into cars values('KA052250','Indica',1990);
insert into cars values('KA031181','Lancer',1957);
insert into cars values('KA053408','honda',1957);
insert into cars values('KA095477','Toyota',2008);
insert into cars values('KA041702','Audi',2004);
insert into ownss values ('A01', 'KA052250');
insert into ownss values ('A02', 'KA053408');
insert into ownss values ('A03', 'KA031181');
insert into ownss values ('A04', 'KA095477');
insert into ownss values ('A05', 'KA041702');
insert into participateds values('A01','KA052250',11,10000);
insert into participateds values('A02','KA053408',12,10000);
insert into participateds values('A03','KA031181',13,10000);
insert into participateds values('A04','KA095477',14,10000);
insert into participateds values('A05','KA041702',15,10000);

SELECT * FROM PARTICIPATEDS ORDER BY DAMAGE_AMOUNT DESC;
SELECT AVG(DAMAGE_AMOUNT) FROM PARTICIPATEDS;
DELETE FROM PARTICIPATED WHERE DAMAGE_AMOUNTT<(SELECT AVG (DAMAGE_AMOUNT) FROM PARTICIPATED); 
select * from participateds;

SELECT NAME FROM PERSON A, PARTICIPATED B WHERE A.DRIVER_ID = B.DRIVER_ID AND DAMAGE_AMOUNT>(SELECT AVG(DAMAGE_AMOUNT) FROM PARTICIPATED);
SELECT MAX(DAMAGE_AMOUNT) FROM PARTICIPATED;