use CRM;
create table USER(
ID varchar(200),
name varchar(200),
phone char(8),
address varchar(200),
email varchar(200),
primary key(ID));

create table Salesman(
u_id varchar(200),
hiredate date,
primary key(u_id),
foreign key(u_id) references USER(ID)
on delete cascade
on update cascade
);

create table customer(
uid varchar(200),
birthdate varchar(200),
primary key(uid),
foreign key(uid) references USER(ID)
on delete cascade
on update cascade
);

create table role(
r_id varchar(200),
description varchar(200),
r_name varchar(200),
primary key(r_id)
);

create table HAS(
user_id varchar(200),
role_id varchar(200),
primary key(user_id,role_id),
foreign key(user_id) references USER(ID),
foreign key(role_id) references role(r_id)
on delete cascade
on update cascade
);

create table LOGIN (
username varchar(200),
password varchar(200),
primary key(username)
);

create table permission(
perm_id varchar(200),
perm_name varchar(200),
module varchar(200),
uid varchar(200),
primary key(perm_id),
foreign key(uid) references USER(ID)
on delete cascade
on update cascade
);

create table can(
uid varchar(200),
L_username varchar(200),
primary key(uid,L_username),
foreign key(uid) references USER(ID),
foreign key(L_username) references LOGIN(username)
on delete cascade
on update cascade
 );

create table product(
p_id varchar(200),
p_number varchar(200),
item varchar(200),
type varchar(200),
p_desc varchar(200),
uid varchar(200),
primary key(p_id,p_number),
foreign key(uid) references salesman(u_id)
on delete cascade
on update cascade
);

create table purchase(
prod_id varchar(200),
prod_num varchar(200),
uid varchar(200),
primary key (prod_id,prod_num,uid),
foreign key(prod_id,prod_num) references product(p_id,p_number),
foreign key(uid) references customer(uid)
on update cascade
on delete cascade
);

create table schedule(
sch_id varchar(200),
sch_type varchar(200),
sch_desc varchar(200),
uid varchar(200),
primary key (sch_id),
foreign key(uid) references salesman(u_id)
on update cascade
on delete cascade
);

/*FORMAT OF THE FOLLOWING INSERTIONS:
  INSERTS....
  TABLE VISUALIZATION
 */

INSERT INTO USER VALUES (12345, 'Karim A', '72840244', 'Beirut', 'karim_a@hotmail.com'); /* customer */
INSERT INTO USER VALUES (12346, 'Jean L', '72853436', 'Beirut', 'jean_l@hotmail.com'); /* customer */
INSERT INTO USER VALUES (12348, 'Shadi R', '72840225', 'Saida', 'shadi_r@hotmail.com'); /* customer */
INSERT INTO USER VALUES (12349, 'Rami S', '72840234', 'Jounieh', 'rami_s@hotmail.com'); /* customer */
INSERT INTO USER VALUES (12350, 'Anthony K', '72840254', 'Zouk Mikhael', 'anthony_k@CompanyName.com');
INSERT INTO USER VALUES (12351, 'Joe M', '72846244', 'Jbeil', 'joe_m@CompanyName.com');
INSERT INTO USER VALUES (12332, 'Antonios Z', '72846234', 'beirut', 'antonios_z@CompanyName.com');
INSERT INTO USER VALUES (12151, 'Will S', '72845464', 'zahle', 'will_s@CompanyName.com');

SELECT * FROM USER;

INSERT INTO Salesman VALUES (12350, '2019-3-13');
INSERT INTO Salesman VALUES (12351, '2014-3-04');
INSERT INTO Salesman VALUES (12332, '2021-4-23');
INSERT INTO Salesman VALUES (12151, '2018-5-25');

SELECT * FROM Salesman;

INSERT INTO customer VALUES (12345, '2020-7-19');
INSERT INTO customer VALUES (12346, '2021-5-27');
INSERT INTO customer VALUES (12348, '2021-1-01');
INSERT INTO customer VALUES (12349, '2022-1-23');

SELECT * FROM customer;

INSERT INTO role VALUES (11, 'manager', 'monitoring the work in the company'); /*must have a high role such as administrator or head of...*/
INSERT INTO role VALUES (12, 'employee', 'perform his duties');
INSERT INTO role VALUES (13, 'foreigner', 'cannot enter the company');

SELECT * FROM role;
/* we have to give 2 people same role to show that 2 people can have same roles*/
INSERT INTO HAS VALUES (12350, 11);
INSERT INTO HAS VALUES (12351, 12);
INSERT INTO HAS VALUES (12332, 13);
INSERT INTO HAS VALUES (12151, 13);

