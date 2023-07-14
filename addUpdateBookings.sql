USE littlelemondb;

-- Creating a stored procedure to add a record to the bookings table
DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, 
IN booking_date DATE, IN table_num INT)
BEGIN
    INSERT INTO bookings(BookingID, CustomerID, BookingDate, TableNo) 
    VALUES(booking_id, customer_id, booking_date, table_num);
END//
DELIMITER ;

-- Creating a stored procedure to update the bookings table
DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN
    UPDATE bookings SET BookingDate = booking_date WHERE BookingID = booking_id;
END//
DELIMITER ;

-- Creating a stored procedure to cancel/delete a record in the bookings table
DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
    DELETE FROM bookings WHERE BookingID = booking_id;
END//
DELIMITER ;