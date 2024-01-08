-- DAY 3
-- 1)
USE classicmodels;
SELECT customerNumber, customerName, state, creditLimit
FROM customers
WHERE state IS NOT NULL
AND creditLIMIT BETWEEN 50000 and 100000
ORDER BY creditLimit DESC;

-- 2)
SELECT DISTINCT productLine
FROM products
WHERE productLine LIKE '%Cars';

-- DAY 4
-- 1)
SELECT orderNumber, status, 
IFNULL(comments, '-') as Comments
FROM orders
WHERE status = 'Shipped';

-- 2)
SELECT employeeNumber, firstName, jobTitle,
CASE
	WHEN jobTitle = 'President' Then 'P'
    WHEN jobTitle LIKE('S%)')
    Then 'SM'
    WHEN jobTitle = 'Sales Rep' THEN 'SR'
    WHEN jobTitle LIKE('%VP%') THEN 'VP'
END as jobTitle_abbr
FROM employees;

-- DAY 5
-- 1)
SELECT YEAR(paymentDate) as 'Year', MIN(amount) as amount
FROM payments
GROUP BY YEAR(paymentDate)
ORDER BY YEAR(paymentDate);

-- 2)
SELECT * FROM orders;
SELECT
		YEAR(orderDate) as 'Year',
		CASE
			WHEN QUARTER(orderDate) = 1 THEN 'Q1'
            WHEN QUARTER(orderDate) = 2 THEN 'Q2'
            WHEN QUARTER(orderDate) = 3 THEN 'Q3'
            ELSE 'Q4'
		END as Quarters,
	    COUNT(DISTINCT customerNumber) as 'Unique Customers',
		COUNT(DISTINCT orderNumber) as 'Total Orders'
FROM orders
GROUP BY YEAR(orderDate), Quarters;
        
-- 3)
select * from payments;
SELECT MONTHNAME(paymentDate) as 'Month', REPLACE(FORMAT(ROUND(SUM(amount), -3),0),',000','K') as 'formatted amount'
FROM payments
GROUP BY MONTHNAME(paymentDate)
HAVING ROUND(SUM(amount), -3) BETWEEN 500000 AND 1000000
ORDER BY ROUND(SUM(amount), -3) DESC;

-- Day 6
-- 1)
CREATE DATABASE IF NOT EXISTS day6;
USE Day6;
CREATE TABLE journey(
Bus_ID INT NOT NULL,
Bus_Name VARCHAR(50) NOT NULL,
Source_Station VARCHAR(50) NOT NULL,
Destination VARCHAR(50) NOT NULL,
Email VARCHAR(50) UNIQUE
);
SELECT * FROM journey;
DESCRIBE journey;

-- 2)
CREATE TABLE vendor(
Vendor_ID INT PRIMARY KEY,
Name VARCHAR(20) NOT NULL,
Email VARCHAR(50) UNIQUE,
Country VARCHAR(30) DEFAULT('N/A')
);
SELECT * FROM vendor;
DESC vendor;
INSERT INTO vendor(Vendor_ID, Name, Email) VALUES(1, 'Rohan', 'abc@gmail.com');

-- 3)
 CREATE TABLE movies(
 Movie_ID INT PRIMARY KEY,
 Name VARCHAR(20) NOT NULL,
 Release_Year YEAR DEFAULT('-'),
 Cast VARCHAR(30) NOT NULL,
 Gender VARCHAR(10) CHECK(Gender IN('Male','Female')),
 No_of_Shows INT CHECK(No_of_Shows > 0 )
 );
 
 SELECT * FROM movies;
 DESCRIBE movies;
 
 -- 4)
 CREATE TABLE Suppliers(
 supplier_id INT PRIMARY KEY AUTO_INCREMENT,
 supplier_name VARCHAR(20),
 location VARCHAR(20)
 );
 SELECT * FROM Suppliers;
 DESC Suppliers;
 
 CREATE TABLE Product(
 product_id INT PRIMARY KEY AUTO_INCREMENT,
 product_name VARCHAR(20) NOT NULL UNIQUE,
 description VARCHAR(50),
 supplier_id INT,
 FOREIGN KEY(supplier_id) REFERENCES Suppliers(supplier_id)
 ON UPDATE CASCADE
 ON DELETE CASCADE
);
 SELECT * FROM Product;
 DESC Product;

