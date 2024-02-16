DROP DATABASE IF EXISTS rentalDB;
CREATE DATABASE rentalDB;
USE rentalDB;

CREATE TABLE rentalGroup(
    groupID INT NOT NULL PRIMARY KEY
);

CREATE TABLE manager(
    ID INT NOT NULL PRIMARY KEY,
    fname VARCHAR(60) NOT NULL,
    lname VARCHAR(60) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL
);

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
    houseType VARCHAR(20) NOT NULL,
    managerID INT,
    manageStartYear INT,
    groupID INT,
    leaseStart DATE,
    leaseEnd DATE,
    monthlyCost INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID),
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
    numOfRoommates INT NOT NULL,
    managerID INT,
    manageStartYear INT,
    groupID INT,
    leaseStart DATE,
    leaseEnd DATE,
    monthlyCost INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID),
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
    elevator BOOLEAN NOT NULL,
    managerID INT,
    manageStartYear INT,
    groupID INT,
    leaseStart DATE,
    leaseEnd DATE,
    monthlyCost INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID),
    FOREIGN KEY (managerID) REFERENCES manager(ID) ON DELETE SET NULL
);

CREATE TABLE student(
    ID INT NOT NULL PRIMARY KEY,
    fname VARCHAR(60) NOT NULL,
    lname VARCHAR(60) NOT NULL,
    studentNumber INT NOT NULL UNIQUE,
    phoneNumber VARCHAR(20) NOT NULL,
    program VARCHAR(60) NOT NULL,
    expectedGradYear INT NOT NULL,
    groupID INT,
    FOREIGN KEY (groupID) REFERENCES rentalGroup(groupID)
);

CREATE TABLE owner(
    ID INT NOT NULL PRIMARY KEY,
    fname VARCHAR(60) NOT NULL,
    lname VARCHAR(60) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL
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
    furnishing VARCHAR(20) NOT NULL,
    propertyID INT NOT NULL,
    PRIMARY KEY (propertyID, furnishing),
	FOREIGN KEY (propertyID) references room(propertyID) ON DELETE CASCADE
);

INSERT INTO rentalGroup (groupID) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18);

INSERT INTO manager (ID, fname, lname, phoneNumber) VALUES 
(101, 'John', 'Doe', '123-456-7890'),
(102, 'Jane', 'Smith', '234-567-8901'),
(103, 'Alex', 'Johnson', '345-678-9012'),
(104, 'Emma', 'Williams', '456-789-0123'),
(105, 'Olivia', 'Brown', '567-890-1234'),
(106, 'Liam', 'Davis', '678-901-2345');


INSERT INTO house (propertyID, houseNumber, street, city, province, postalCode, listingDate, rentCost, numOfBathroom, numOfBedrooms, laundry, parking, accessiblity, fenced, houseType, managerID, manageStartYear, groupID, leaseStart, leaseEnd, monthlyCost) VALUES 
(201, 10, 'Maple St', 'Townsville', 'ON', 'A1B 2C3', '2023-01-01', 1200, 1, 3, TRUE, TRUE, FALSE, TRUE, 'Detached', 101, 2022, 1, '2023-02-01', '2024-01-31', 1200),
(202, 20, 'Oak Ave', 'Lakeside', 'BC', 'B2C 3D4', '2023-02-15', 1500, 2, 4, TRUE, TRUE, TRUE, FALSE, 'Semi-Detached', 102, 2022, 2, '2023-03-01', '2024-02-28', 1500),
(203, 30, 'Pine Rd', 'Hilltop', 'AB', 'C3D 4E5', '2023-03-10', 1000, 1, 2, FALSE, FALSE, FALSE, FALSE, 'Townhouse', 103, 2023, 3, '2023-04-01', '2024-03-31', 1000),
(204, 40, 'Cedar Lane', 'Greenwood', 'QC', 'E3F 4G5', '2023-04-01', 1300, 2, 3, TRUE, TRUE, TRUE, TRUE, 'Detached', 104, 2023, 4, '2023-05-01', '2024-04-30', 1300),
(205, 50, 'Willow Way', 'Silverton', 'NB', 'F4G 5H6', '2023-05-10', 1100, 1, 2, FALSE, TRUE, FALSE, TRUE, 'Semi-Detached', 105, 2023, 5, '2023-06-01', '2024-05-31', 1100),
(206, 60, 'Maple Drive', 'Riverdale', 'NS', 'G5H 6I7', '2023-06-15', 1400, 2, 4, TRUE, FALSE, TRUE, FALSE, 'Townhouse', 106, 2023, 6, '2023-07-01', '2024-06-30', 1400);

