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

insert into Depositer values("Avinash",1);
insert into Depositer values("Dinesh",2);
insert into Depositer values("Nikil",4);
insert into Depositer values("Ravi",5);
insert into Depositer values("Avinash",8);
insert into Depositer values("Nikil",9);
insert into Depositer values("Dinesh",10);
insert into Depositer values("Nikil",11);

insert into Loan values(1,"SBI_Chamrajpet",1000);
insert into Loan values(2,"SBI_ResidencyRoad",2000);
insert into Loan values(3,"SBI_ShivajiRoad",3000);
insert into Loan values(4,"SBI_ParlimentRoad",4000);
insert into Loan values(5,"SBI_Jantarmantar",5000);

select Branch_name, CONCAT(assets/100000,'lakhs')assets_in_lakhs
from branch; 

select d.Customername from Depositer d, BankAccount b where
b.Branch_name='SBI_ResidencyRoad' and d.Accno=b.Accno group by
d.Customername having count(d.Accno)>=2;

create view sum_of_loan
as select Branch_name, SUM(Balance)
from BankAccount
group by Branch_name;

select * from sum_of_loan;

select bc.Customername, CONCAT(Balance+1000,'rupees')
UPDATED_BALANCE from BankAccount b, BankCustomer bc, Depositer d
where bc.Customername=d.Customername and b.Accno=d.Accno and
bc.Customercity='Bangalore';