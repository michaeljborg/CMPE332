DROP DATABASE IF EXISTS rentalDB;
CREATE DATABASE rentalDB;
USE rentalDB;

CREATE TABLE house(
    propertyID INT NOT NULL PRIMARY KEY,
    houseNumber INT NOT NULL,
    street VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    province VARCHAR(20) NOT NULL,
    postalCode VARCHAR(20) NOT NULL,
    listingDate DATE NOT NULL,
    rentCost INT NOT NULL,
    numOfBathroom INT NOT NULL,
    numOfBedrooms INT NOT NULL,
    laundry BOOLEAN NOT NULL,
    parking BOOLEAN NOT NULL,
    accessiblity BOOLEAN NOT NULL,
    fenced BOOLEAN NOT NULL,
    houseType VARCHAR(20) NOT NULL
    managerID INT,
    manageStartYear INT,
    groupID INT,
    leaseStart DATE,
    leaseEnd DATE,
    monthlyCost INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID);
    FOREIGN KEY (managerID) REFERENCES manager(ID) ON DELETE SET NULL
);

CREATE TABLE room(
    propertyID INT NOT NULL PRIMARY KEY,
    roomNumber INT NOT NULL,
    street VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    province VARCHAR(20) NOT NULL,
    postalCode VARCHAR(20) NOT NULL,
    listingDate DATE NOT NULL,
    rentCost INT NOT NULL,
    numOfBathroom INT NOT NULL,
    numOfBedrooms INT NOT NULL,
    laundry BOOLEAN NOT NULL,
    parking BOOLEAN NOT NULL,
    accessiblity BOOLEAN NOT NULL,
    kitchen BOOLEAN NOT NULL,
    numOfRoommates INT NOT NULL
    managerID INT,
    manageStartYear INT,
    groupID INT,
    leaseStart DATE,
    leaseEnd DATE,
    monthlyCost INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID);
    FOREIGN KEY (managerID) REFERENCES manager(ID) ON DELETE SET NULL
);

CREATE TABLE apartment(
    propertyID INT NOT NULL PRIMARY KEY,
    apartmentNumber INT NOT NULL,
    street VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    province VARCHAR(20) NOT NULL,
    postalCode VARCHAR(20) NOT NULL,
    listingDate DATE NOT NULL,
    rentCost INT NOT NULL,
    numOfBathroom INT NOT NULL,
    numOfBedrooms INT NOT NULL,
    laundry BOOLEAN NOT NULL,
    parking BOOLEAN NOT NULL,
    accessiblity BOOLEAN NOT NULL,
    floorNum INT NOT NULL,
    elevator BOOLEAN NOT NULL
    managerID INT,
    manageStartYear INT,
    groupID INT,
    leaseStart DATE,
    leaseEnd DATE,
    monthlyCost INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID);
    FOREIGN KEY (managerID) REFERENCES manager(ID) ON DELETE SET NULL
);

CREATE TABLE student(
    ID INT NOT NULL PRIMARY KEY,
    fname VARCHAR(60) NOT NULL,
    lname VARCHAR(60) NOT NULL,
    studentNumber INT NOT NULL UNIQUE,
    phoneNumber VARCHAR(20) NOT NULL,
    program VARCHAR(60) NOT NULL,
    expectedGradYear INT NOT NULL
    groupID INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID)
);

CREATE TABLE owner(
    ID INT NOT NULL PRIMARY KEY,
    fname VARCHAR(60) NOT NULL,
    lname VARCHAR(60) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE manager(
    ID INT NOT NULL PRIMARY KEY,
    fname VARCHAR(60) NOT NULL,
    lname VARCHAR(60) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE rentalGroup(
    groupID INT NOT NULL PRIMARY KEY,
);

CREATE TABLE preferences(
    groupID INT NOT NULL PRIMARY KEY,
    accessibility BOOLEAN,
    laundry BOOLEAN,
    parking BOOLEAN,
    numOfBathroom INT,
    numOfBedrooms INT,
    maxRent INT NOT NULL,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID) ON DELETE CASCADE
);

CREATE TABLE ownsProperty(
    ID INT NOT NULL,
    propertyID INT NOT NULL,
    propertyType ENUM('house', 'apartment', 'room') NOT NULL,
    PRIMARY KEY (ID, propertyID, propertyType),
    FOREIGN KEY (ID) REFERENCES owner(ID) ON DELETE CASCADE
);

CREATE TABLE roomFurnishing(
    furnishing varchar(100) NOT NULL,
    propertyID INT NOT NULL,
    PRIMARY KEY (propertyID, furnishing),
	FOREIGN KEY (propertyID) references room(propertyID) ON DELETE CASCADE
);