INSERT INTO room (propertyID, roomNumber, street, city, province, postalCode, listingDate, rentCost, numOfBathroom, numOfBedrooms, laundry, parking, accessiblity, kitchen, numOfRoommates, managerID, manageStartYear, groupID, leaseStart, leaseEnd, monthlyCost) VALUES 
(301, 1, 'Elm Street', 'Townsville', 'ON', 'E1F 2G3', '2023-02-20', 500, 1, 1, TRUE, FALSE, TRUE, TRUE, 2, 101, 2023, 7, '2023-03-01', '2024-02-28', 500),
(302, 2, 'Birch Road', 'Lakeside', 'BC', 'F2G 3H4', '2023-03-15', 550, 1, 1, FALSE, TRUE, FALSE, TRUE, 3, 102, 2023, 8, '2023-04-01', '2024-03-31', 550),
(303, 3, 'Cedar Lane', 'Hilltop', 'AB', 'G3H 4I5', '2023-04-10', 450, 1, 1, TRUE, FALSE, TRUE, FALSE, 1, 103, 2023, 9, '2023-05-01', '2024-04-30', 450),
(304, 4, 'Oak Avenue', 'Greenwood', 'QC', 'H4I 5J6', '2023-05-05', 600, 1, 1, FALSE, TRUE, TRUE, TRUE, 4, 104, 2023, 10, '2023-06-01', '2024-05-31', 600),
(305, 5, 'Pine Street', 'Silverton', 'NB', 'I5J 6K7', '2023-06-01', 480, 1, 1, TRUE, FALSE, FALSE, TRUE, 2, 105, 2023, 11, '2023-07-01', '2024-06-30', 480),
(306, 6, 'Maple Way', 'Riverdale', 'NS', 'J6K 7L8', '2023-07-10', 530, 1, 1, FALSE, TRUE, TRUE, FALSE, 3, 106, 2023, 12, '2023-08-01', '2024-07-31', 530);

INSERT INTO apartment (propertyID, apartmentNumber, street, city, province, postalCode, listingDate, rentCost, numOfBathroom, numOfBedrooms, laundry, parking, accessiblity, floorNum, elevator, managerID, manageStartYear, groupID, leaseStart, leaseEnd, monthlyCost) VALUES 
(401, 101, 'Willow Park', 'Townsville', 'ON', 'K7L 8M9', '2023-02-25', 800, 1, 2, TRUE, TRUE, FALSE, 5, TRUE, 101, 2023, 13, '2023-03-15', '2024-03-14', 800),
(402, 102, 'Spruce Heights', 'Lakeside', 'BC', 'L8M 9N0', '2023-03-30', 850, 1, 2, FALSE, TRUE, TRUE, 3, FALSE, 102, 2023, 14, '2023-04-15', '2024-04-14', 850),
(403, 103, 'Chestnut Terrace', 'Hilltop', 'AB', 'M9N 0P1', '2023-04-20', 780, 1, 1, TRUE, FALSE, TRUE, 8, TRUE, 103, 2023, 15, '2023-05-15', '2024-05-14', 780),
(404, 104, 'Aspen Square', 'Greenwood', 'QC', 'N0P 1Q2', '2023-05-10', 900, 2, 3, TRUE, TRUE, FALSE, 12, FALSE, 104, 2023, 16, '2023-06-16', '2024-06-15', 1020),
(405, 105, 'Birch Plaza', 'Silverton', 'NB', 'O1Q 2R3', '2023-05-25', 920, 2, 3, FALSE, TRUE, TRUE, 2, TRUE, 105, 2023, 17, '2023-06-15', '2024-06-14', 920),
(406, 106, 'Maple Gardens', 'Riverdale', 'NS', 'P2R 3S4', '2023-06-05', 870, 1, 2, TRUE, FALSE, FALSE, 6, FALSE, 106, 2023, 18, '2023-07-01', '2024-06-30', 870);

