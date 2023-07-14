-- Creating OrdersView Virtual table
create view OrdersView as select OrderID, Quantity, BillAmount 
from Orders where Quantity > 2;

-- Querying multiple tables to get records of orders above $150
select Customers.CustomerID, 
concat(FirstName, ' ', LastName) as FullName,
Orders.OrderID, BillAmount, Cusine, ItemName, ItemType
from Customers
join Bookings on Customers.CustomerID = Bookings.CustomerID
join Orders on Bookings.BookingID = Orders.BookingId
join MenuItems on Orders.OrderID = MenuItems.OrderID
where BillAmount > 150;

-- Quering the database using subquery to get order quantity above 2
select Cusine 
from menuitems
where Cusine = any(select Quantity from Orders where Quantity > 2);

-- Creating the GetMaxQuantity Stored procecure
delimiter //
create procedure GetMaxQuantity()
begin
select max(Quantity)
from orders;
end //
delimiter ;

-- Creating the GetOrderDetail prepared statement
prepare GetOrderDetail FROM "SELECT OrderID, Quantity, BillAmount
FROM Orders JOIN Bookings ON  Orders.BookingID = Bookings.BookingID
JOIN Customers ON Bookings.CustomerID = Customers.CustomerID
WHERE Customers.CustomerID = ?"; 

SET @Id = 1;
EXECUTE GetOrderDetail USING @Id;

-- Creating the CancelOrder stored procedure
delimiter //
create procedure CancelOrder(in orderID int)
begin
delete from orders where OrderID = orderID;
end //
delimiter ;

