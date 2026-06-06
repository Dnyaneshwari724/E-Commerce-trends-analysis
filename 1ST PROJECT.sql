CREATE DATABASE e_commerce_order_trends;
use e_commerce_order_trends;


CREATE TABLE Users (
UserID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100) UNIQUE,
PasswordHash VARCHAR(255),
Role ENUM('Admin', 'Customer'),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
desc Users;


CREATE TABLE Customers (
CustomerID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
Address TEXT,
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
desc Customers;


CREATE TABLE Products (
ProductID INT AUTO_INCREMENT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10, 2),
Stock INT,
Description
 TEXT,
ImageURL VARCHAR(255),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

desc Products;

CREATE TABLE Orders (
OrderID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
TotalAmount DECIMAL(10, 2),
Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled'),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
desc Orders;



CREATE TABLE OrderDetails (
OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
Price DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
desc OrderDetails;


CREATE TABLE Coupons (
CouponID INT AUTO_INCREMENT PRIMARY KEY,
Code VARCHAR(50),
DiscountPercentage DECIMAL(5, 2),
ExpiryDate DATE,
UsageLimit INT,
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
desc Coupons;


CREATE TABLE OrderCoupons (
OrderCouponID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
CouponID INT,
DiscountAmount DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (CouponID) REFERENCES Coupons(CouponID)
);
desc OrderCoupons;


CREATE TABLE ProductReviews (
ReviewID INT AUTO_INCREMENT PRIMARY KEY,
ProductID INT,
CustomerID INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
ReviewText TEXT,
ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
desc ProductReviews;

CREATE TABLE Shipments (
ShipmentID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
Carrier VARCHAR(100),
TrackingNumber VARCHAR(100),
ShippedDate TIMESTAMP,
EstimatedDeliveryDate TIMESTAMP,
DeliveredDate TIMESTAMP,
Status ENUM('Shipped', 'In Transit', 'Delivered', 'Failed'),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
desc Shipments;

CREATE TABLE Cart (
CartID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
ProductID INT,
Quantity INT,
AddedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
desc Cart;

-- INSERT VALUES INTO THE TABLE 

INSERT INTO Users (Name, Email, PasswordHash, Role)
VALUES
('Admin User', 'admin@example.com', 'hashedpassword1', 'Admin'),
('John Doe', 'john.doe@example.com', 'hashedpassword2', 'Customer'),
('Jane Smith', 'jane.smith@example.com', 'hashedpassword3', 'Customer'),
('Alice Brown', 'alice.brown@example.com', 'hashedpassword4', 'Customer'),
('Bob White', 'bob.white@example.com', 'hashedpassword5', 'Customer'),
('Michael Brown', 'michael.brown@example.com', 'hashedpassword4', 'Customer'),
('Sarah Johnson', 'sarah.johnson@example.com', 'hashedpassword5', 'Customer');
select*from Users;
INSERT INTO Customers (Name, Email, Phone, Address)
VALUES
('John Doe', 'john.doe@example.com', '1234567890', '123 Elm St, New York'),
('Jane Smith', 'jane.smith@example.com', '0987654321', '456 Oak St, California'),
('Alice Brown', 'alice.brown@example.com', '1122334455', '789 Pine St, Texas'),
('Bob White', 'bob.white@example.com', '5566778899', '159 Maple St, Florida'),
('Michael Brown', 'michael.brown@example.com', '1122334455', '789 Pine St, Texas'),
('Sarah Johnson', 'sarah.johnson@example.com', '6677889900', '321 Birch St, Florida');
select*from Customers;


INSERT INTO Products (ProductName, Category, Price, Stock, Description, ImageURL)
VALUES
('Laptop', 'Electronics', 1000.00, 20, 'High-performance laptop', 'http://example.com/laptop.jpg'),
('Headphones', 'Accessories', 50.00, 100, 'Noise-cancelling headphones', 'http://example.com/headphones.jpg'),
('Smartphone', 'Electronics', 800.00, 30, 'Latest smartphone model', 'http://example.com/smartphone.jpg'),
('Backpack', 'Accessories', 40.00, 50, 'Stylish and durable backpack', 'http://example.com/backpack.jpg'),
('Gaming Console', 'Electronics', 500.00, 15, 'Next-gen gaming console', 'http://example.com/console.jpg'),
('Wireless Mouse', 'Accessories', 25.00, 200, 'Ergonomic wireless mouse', 'http://example.com/mouse.jpg'),
('Smartwatch', 'Electronics', 300.00, 40, 'Feature-packed smartwatch', 'http://example.com/smartwatch.jpg');
select*from Products;

INSERT INTO Orders (CustomerID, TotalAmount, Status, OrderDate)
VALUES
(1, 1050.00, 'Shipped', '2024-12-01'),
(2, 850.00, 'Delivered', '2024-11-28'),
(3, 525.00, 'Delivered', '2024-11-30'),
(4, 325.00, 'Shipped', '2024-12-05');
select*from Orders;

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 1000.00),
(1, 2, 1, 50.00),
(2, 3, 1, 800.00),
(2, 4, 1, 40.00),
(3, 5, 1, 500.00),
(3, 6, 1, 25.00),
(4, 7, 1, 300.00);
select*from OrderDetails;


INSERT INTO Coupons (Code, DiscountPercentage, ExpiryDate, UsageLimit)
VALUES
('WELCOME10', 10.00, '2024-12-31', 100),
('FESTIVE20', 20.00, '2024-12-25', 50),
('HOLIDAY15', 15.00, '2024-12-31', 75);
select*from Coupons;


INSERT INTO OrderCoupons (OrderID, CouponID, DiscountAmount)
VALUES
(1, 1, 100.00),
(2, 2, 170.00),
(3, 3, 78.75);
select*from OrderCoupons;



INSERT INTO ProductReviews (ProductID, CustomerID, Rating, ReviewText)
VALUES
(1, 1, 5, 'Excellent laptop! Highly recommend.'),
(2, 2, 4, 'Great headphones, but a bit pricey.'),
(5, 3, 5, 'Amazing gaming experience!'),
(6, 4, 4, 'Great wireless mouse, very responsive.');
select*from ProductReviews;



INSERT INTO Shipments (OrderID, Carrier, TrackingNumber, ShippedDate, EstimatedDeliveryDate, DeliveredDate, Status)
VALUES
(1, 'FedEx', 'TRACK123', '2024-12-02', '2024-12-05', NULL, 'In Transit'),
(2, 'UPS', 'TRACK456', '2024-11-29', '2024-12-03', '2024-12-03', 'Delivered'),
(3, 'DHL', 'TRACK789', '2024-12-01', '2024-12-06', '2024-12-06', 'Delivered'),
(4, 'FedEx', 'TRACK101', '2024-12-06', '2024-12-10', NULL, 'In Transit');
select*from Shipments;



INSERT INTO Cart (CustomerID, ProductID, Quantity, AddedDate)
VALUES
(1, 4, 1, '2024-12-10'),
(2, 2, 2, '2024-12-09'),
(3, 7, 1, '2024-12-08'),
(4, 5, 1, '2024-12-09');
select*from Cart;


#Q1. What are the average prices of products by category, filtered to only show categories with an average price greater than $100?
SELECT category,
AVG(price) AS average_price
FROM Products
GROUP BY category
HAVING AVG(price) > 100;

#Q2. What are the top 5 best-selling products?
SELECT p.ProductName,
SUM(od.Quantity) AS total_sales
FROM Products p
JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY total_sales DESC
LIMIT 5;

#Q3. Write a trigger that automatically updates the stock of a product when an order is placed.
DELIMITER //

CREATE TRIGGER update_stock
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN

    UPDATE Products
    SET Stock = Stock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;

END //

DELIMITER ;
SHOW TRIGGERS;
SELECT * FROM Products;
INSERT INTO OrderDetails
(OrderID, ProductID, Quantity, Price)
VALUES
(1,1,2,1000);
SELECT * FROM Products;

#Q4. Which products have received 5-star reviews?
SELECT p.ProductName,
pr.Rating
FROM Products p
JOIN ProductReviews pr
ON p.ProductID = pr.ProductID
WHERE pr.Rating = 5;

#Q5. How much discount has been applied to each order?
SELECT o.OrderID,
c.Code,
c.DiscountPercentage,
oc.DiscountAmount
FROM `Orders` o
JOIN OrderCoupons oc
ON o.OrderID = oc.OrderID
JOIN Coupons c
ON oc.CouponID = c.CouponID;


#Q6. How many orders were placed each month?
SELECT MONTH(OrderDate) AS month,
COUNT(OrderID) AS total_orders
FROM `Orders`
GROUP BY MONTH(OrderDate)
ORDER BY month;

#Q7. Create a view that shows all orders along with customer names and order statuses, and how can you query this view to get all 'Shipped' orders?
CREATE VIEW Order_Details AS
SELECT o.OrderID,
c.Name,
o.Status
FROM `Orders` o
JOIN Customers c
ON o.CustomerID = c.CustomerID;
SELECT * FROM Order_Details;
#Query of the view
SELECT *
FROM Order_Details
WHERE Status = 'Shipped';

#Q8. Which customers have spent the most?
SELECT c.Name,
SUM(o.TotalAmount) AS total_spent
FROM Customers c
JOIN `Orders` o
ON c.CustomerID = o.CustomerID
GROUP BY c.Name
ORDER BY total_spent DESC;

#Q9. What is the average rating and total reviews for each product?
SELECT p.ProductName,
AVG(pr.Rating) AS average_rating,
COUNT(pr.Rating) AS total_reviews
FROM Products p
JOIN ProductReviews pr
ON p.ProductID = pr.ProductID
GROUP BY p.ProductName;

#Q10. How many shipments were handled by each carrier?
SELECT Status,
COUNT(ShipmentID) AS total_shipments
FROM Shipments
GROUP BY Status;

#Q11. Which orders were placed in the year 2024?
SELECT *
FROM `Orders`
WHERE YEAR(OrderDate) = 2024;


#Q12. How can you rank customers based on their total spending using a window function?
select c.Name,
sum(o.TotalAmount) AS total_spend,

Rank()OVER(
order by sum(o.TotalAmount)
desc
)AS customer_rank

from customers c
join orders o
ON c.customerID=o.customerID
group by c.Name;

#Q13. What is the delivery time for each completed order?
select orderID,-
DATEDIFF(DeliveredDate ,ShippedDate) AS Delivery_days
from Shipments
where status="delivered";

#Q14. How can products be categorized by price range?
SELECT ProductName,
Price,

CASE
    WHEN Price < 100 THEN 'Low Price'

    WHEN Price BETWEEN 100 AND 1000
    THEN 'Medium Price'

    ELSE 'High Price'

END AS price_category

FROM Products;

#Q15. How many unique delivered orders were made by each customer?
SELECT c.Name,
COUNT(DISTINCT o.OrderID) AS delivered_orders

FROM Customers c
JOIN `Orders` o
ON c.CustomerID = o.CustomerID

WHERE o.Status = 'Delivered'

GROUP BY c.Name; 