CREATE TABLE Stock(
 id INT PRIMARY KEY AUTO_INCREMENT,
 product_id INT,
 balance_stock INT,
 FOREIGN KEY(product_id) REFERENCES Product(product_id)
 ON UPDATE CASCADE
 ON DELETE CASCADE
 );
 SELECT * FROM Stock;
 DESC Stock;
 
 -- 7)
 -- 1)
 SELECT employeeNumber,
 CONCAT(firstName,' ',lastName) AS 'Sales Person'
 FROM employees;
 
 SELECT COUNT(customerNumber) AS 'Unique Customers',
 salesRepEmployeeNumber
 FROM customers
 WHERE salesRepEmployeeNumber IS NOT NULL
 GROUP BY salesRepEmployeeNumber
 ORDER BY COUNT(customerNumber) DESC;
 
 SELECT employeeNumber,
 CONCAT(firstName,' ',lastName) AS 'Sales Person',
 COUNT(customerNumber) AS 'Unique Customers'
 FROM employees JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
 WHERE salesRepEmployeeNumber IS NOT NULL
 GROUP BY salesRepEmployeeNumber
 ORDER BY COUNT(customerNumber) DESC;
 
 -- 2)
 SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM orderdetails;
SELECT * FROM products;
 
SELECT c.customerNumber,
c.customerName,
p.productCode,
p.productName,
od.quantityOrdered AS 'Ordered Qty',
p.quantityInStock AS 'Total Inventory',
(p.quantityInStock - od.quantityOrdered) AS 'Left Qty'
FROM orders o
JOIN customers c
ON o.customerNumber = c.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
ORDER BY c.customerNumber;

-- 3) 
CREATE TABLE Laptop(
Laptop_name VARCHAR(10)
);
INSERT INTO Laptop VALUES('Dell');
INSERT INTO Laptop VALUES('HP');
SELECT * FROM Laptop;

CREATE TABLE Colours(
Colours_name VARCHAR(10)
);
INSERT INTO Colours VALUES('White');
INSERT INTO Colours VALUES('Silver');
INSERT INTO Colours VALUES('Black');
SELECT * FROM Colours;

SELECT Laptop_name,Colours_name
FROM Laptop
CROSS JOIN Colours
ORDER BY Laptop_name;

-- 4)
CREATE DATABASE assign7;
USE assign7;
CREATE TABLE Project(
EmployeeID INT UNIQUE NOT NULL,
FullName VARCHAR(20),
Gender CHAR(6) CHECK(Gender IN('Male','Female')),
ManagerID INT
);

INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);
SELECT * FROM Project;
DESC Project;
ALTER TABLE Project
ADD COLUMN ManagerName VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;
UPDATE Project
SET ManagerName = 'Pranaya'
WHERE ManagerID = 1;
UPDATE Project
SET ManagerName = 'Preety'
WHERE ManagerID = 3;

SELECT ManagerName,
FullName AS 'Emp Name'
FROM Project
WHERE ManagerID IS NOT NULL
ORDER BY ManagerID;

-- OR
CREATE TABLE _project(
EmployeeID INT UNIQUE NOT NULL,
FullName VARCHAR(20),
Gender CHAR(6) CHECK(Gender IN('Male','Female')),
ManagerID INT
);

INSERT INTO _project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO _project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO _project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO _project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO _project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO _project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO _project VALUES(7, 'Hina', 'Female', 3);
SELECT p2.FullName AS ManagerName,
p1.FullName
FROM _project p1 LEFT JOIN _project p2 ON p1.ManagerID = p2.EmployeeID
WHERE p2.FullName IS NOT NULL
ORDER BY p2.FullName;





-- Day 8
CREATE DATABASE assign8;
USE assign8;
CREATE TABLE facility(
Facility_ID INT,
Name VARCHAR(100),
State VARCHAR(100),
Country VARCHAR(100)
);
DESC facility;
-- i)
ALTER TABLE facility
MODIFY COLUMN Facility_ID INT PRIMARY KEY AUTO_INCREMENT;
-- ii)
ALTER TABLE facility
ADD COLUMN City VARCHAR(100) NOT NULL AFTER Name;