INSERT INTO owner (ID, fname, lname, phoneNumber) VALUES 
(201, 'Michael', 'Roberts', '800-555-0101'),
(202, 'Sara', 'Johnson', '800-555-0102'),
(203, 'Daniel', 'Lee', '800-555-0103'),
(204, 'Jessica', 'Garcia', '800-555-0104'),
(205, 'James', 'Wilson', '800-555-0105'),
(206, 'Emily', 'Martinez', '800-555-0106'),
(207, 'David', 'Anderson', '800-555-0107'),
(208, 'Laura', 'Taylor', '800-555-0108');

INSERT INTO ownsProperty (ID, propertyID, propertyType) VALUES 
(201, 201, 'house'),
(201, 301, 'room'),
(202, 202, 'house'),
(202, 302, 'room'),
(203, 203, 'house'),
(203, 303, 'room'),
(204, 204, 'house'),
(204, 304, 'room'),
(205, 205, 'house'),
(205, 305, 'room'),
(206, 206, 'house'),
(206, 306, 'room'),
(207, 401, 'apartment'),
(207, 402, 'apartment'),
(208, 403, 'apartment'),
(208, 404, 'apartment'),
(201, 405, 'apartment'),
(202, 406, 'apartment');

INSERT INTO student (ID, fname, lname, studentNumber, phoneNumber, program, expectedGradYear, groupID) VALUES 
(101, 'Alex', 'Turner', 1001, '900-555-0001', 'Computer Science', 2024, 1),
(102, 'Casey', 'Smith', 1002, '900-555-0002', 'Business Administration', 2025, 2),
(103, 'Jordan', 'Lee', 1003, '900-555-0003', 'Mechanical Engineering', 2023, 3),
(104, 'Morgan', 'Davis', 1004, '900-555-0004', 'Biology', 2024, 4),
(105, 'Taylor', 'Garcia', 1005, '900-555-0005', 'Political Science', 2025, 5),
(106, 'Jamie', 'Wilson', 1006, '900-555-0006', 'English Literature', 2023, 6),
(107, 'Casey', 'Brown', 1007, '900-555-0007', 'Psychology', 2024, 7),
(108, 'Alexis', 'Martinez', 1008, '900-555-0008', 'Physics', 2025, 8),
(109, 'Jordan', 'Anderson', 1009, '900-555-0009', 'Chemistry', 2023, 9),
(110, 'Morgan', 'Thomas', 1010, '900-555-0010', 'Mathematics', 2024, 10),
(111, 'Taylor', 'Jackson', 1011, '900-555-0011', 'Economics', 2025, 11),
(112, 'Jamie', 'White', 1012, '900-555-0012', 'Art History', 2023, 12),
(113, 'Casey', 'Lopez', 1013, '900-555-0013', 'Environmental Science', 2024, 13),
(114, 'Alexis', 'Harris', 1014, '900-555-0014', 'Sociology', 2025, 14),
(115, 'Jordan', 'Clark', 1015, '900-555-0015', 'Information Technology', 2023, 15),
(116, 'Morgan', 'Lewis', 1016, '900-555-0016', 'Nursing', 2024, 16),
(117, 'Taylor', 'Robinson', 1017, '900-555-0017', 'Civil Engineering', 2025, 17),
(118, 'Jamie', 'Walker', 1018, '900-555-0018', 'Graphic Design', 2023, 18),
(119, 'Sam', 'Evans', 1019, '900-555-0019', 'Marketing', 2025, 2),
(120, 'Riley', 'Khan', 1020, '900-555-0020', 'Accounting', 2023, 2),
(121, 'Jordan', 'Patel', 1021, '900-555-0021', 'Fine Arts', 2024, 4),
(122, 'Charlie', 'Nguyen', 1022, '900-555-0022', 'History', 2025, 4),
(123, 'Dakota', 'Murphy', 1023, '900-555-0023', 'Software Engineering', 2023, 5),
(124, 'Alex', 'Kim', 1024, '900-555-0024', 'Biology', 2024, 7),
(125, 'Casey', 'Yoshida', 1025, '900-555-0025', 'Physics', 2025, 8),
(126, 'Eli', 'Thompson', 1026, '900-555-0026', 'Anthropology', 2023, 9),
(127, 'Zoe', 'Fernandez', 1027, '900-555-0027', 'International Relations', 2024, 10),
(128, 'Aiden', 'Wu', 1028, '900-555-0028', 'Environmental Studies', 2025, 11),
(129, 'Brooklyn', 'Patel', 1029, '900-555-0029', 'Public Health', 2023, 12),
(130, 'Connor', 'Murphy', 1030, '900-555-0030', 'Architecture', 2024, 13),
(131, 'Isabella', 'Gonzalez', 1031, '900-555-0031', 'Art and Design', 2025, 14);

