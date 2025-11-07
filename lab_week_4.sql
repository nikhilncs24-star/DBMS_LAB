create table branch(
Branch_name varchar(30),
Branch_city varchar(25),
assets int,
PRIMARY KEY (Branch_name)
);
create table BankAccount(
Accno int,
Branch_name varchar(30),
Balance int,
PRIMARY KEY(Accno),
foreign key (Branch_name) references branch(Branch_name)
);
create table BankCustomer(
Customername varchar(20),
Customer_street varchar(30),
CustomerCity varchar (35),
PRIMARY KEY(Customername)
);
create table Depositer(
Customername varchar(20),
Accno int,
PRIMARY KEY(Customername,Accno),

foreign key (Accno) references BankAccount(Accno),
foreign key (Customername) references BankCustomer(Customername)
);
create table Loan(
Loan_number int,
Branch_name varchar(30),
Amount int,
PRIMARY KEY(Loan_number),
foreign key (Branch_name) references branch(Branch_name)
);

insert into branch values("SBI_Chamrajpet","Bangalore",50000);
insert into branch values("SBI_ResidencyRoad","Bangalore",10000);
insert into branch values("SBI_ShivajiRoad","Bombay",20000);
insert into branch values("SBI_ParlimentRoad","Delhi",10000);
insert into branch values("SBI_Jantarmantar","Delhi",20000);

insert into BankAccount values(1,"SBI_Chamrajpet",2000);
insert into BankAccount values(2,"SBI_ResidencyRoad",5000);
insert into BankAccount values(3,"SBI_ShivajiRoad",6000);
insert into BankAccount values(4,"SBI_ParlimentRoad",9000);
insert into BankAccount values(5,"SBI_Jantarmantar",8000);
insert into BankAccount values(6,"SBI_ShivajiRoad",4000);
insert into BankAccount values(8,"SBI_ResidencyRoad",4000);
insert into BankAccount values(9,"SBI_ParlimentRoad",3000);
insert into BankAccount values(10,"SBI_ResidencyRoad",5000);
insert into BankAccount values(11,"SBI_Jantarmantar",2000);

insert into BankCustomer values("Avinash","Bull_Temple_Road","Bangalore");
insert into BankCustomer values("Dinesh","Bannergatta_Road","Bangalore");
insert into BankCustomer values("Mohan","NationalCollege_Road","Bangalore");
insert into BankCustomer values("Nikil","Akbar_Road","Delhi");
insert into BankCustomer values("Ravi","Prithviraj_Road","Delhi");

select * from BankCustomer;

insert into Depositer values("Avinash",1);
insert into Depositer values("Dinesh",2);
insert into Depositer values("Nikil",4);
insert into Depositer values("Ravi",5);
insert into Depositer values("Avinash",8);
insert into Depositer values("Nikil",9);
insert into Depositer values("Dinesh",10);
insert into Depositer values("Nikil",11);

insert into LOAN values(1,'SBI_Chamrajpet',1000);
insert into LOAN values(2,'SBI_ResidencyRoad',2000);
insert into LOAN values(3,'SBI_ShivajiRoad',3000);
insert into LOAN values(4,'SBI_ParliamentRoad',4000);
insert into LOAN values(5,'SBI_Jantarmantar',5000);

create table Borrower (Customername varchar(20), loan_number int, 
foreign key (Customername) references bankcustomer(Customername),
foreign key (loan_number) references LOAN(Loan_number));

insert into Borrower values('Avinash',1);
insert into Borrower values('Dinesh',2);
insert into Borrower values('Mohan',3);
insert into Borrower values('Nikil',4);
insert into Borrower values('Ravi',5)

SELECT d.Customername
From BankAccount a,branch b, Depositer d
WHERE b.Branch_name=a.Branch_name AND
a.Accno=d.Accno AND
b.Branch_city='Delhi'
GROUP BY d.Customername
HAVING COUNT(distinct b.Branch_name)=(SELECT COUNT(Branch_name)FROM branch
WHERE Branch_city='Delhi');

select distinct Customername
from borrower
where Customername not in (select Customername
from Depositer);

Select Customername
From borrower ,Loan 
Where borrower.Loan_number=Loan.Loan_number
and Loan.Branch_name in (select Branch_name
from Depositer,BankAccount
where Depositer.Accno = BankAccount.Accno And BankAccount.Branch_name in
 (Select Branch_name from branch WHERE branch.Branch_city='Bangalore')); 


Select Branch_name From branch
Where assets>(Select Sum(assets) from branch Where Branch_city='Bangalore');

DELETE FROM BankAccount WHERE branch_name IN(SELECT Branch_name FROM branch WHERE Branch_city='Bombay');
delete from Depositer
where Accno in
 (select Accno
 from Branch, BankAccount
 where Branch_city = 'Bombay'
 and branch.Branch_name = BankAccount.Branch_name);

update BankAccount
set Balance = Balance * 1.05