-- Day9
CREATE DATABASE assign9;
USE assign9;
CREATE TABLE University(
ID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(100) NOT NULL
);
INSERT INTO University
VALUES (1, "       Pune          University     "), 
               (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");
 
SELECT ID, CONCAT(REPLACE(REPLACE(TRIM(Name),' ',''),'University',' '),'University') AS Name
FROM University;
-- OR
SELECT ID, CONCAT(RTRIM(REPLACE(TRIM(Name),'University',' ')),' ','University') AS Name
FROM University;

-- Day 10

SELECT
	YEAR(o.orderDate) AS Year,
    COUNT(d.productCode) AS Val,
    ROUND((COUNT(d.productCode)/(SELECT COUNT(productCode)FROM orderdetails))*100) AS Percent_of_Total,
    CONCAT(COUNT(d.productCode),' ','(',ROUND((COUNT(d.productCode)/(SELECT COUNT(productCode)FROM orderdetails))*100),'%',')') AS Value
FROM orderdetails d JOIN orders o ON d.orderNumber = o.orderNumber
GROUP BY Year
ORDER BY Val DESC;
              
-- SELECT COUNT(productCode)FROM d.orderdetails;

CREATE VIEW productsstatus
AS
	SELECT
	YEAR(o.orderDate) AS Year,
    COUNT(d.productCode) AS Val,
    ROUND((COUNT(d.productCode)/(SELECT COUNT(productCode)FROM orderdetails))*100) AS Percent_of_Total,
    CONCAT(COUNT(d.productCode),' ','(',ROUND((COUNT(d.productCode)/(SELECT COUNT(productCode)FROM orderdetails))*100),'%',')') AS Value
FROM orderdetails d JOIN orders o ON d.orderNumber = o.orderNumber
GROUP BY Year
ORDER BY Val DESC;

SELECT Year, Value FROM productsstatus;

-- Day 11
-- 1)
DELIMITER !!
	CREATE PROCEDURE GetCustomerLevel(IN customer_num INT, OUT customer_level VARCHAR(10))
    BEGIN
		SELECT
CASE 
	WHEN creditLimit > 100000 THEN 'Platinum'
	WHEN creditLimit > 25000 THEN 'Gold'
	ELSE 'Silver'
END INTO customer_level
FROM customers
WHERE customerNumber = customer_num;
    END !!
    DELIMITER ;
    
 -- e.g   
CALL GetCustomerLevel(144,@CustomerLevel);
SELECT @CustomerLevel;

SELECT customerNumber, creditLimit,
CASE 
	WHEN creditLimit > 100000 THEN 'Platinum'
	WHEN creditLimit > 25000 THEN 'Gold'
	ELSE 'Silver'
END as customer_level
FROM customers; -- To Compare the Values

-- DROP PROCEDURE GetCustomerLevel;

-- 2)
DELIMITER !!
CREATE PROCEDURE Get_country_payments(IN _year YEAR, IN _country VARCHAR(30), OUT _totalamount DECIMAL(10,2))
BEGIN
	SELECT
		SUM(p.amount) INTO _totalamount
    FROM customers c JOIN payments p ON c.customerNumber = p.customerNumber
	WHERE c.country = _country AND YEAR(p.paymentDate) = _year;
END !!
DELIMITER ;
SET @year = 2003;
SET @country = 'France';
CALL Get_country_payments(@year,@country,@totalamount);
SELECT @year AS Year, @country AS country, REPLACE((ROUND(@totalamount,-3)/1000),'.0000','K') AS 'Total Amount';


SET @pay_year = 2003;
SET @country = 'France';
SELECT @pay_year AS Year , @country as Country; -- JUST FOR UNDERSTANDING PURPOSE

SELECT YEAR(p.paymentDate) as Year, c.country as Country, REPLACE((ROUND(SUM(p.amount),-3)/1000),'.0000','K') AS 'Total Amounts'
FROM customers c JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY Year, Country; -- FOR COMPARING VALUES