INSERT INTO preferences (groupID, accessibility, laundry, parking, numOfBathroom, numOfBedrooms, maxRent) VALUES 
(1, FALSE, TRUE, TRUE, 1, 2, 1200),
(2, TRUE, FALSE, TRUE, 1, 1, 1000),
(3, FALSE, TRUE, FALSE, 2, 3, 1500),
(4, TRUE, TRUE, TRUE, 2, 2, 1300),
(5, FALSE, FALSE, TRUE, 1, 3, 1100),
(6, TRUE, TRUE, FALSE, 1, 1, 900),
(7, FALSE, TRUE, TRUE, 2, 2, 1400),
(8, TRUE, FALSE, TRUE, 1, 2, 950),
(9, FALSE, TRUE, FALSE, 1, 1, 800),
(10, TRUE, TRUE, TRUE, 2, 3, 1600),
(11, FALSE, FALSE, TRUE, 1, 2, 850),
(12, TRUE, TRUE, FALSE, 1, 1, 700),
(13, FALSE, TRUE, TRUE, 2, 4, 1800),
(14, TRUE, FALSE, FALSE, 1, 3, 1200),
(15, FALSE, TRUE, TRUE, 1, 2, 1300),
(16, TRUE, TRUE, TRUE, 2, 2, 1500),
(17, FALSE, FALSE, TRUE, 1, 1, 800),
(18, TRUE, TRUE, FALSE, 2, 3, 1700);

INSERT INTO roomFurnishing (furnishing, propertyID) VALUES 
('Desk', 301),
('Chair', 301),
('Bed', 301),
('Wardrobe', 301),
('Bookshelf', 301),
('Desk Lamp', 301),
('Desk', 302),
('Chair', 302),
('Bed', 302),
('Wardrobe', 302),
('Curtains', 302),
('Desk Lamp', 302),
('Desk', 303),
('Chair', 303),
('Bed', 303),
('Dresser', 303),
('Nightstand', 303),
('Desk Lamp', 303),
('Desk', 304),
('Chair', 304),
('Bed', 304),
('Wardrobe', 304),
('Bookshelf', 304),
('Desk Lamp', 304),
('Desk', 305),
('Chair', 305),
('Bed', 305),
('Dresser', 305),
('Curtains', 305),
('Desk Lamp', 305),
('Desk', 306),
('Chair', 306),
('Bed', 306),
('Wardrobe', 306),
('Nightstand', 306),
('Desk Lamp', 306);