SELECT * FROM HAS;

INSERT INTO LOGIN VALUES ('karim_a', 'KarimsABeast2030');
INSERT INTO LOGIN VALUES ('jean_l', 'jAmesBond23');
INSERT INTO LOGIN VALUES ('shadi_r', 'iLoveGym@');
INSERT INTO LOGIN VALUES ('rami_s', 'R20103012');
INSERT INTO LOGIN VALUES ('anthony_k', 'ABCD12345678');
INSERT INTO LOGIN VALUES ('joe_m', 'CRMfirstBreakLater9');
INSERT INTO LOGIN VALUES ('antonios_z', 'cArs203q2');
INSERT INTO LOGIN VALUES ('will_s', 'willSCRM1234@');

SELECT * FROM LOGIN;

INSERT INTO can VALUES (12345, 'karim_a');
INSERT INTO can VALUES (12346, 'jean_l');
INSERT INTO can VALUES (12348, 'shadi_r');
INSERT INTO can VALUES (12349, 'rami_s');
INSERT INTO can VALUES (12350, 'anthony_k');
INSERT INTO can VALUES (12351, 'joe_m');
INSERT INTO can VALUES (12332, 'antonios_z');
INSERT INTO can VALUES (12151, 'will_s');

SELECT * FROM can;

/*we'll have 3 types (add more if any new types came up) of permissions:
  admin: which will be for editing CRM codebase incase any extra features are needed to be added and manage permissions
  salesman or employeeL will be for data-entry and access to all customers' data but NOT codeBase
  customer: this permission lets customers to create their own account and enter their own data and access them, but prevent them from accessing other users' data (customers)
 */
INSERT INTO permission VALUES (81, 'Customer', 'Access to their own data - Inserting and Altering their own data', 12345);
INSERT INTO permission VALUES (82, 'Customer', 'Access to their own data - Inserting and Altering their own data', 12346);
INSERT INTO permission VALUES (83, 'Customer', 'Access to their own data - Inserting and Altering their own data', 12348);
INSERT INTO permission VALUES (84, 'Customer', 'Access to their own data - Inserting and Altering their own data', 12349);

INSERT INTO permission VALUES (91, 'admin', 'Edit permissions including theirs - May have access to codebase for adding features and tools extensions - Access to Salesmens Schedules', 12350);
INSERT INTO permission VALUES (92, 'salesman', 'Access to data - Inserting and Altering data of customers - Receive Visualized Reports (such as graphs) related to customers', 12351);
INSERT INTO permission VALUES (93, 'salesman', 'Access to data - Inserting and Altering data of customers - Receive Visualized Reports (such as graphs) related to customers', 12332);
INSERT INTO permission VALUES (94, 'salesman', 'Access to data - Inserting and Altering data of customers - Receive Visualized Reports (such as graphs) related to customers', 12151);

SELECT * FROM permission;

/*1 to 1: each salesman, EXCEPT administrator, manages the products*/
INSERT INTO product VALUES (2000, 1, 'BMW', 'Sport', 'M8 Competition', 12351);
INSERT INTO product VALUES (2001, 1, 'BMW', 'Sport', 'M8 Competition', 12351);
INSERT INTO product VALUES (2002, 31, 'Bentley', 'Luxury Sedan', 'Flying Spur', 12332);
INSERT INTO product VALUES (2003, 4, 'Mercedes', 'SUV', 'GLE63', 12151);

SELECT * FROM product;

INSERT INTO purchase VALUES (2000, 1, 12345);
INSERT INTO purchase VALUES (2001, 1, 12349);
INSERT INTO purchase VALUES (2003, 4, 12345);
INSERT INTO purchase VALUES (2002, 31, 12348); /*more than one customer can buy same type of product (not sure of if same prod num means same exact product, please recheck*/
/*I considered every product has its own p_id (each bmw m8 competition has its own id) and every product (of same concept or model) has its own p_num meaning that m8 competition cars have p_num have p_num 1)*/
/*customer with ID 12346 didn't buy anything*/
/*product with prod_id 2002 wasn't bought by anyone*/

SELECT * FROM purchase;


INSERT INTO schedule VALUES(130, 'Full Time', 'MTWRF - 9 to 5', 12350);
INSERT INTO schedule VALUES(131, 'Part Time', 'MTWRF - 1 to 5', 12351);
INSERT INTO schedule VALUES(132, 'Full Time', 'MTWRF - 9 to 5', 12332);
INSERT INTO schedule VALUES(133, 'Part Time', 'MTWRF - 9 to 1', 12151);

SELECT * FROM schedule;