-- Day 12
-- 1)
SELECT
	YEAR(orderDate) AS Year,
    MONTHNAME(orderDate) AS Month,
    COUNT(orderNumber) AS 'Total Orders',
    -- LAG(COUNT(orderNumber)) OVER (ORDER BY YEAR(orderDate)) AS 'Previous Orders',
    CONCAT(ROUND(((COUNT(orderNumber) - LAG(COUNT(orderNumber)) OVER (ORDER BY YEAR(orderDate)))/(LAG(COUNT(orderNumber)) OVER (ORDER BY YEAR(orderDate))))*100,0),'%') AS '%YOY Change'
FROM orders
GROUP BY YEAR(orderDate), MONTHNAME(orderDate);

-- 2)
CREATE DATABASE ude;
USE ude;
CREATE TABLE emp_udf(
Emp_ID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(20),
DOB DATE
);
INSERT INTO emp_udf(Name, DOB)
VALUES ("Piyush", "1990-03-30"), ("Aman", "1992-08-15"), ("Meena", "1998-07-28"), ("Ketan", "2000-11-21"), ("Sanjay", "1995-05-21");

DESC emp_udf;

SELECT * FROM emp_udf;

DELIMITER !!
CREATE FUNCTION calculate_age(age DATE)
RETURNS VARCHAR(25)
DETERMINISTIC
BEGIN
	DECLARE todays_date DATE;
    SELECT
		CURRENT_DATE() INTO todays_date;
    RETURN CONCAT(FLOOR((TIMESTAMPDIFF(MONTH, age, todays_date)/12)), ' years ', 
MOD(TIMESTAMPDIFF(MONTH, age, todays_date), 12), ' months ');
END !!
DELIMITER ;

SELECT *, calculate_age(DOB) AS Age FROM emp_udf;

SELECT *, CONCAT(FLOOR((TIMESTAMPDIFF(MONTH, DOB, CURRENT_DATE())/12)), ' years ', 
MOD(TIMESTAMPDIFF(MONTH, DOB, CURRENT_DATE()), 12), ' months ') AS Age FROM emp_udf; -- JUST FOR UNDERSTANDING PURPOSE

-- SELECT TIMESTAMPDIFF(YEAR, DOB, CURRENT_DATE()) FROM emp_udf;
-- SELECT MOD(TIMESTAMPDIFF(MONTH, DOB, CURRENT_DATE()), 12) FROM emp_udf;
-- SELECT FLOOR((TIMESTAMPDIFF(MONTH, "2021-01-01", CURRENT_DATE())/12)); 
-- SELECT TIMESTAMPDIFF(MONTH, DOB, CURRENT_DATE())/12 FROM emp_udf;
-- CEIL/FLOOR

-- Day 13
-- 1)
SELECT customerNumber, customerName FROM customers; -- LIST OF ALL THE CUSTOMERS
SELECT DISTINCT customerNumber FROM orders; -- LIST OF ALL THE CUSTOMERS PLACED ORDER
 
SELECT customerNumber, customerName FROM customers
WHERE customerNumber NOT IN (SELECT DISTINCT customerNumber FROM orders);

-- 2)
/*SELECT * 
FROM customers c LEFT JOIN orders o 
ON c.customerNumber = o.customerNumber
UNION
SELECT * 
FROM customers c RIGHT JOIN orders o
ON c.customerNumber = o.customerNumber;

SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) OVER (PARTITION BY o.customerNumber) 'Total Orders'
FROM customers c JOIN orders o ON c.customerNumber = o.customerNumber;*/ -- -------(JUST FOR UNDERSTANDING PURPOSE)

SELECT *
FROM (SELECT DISTINCT c.customerNumber, c.customerName, COUNT(o.orderNumber) OVER (PARTITION BY o.customerNumber) 'Total Orders'
FROM customers c LEFT JOIN orders o ON c.customerNumber = o.customerNumber
UNION
SELECT DISTINCT c.customerNumber, c.customerName, COUNT(o.orderNumber) OVER (PARTITION BY o.customerNumber) 'Total Orders'
FROM customers c RIGHT JOIN orders o ON c.customerNumber = o.customerNumber) dc
ORDER BY dc.customerNumber;

