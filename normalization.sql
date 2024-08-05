create database AutomotiveDB;

use AutomotiveDB;

/* Unnormalized */
CREATE TABLE UnnormalizedCars (
    CarID INT,
    CarModel VARCHAR(100),
    OwnerName VARCHAR(100),
    OwnerAddress VARCHAR(255),
    OwnerPhone VARCHAR(20),
    ServiceDates VARCHAR(255),
    ServiceDescriptions VARCHAR(255),
    TotalServiceCost DECIMAL(10, 2)
);

INSERT INTO UnnormalizedCars VALUES
(1, 'Toyota Camry', 'John Doe', '123 Elm St', '555-1234', '2021-01-10,2021-06-15', 'Oil Change,Tire Rotation', 150.00),
(2, 'Honda Accord', 'Alice Johnson', '456 Oak St', '555-8765', '2021-02-20,2021-08-30', 'Brake Inspection,Battery Replacement', 200.00),
(3, 'Ford Focus', 'Chris Evans', '789 Pine St', '555-6789', '2021-03-15', 'Transmission Repair', 500.00),
(4, 'Chevrolet Malibu', 'Emily Davis', '101 Maple St', '555-9876', '2021-04-25,2021-09-10', 'Engine Tune-Up,Alignment', 300.00),
(5, 'Nissan Altima', 'David Wilson', '202 Birch St', '555-2468', '2021-05-05,2021-11-20', 'Oil Change,Brake Replacement', 250.00),
(6, 'Hyundai Elantra', 'Susan Clark', '304 Cherry St', '555-3322', '2021-04-20,2021-10-10', 'Oil Change,Air Filter', 130.00),
(7, 'BMW 320i', 'Michael Brown', '987 Walnut St', '555-7788', '2021-02-28,2021-08-05', 'Brake Inspection,Transmission Repair', 650.00),
(8, 'Audi A4', 'Jennifer Lopez', '402 Cedar St', '555-9988', '2021-03-22,2021-09-12', 'Battery Replacement,Tire Rotation', 200.00),
(9, 'Mercedes C-Class', 'Robert King', '123 Oak St', '555-5544', '2021-05-18,2021-12-01', 'Engine Tune-Up,Alignment', 450.00),
(10, 'Volkswagen Passat', 'Emily Johnson', '456 Pine St', '555-1239', '2021-06-10,2021-11-20', 'Oil Change,Brake Replacement', 300.00);

drop table UnnormalizedCars;
delete from UnnormalizedCars;
select * from UnnormalizedCars;

/*First Normal Form */
/* Each row should contain unique value */
create table Cars1NF(
	CarID INT,
    CarModel VARCHAR(100),
    OwnerName VARCHAR(100),
    OwnerAddress VARCHAR(255),
    OwnerPhone VARCHAR(20),
    primary key (CarID)); 

create table Services1NF(
	ServiceID INT,
    CarID INT,
	ServiceDates VARCHAR(255),
    ServiceDescriptions VARCHAR(255),
    TotalServiceCost DECIMAL(10, 2),
    primary key(ServiceID),
    foreign key(CarID)REFERENCES Cars1NF(CarID)
);

/* Second Normal Form*/
create table owners(
	OwnerID INT,
    OwnerName VARCHAR(100),
    OwnerAddress VARCHAR(255),
    OwnerPhone VARCHAR(20),
    primary key(OwnerID)
);

create table Cars2NF(
	CarID INT,
    CarModel VARCHAR(100),
    OwnerID INT,
    primary key (CarID),
    foreign key (OwnerID) REFERENCES owners(OwnerID)
    ); 

create table Services2NF(
	ServiceID INT,
    CarID INT REFERENCES Cars2NF(CarID),
	ServiceDates VARCHAR(255),
    ServiceDescriptions VARCHAR(255),
    TotalServiceCost DECIMAL(10, 2),
    primary key(ServiceID)
);

/* Third Normal Form*/
    
create table ServiceTypes(
ServiceTypeID INT,
ServiceDescription VARCHAR(255),
ServiceCost INT,
primary key (ServiceTypeID)
);

create table Services3NF(
	ServiceID INT,
    CarID INT,
    ServiceDate VARCHAR(255),
    ServiceTypeID INT,
    primary key(ServiceID),
    foreign key(CarID) references Cars2NF(CarID),
    foreign key(ServiceTypeID) references ServiceTypes(ServiceTypeID)
 );
 
 /* Insert Statements */
 INSERT INTO Owners (OwnerID, OwnerName, OwnerAddress, OwnerPhone) VALUES
(1, 'John Doe', '123 Elm St', '555-1234'),
(2, 'Alice Johnson', '456 Oak St', '555-8765'),
(3, 'Chris Evans', '789 Pine St', '555-6789'),
(4, 'Emily Davis', '101 Maple St', '555-9876'),
(5, 'David Wilson', '202 Birch St', '555-2468'),
(6, 'Susan Clark', '304 Cherry St', '555-3322'),
(7, 'Michael Brown', '987 Walnut St', '555-7788'),
(8, 'Jennifer Lopez', '402 Cedar St', '555-9988'),
(9, 'Robert King', '123 Oak St', '555-5544'),
(10, 'Emily Johnson', '456 Pine St', '555-1239');

INSERT INTO Cars2NF (CarID, CarModel, OwnerID) VALUES
(1, 'Toyota Camry', 1),
(2, 'Honda Accord', 2),
(3, 'Ford Focus', 3),
(4, 'Chevrolet Malibu', 4),
(5, 'Nissan Altima', 5),
(6, 'Hyundai Elantra', 6),
(7, 'BMW 320i', 7),
(8, 'Audi A4', 8),
(9, 'Mercedes C-Class', 9),
(10, 'Volkswagen Passat', 10);

INSERT INTO ServiceTypes (ServiceTypeID, ServiceDescription, ServiceCost) VALUES
(1, 'Oil Change', 50.00),
(2, 'Tire Rotation', 100.00),
(3, 'Brake Inspection', 100.00),
(4, 'Battery Replacement', 100.00),
(5, 'Transmission Repair', 500.00),
(6, 'Engine Tune-Up', 150.00),
(7, 'Alignment', 150.00),
(8, 'Brake Replacement', 200.00);

INSERT INTO Services3NF (ServiceID, CarID, ServiceDate, ServiceTypeID) VALUES
(1,1, '2021-01-10', 1),
(2,1, '2021-06-15', 2),
(3,2, '2021-02-20', 3),
(4,2, '2021-08-30', 4),
(5,3, '2021-03-15', 5),
(6,4, '2021-04-25', 6),
(7,4, '2021-09-10', 7),
(8,5, '2021-05-05', 1),
(9,5, '2021-11-20', 8),
(10,6, '2021-04-20', 1),
(11,6, '2021-10-10', 6),
(12,7, '2021-02-28', 3),
(13,7, '2021-08-05', 5),
(14,8, '2021-03-22', 4),
(15,8, '2021-09-12', 2),
(16,9, '2021-05-18', 6),
(17,9, '2021-12-01', 7),
(18,10, '2021-06-10', 1),
(19,10, '2021-11-20', 8);

/* Select Statements */
-- Query the Cars2NF table to retrieve car information
SELECT * FROM Cars2NF;

-- Query the Owners table to retrieve owner information
SELECT * FROM Owners;

-- Query the Services3NF table to retrieve service history
SELECT * FROM Services3NF;

-- Query the ServiceTypes table to retrieve service type information
SELECT * FROM ServiceTypes; 
