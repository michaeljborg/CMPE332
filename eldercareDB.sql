drop database if exists eldercare;
create database eldercare;
use eldercare;

create table room(
	number int not null primary key,
	occupancy int,
	phone char(10));


create table nurse(
	id int not null primary key,
	street varchar(60),
	city varchar(60),
	pc char(7),
	fname varchar(60),
	lname varchar(60),
	rank varchar(10));

create table doctor(
	id int not null primary key,
	street varchar(60),
	city varchar(60),
	pc char(7),
	fname varchar(60),
	lname varchar(60));

create table Helper(
	id int not null primary key,
	street varchar(60),
	city varchar(60),
	pc char(7),
	fname varchar(60),
	lname varchar(60),
	startDate date);
	
create table nurseSchedule(
	nurseId int not null,
	shiftDate date not null,
	start time,
	end time,
	primary key(nurseId, shiftDate),
	foreign key (nurseId) references nurse(id) on delete cascade);

create table resident(
	ohip varchar(15) not null primary key,
	dob date,
	fname varchar(60),
	lname varchar(60),
	spouseOhipId varchar(15) unique,
	roomNum int not null, 
	primaryCareDrId int not null,
	primaryCareSince date,
	helperId int not null,
	foreign key (spouseOhipId) references resident(ohip),
	foreign key (roomNum) references room (number),
	foreign key (primaryCareDrId) references doctor(id),
	foreign key (helperId) references helper(id));


create table nextOfKin(
	residentOhip varchar(15) not null,
	name varchar(120) not null,
	relationship varchar(20),
	primary key (residentOhip, name),
	foreign key (residentOhip) references resident(ohip) on delete cascade);
	
create table treats(
	residentOhip varchar(15) not null,
	doctorID int not null,
	primary key(residentOhip, doctorId),
	foreign key (residentOhip) references resident(ohip) on delete cascade,
	foreign key (doctorId) references doctor(id) on delete cascade);

create table drSpecialization(
	doctorId int not null,
	specialization varchar(60) not null,
	primary key (doctorId, specialization),
	foreign key (doctorId) references doctor(id) on delete cascade);

create table drPhone(
	doctorId int not null,
	phone char(10) not null,
	primary key (doctorId, phone),
	foreign key (doctorId) references doctor(id) on delete cascade);