-- 3)
SELECT dqo.orderNumber, dqo.quantityOrdered
	FROM(SELECT 
	orderNumber, quantityOrdered,
    DENSE_RANK() OVER (PARTITION BY orderNumber ORDER BY quantityOrdered DESC) AS quantity_Ordered
    FROM orderdetails) AS dqo
    WHERE dqo.quantity_Ordered = 2;
    
-- 4)
    SELECT 
    MAX(pc.product_count) AS 'MAX(Total)',
    MIN(pc.product_count) AS 'MIN(Total)'
    FROM(SELECT orderNumber,
    COUNT(productCode) as product_count
    FROM orderdetails
    GROUP BY orderNumber) AS pc;
     
-- 5)
	SELECT * FROM productlines;
    
    SELECT productLine, COUNT(productLine) AS Total
    FROM products p
    WHERE buyPrice > (SELECT AVG(buyPrice) FROM products
    WHERE productLine = p.productLine)
	GROUP BY p.productLine
    ORDER BY Total DESC;
 
/*SELECT productLine, COUNT(productLine), AVG(buyprice)
FROM products
GROUP BY productLine;
    
/*64.446316 Classic Cars
50.685385 Motorcycles
49.629167 Planes
47.007778 Ships
43.923333 Trains
56.329091 Trucks and Buses
46.066250 Vintage Cars

SELECT * FROM products
WHERE productLine = 'Trains'
AND buyPrice > 43.923333;*/

-- 14)
CREATE TABLE Emp_EH(
Emp_ID INT PRIMARY KEY,
EmpName VARCHAR(100),
EmailAddress VARCHAR(100)
);

DELIMITER //
CREATE PROCEDURE Add_Values(IN Emp_ID INT , IN EmpName VARCHAR(100) , IN EmailAddress VARCHAR(100) )
  BEGIN 
  DECLARE 
  EXIT HANDLER FOR SQLEXCEPTION
  BEGIN 
  SELECT 'Error Occured' AS Error_Message;
  END;
  
  INSERT INTO Emp_EH(Emp_ID , EmpName , EmailAddress)
  VALUES(Emp_ID , EmpName , EmailAddress);
  END //
  DELIMITER ;

CALL Add_Values(1,'abc' , 'abc@gmail.com');
CALL Add_Values(2,'xyz' , 'xyz@gmail.com');
CALL Add_Values(5.3, 'John Wick' , 'John.W@gmail.com');

-- 15)
CREATE DATABASE assign15;
USE assign15;

CREATE TABLE Emp_BIT(
Name VARCHAR(20),
Occupation VARCHAR(20),
Working_date DATE,
Working_hours INT
);

INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);

SELECT* FROM Emp_BIT;
DESC Emp_BIT;

CREATE TABLE employee_log (
    prev_ename VARCHAR(20) DEFAULT '---',
    current_ename VARCHAR(20) DEFAULT '---',
    prev_occupation VARCHAR(20) DEFAULT '---',
    current_occupation VARCHAR(20) DEFAULT '---',
    prev_working_date DATE,
    current_working_date DATE,
    prev_working_hours INT,
    current_working_hours INT,
    _action VARCHAR(20)
); 

SELECT * FROM employee_log;

CREATE TRIGGER emp_update
BEFORE INSERT ON Emp_BIT
FOR EACH ROW INSERT INTO employee_log
SET _action = 'insert',
current_ename = NEW.Name,
current_occupation = NEW.Occupation,
current_working_date = NEW.Working_date,
current_working_hours = ABS(NEW.Working_hours);

INSERT INTO Emp_BIT VALUES
('Aziz', 'Influencer', '2022-07-03', -8);
INSERT INTO Emp_BIT VALUES
('laveena', 'Dancer', '2021-06-24', -15);
SELECT * FROM Emp_BIT;
SELECT * FROM employee_log;
DROP TRIGGER emp_update;
-- ----------------------------------------------------------------------------------------------------------------------------
viraj wagh sql assignments
