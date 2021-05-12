CREATE DATABASE northwind;
use northwind;

CREATE TABLE IF NOT EXISTS Categories (
	CategoryID INT(11) NOT NULL, 
	CategoryName VARCHAR(15) NOT NULL, 
	Description MEDIUMTEXT, 
	PRIMARY KEY(CategoryID)
);

INSERT INTO Categories VALUES 
(1, 'Beverages', 'Soft drinks coffee teas beers and ales'),
(2, 'Condiments', 'Sweet and savory relishes spreads and seasoning'),
(3, 'Confections', 'Desserts candies and sweet breads'),
(4, 'Dairy Products', 'Cheeses'),
(5, 'Grains/Cereals', 'Breads crackers pasta and cereal'),
(6, 'Meat/Poultry', 'Prepared meats'),
(7, 'Produce', 'Dried fruit and bean curd'),
(8, 'Seafood', 'Seaweed and fish');



CREATE TABLE IF NOT EXISTS Region(
	RegionID INT(11) NOT NULL, 
	RegionDescription VARCHAR(50) NOT NULL, 
	PRIMARY KEY(RegionID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/regions.csv'
INTO TABLE Region
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS Territories(
	TerritoryID VARCHAR(20) NOT NULL, 
	TerritoryDescription VARCHAR(50) NOT NULL, 
	RegionID INT(11) NOT NULL, 
	PRIMARY KEY (TerritoryID), 
	KEY `FK_Territories_Region` (RegionID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/territories.csv'
INTO TABLE Territories
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS EmployeeTerritories(
	EmployeeID INT(11) NOT NULL, 
	TerritoryID VARCHAR (20) NOT NULL, 
	PRIMARY KEY (EmployeeID, TerritoryID),
	KEY `FK_EmployeeTerritories_Territories` (TerritoryID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/employee-territories.csv'
INTO TABLE EmployeeTerritories
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS Employees(
	EmployeeID INT(11) NOT NULL, 
	LastName VARCHAR(20) NOT NULL, 
	FirstName VARCHAR(10) NOT NULL, 
	Title VARCHAR(30),
	TitleOfCourtesy VARCHAR(15), 
	BirthDate DATETIME, 
	HireDate DATETIME, 
	Address VARCHAR(60), 
	City VARCHAR(15),
	Region VARCHAR(15), 
	PostalCode VARCHAR(10), 
	Country VARCHAR(15), 
	HomePhone VARCHAR(24),
	Extension VARCHAR(4), 
	Notes MEDIUMTEXT NOT NULL, 
	ReportsTo INT(11) NOT NULL, 
	PhotoPath VARCHAR(255),
	Salary FLOAT, 
	PRIMARY KEY(EmployeeID),
	KEY `FK_Employees_Employees` (ReportsTo)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/employees.csv'
INTO TABLE Employees
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS Shippers(
	ShipperID INT(11) NOT NULL, 
	CompanyName VARCHAR(40) NOT NULL, 
	Phone VARCHAR(24),
	PRIMARY KEY(ShipperID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/shippers.csv'
INTO TABLE Shippers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS Orders(
	OrderID INT(11) NOT NULL, 
	CustomerID VARCHAR(5) NOT NULL, 
	EmployeeID INT(11) NOT NULL, 
	OrderDate DATETIME,
	RequiredDate DATETIME, 
	ShippedDate DATETIME, 
	ShipVia INT(11) NOT NULL, 
	Freight DECIMAL(10,4),
	ShipName VARCHAR(40), 
	ShipAddress VARCHAR(60), 
	ShipCity VARCHAR(15), 
	ShipRegion VARCHAR(15),
	ShipPostalCode VARCHAR(10), 
	ShipCountry VARCHAR(15),
	PRIMARY KEY(OrderID),
	KEY `FK_Orders_Customers` (CustomerID),
	KEY `FK_Orders_Employees` (EmployeeID),
	KEY `FK_Orders_Shippers` (ShipVia)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS Customers(
	CustomerID VARCHAR(5) NOT NULL, 
	CompanyName VARCHAR(40) NOT NULL, 
	ContactName VARCHAR(30), 
	ContactTitle VARCHAR(30),
	Address VARCHAR(60), 
	City VARCHAR(15), 
	Region VARCHAR(15), 
	PostaCode VARCHAR(15), 
	Country VARCHAR(15),
	Phone VARCHAR(24), 
	Fax VARCHAR(24), 
	PRIMARY KEY(CustomerID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS OrderDetails(
	OrderID INT(11) NOT NULL, 
	ProductID INT(11) NOT NULL, 
	UnitPrice DECIMAL(10,4) NOT NULL, 
	Quantity SMALLINT(2) NOT NULL,
	Discount DECIMAL(6,5) NOT NULL, 
	PRIMARY KEY(OrderID, ProductID),
	KEY `FK_Order_Details_Products` (ProductID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/order-details.csv'
INTO TABLE OrdersDetails
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS Products(
	ProductID INT(11) NOT NULL, 
	ProductName VARCHAR(40) NOT NULL, 
	SupplierID INT(11), 
	CategoryID INT(11),
	QuantityPerUnit VARCHAR(20), 
	UnitPrice DECIMAL(10,4), 
	UnitsInStock SMALLINT(2), 
	UnitsOnOrder SMALLINT(2),
	ReorderLevel SMALLINT(2), 
	Discontinued SMALLINT(1) NOT NULL, 
	PRIMARY KEY(ProductID),
	KEY `FK_Products_Categories` (CategoryID),
	KEY `FK_Products_Suppliers` (SupplierID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE IF NOT EXISTS CustomerDemographics(
	CustomerTypeID VARCHAR(10) NOT NULL,
	CustomerDesc MEDIUMTEXT, 
	PRIMARY KEY(CustomerTypeID)
);



CREATE TABLE IF NOT EXISTS CustomerCustomerDemo(
	CustomerID VARCHAR(5) NOT NULL, 
	CustomerTypeID VARCHAR(10) NOT NULL,
	PRIMARY KEY(CustomerID, CustomerTypeID),
	KEY `FK_CustomerCustomerDemo` (CustomerTypeID)
);



CREATE TABLE IF NOT EXISTS Suppliers(
	SupplierID INT(11) NOT NULL, 
	CompanyName VARCHAR(40) NOT NULL, 
	ContactName VARCHAR(30), 
	ContactTitle VARCHAR(30),
	Address VARCHAR(60), 
	City VARCHAR(15), 
	Region VARCHAR(15), 
	PostalCode VARCHAR(10), 
	Country VARCHAR(15),
	Phone VARCHAR(24), 
	Fax VARCHAR(24), 
	HomePage MEDIUMTEXT, 
	PRIMARY KEY(SupplierID)
);

LOAD DATA LOCAL INFILE '/home/apurba/Downloads/Northwind_database_csv/suppliers.csv'
INTO TABLE Suppliers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



ALTER TABLE Territories
  ADD CONSTRAINT `FK_Territories_Region` FOREIGN KEY (RegionID) REFERENCES Region (RegionID);

ALTER TABLE EmployeeTerritories
  ADD CONSTRAINT `FK_EmployeeTerritories_Territories` FOREIGN KEY (TerritoryID) REFERENCES Territories (TerritoryID),
  ADD CONSTRAINT `FK_EmployeeTerritories_Employees` FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID);

ALTER TABLE Employees
  ADD CONSTRAINT `FK_Employees_Employees` FOREIGN KEY (ReportsTo) REFERENCES Employees (EmployeeID);

ALTER TABLE Orders
  ADD CONSTRAINT `FK_Orders_Shippers` FOREIGN KEY (ShipVia) REFERENCES Shippers (ShipperID),
  ADD CONSTRAINT `FK_Orders_Customers` FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
  ADD CONSTRAINT `FK_Orders_Employees` FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID);

ALTER TABLE Products
  ADD CONSTRAINT `FK_Products_Suppliers` FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID),
  ADD CONSTRAINT `FK_Products_Categories` FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID);

ALTER TABLE OrderDetails
  ADD CONSTRAINT `FK_Order_Details_Products` FOREIGN KEY (ProductID) REFERENCES Products (ProductID),
  ADD CONSTRAINT `FK_Order_Details_Orders` FOREIGN KEY (OrderID) REFERENCES Orders (OrderID);

ALTER TABLE CustomerCustomerDemo
  ADD CONSTRAINT `FK_CustomerCustomerDemo_Customers` FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
  ADD CONSTRAINT `FK_CustomerCustomerDemo` FOREIGN KEY (CustomerTypeID) REFERENCES CustomerDemographics (CustomerTypeID);






