drop database if exists pet;
create database pet;
use pet;

create table Person(
	fname varchar(60) not null,
	lname varchar(60) not null,
	street varchar(255),
	city varchar(255),
	province char(2),
	pc char(7),
	primary key (fname, lname));
	


create table Shelter(
	name varchar(255) not null,
	city varchar(255) not null,
	primary key(name, city));


create table Caretaker(
	phone varchar(10) not null primary key,
	credential varchar(40) not null);

create table Pet(
	id int not null primary key,
	type varchar(255),
	caretakerPhone char(10) not null unique,
	caretakerStart date,
	foreign key (caretakerPhone) references Caretaker (phone));

create table WeightInfo(
	petId int not null,  
	weighdate date not null,
	weight decimal(4,2) not null,
	primary key(petId, weighdate),
	foreign key (petId) references pet(id) on delete cascade);
 
create table PetColour(
	petId int not null,
	colour varchar(40) not null,
	primary key (petId, colour),
	foreign key (petId) references pet(id) on delete cascade);

create table CaretakerShelter(
	cphone varchar(10) not null,
	sName varchar(255) not null,
	sCity varchar(255) not null,
	primary key (cphone, sName, sCity),
	foreign key (cphone) references Caretaker (phone) on delete cascade,
	foreign key (sName, sCity) references Shelter (name, city) on delete cascade);


create table adopt(
	petId int not null,
	fname varchar(60) not null,
	lname varchar(60) not null,
	sname varchar(255) not null,
	scity varchar(255) not null,
	primary key(petId, fname, lname, sname, scity),
	foreign key (petId) references pet (id) on delete cascade,
	foreign key (fname, lname) references person(fname, lname) on delete cascade,
	foreign key (sname, scity) references shelter (name, city) on delete cascade);