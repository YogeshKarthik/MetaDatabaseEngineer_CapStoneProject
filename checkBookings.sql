use littlelemondb;

-- Inserting values into the bookings table
INSERT INTO littlelemondb.Bookings (BookingID, BookingDate, 
TableNo, BookingSlot, CustomerID)
VALUES
(1, '2022-10-10', 5,'19:00:00', 1),
(2, '2022-10-12', 3, '19:00:00', 3),
(3, '2022-10-11', 2, '15:00:00', 2),
(4, '2022-10-13', 2, '17:30:00', 1);

select * from bookings;

-- Creating Stored procedure to display 
-- Booking Status of Table Numbers in_the bookings table
DELIMITER //
CREATE PROCEDURE CheckBooking(
    IN bookingDate DATE,
    IN tableNo INT)
BEGIN
	DECLARE BookingStatus VARCHAR(20);
    SELECT 'Table available' INTO BookingStatus
    FROM Bookings
    WHERE BookingDate = bookingDate AND TableNo = tableNo
    LIMIT 1;
    IF BookingStatus IS NOT NULL THEN
        SELECT 'Table already booked' AS BookingStatus;
    ELSE
        SELECT 'Table available' AS BookingStatus;
    END IF;
END //
DELIMITER ;

call CheckBooking ('2022-11-12', 3);

-- Creating a stored procedure to add a booking if the date and table number is available 
-- using Insert and If-Else statements
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN bookingDate DATE, IN tableNo INT)
BEGIN
    DECLARE BookingStatus VARCHAR(100);
    DECLARE table_exists INT DEFAULT 0;
   
    START TRANSACTION;
    SELECT TableNo INTO table_exists FROM bookings
    WHERE tableNO = TableNo
    LIMIT 1;

    IF table_exists != 0 THEN
    	SET BookingStatus = CONCAT('Table ', tableNO, ' is already booked - booking cancelled.');
    ELSE
    	INSERT INTO bookings(BookingDate, TableNo) VALUES(bookingDate, tableNO);
        SET BookingStatus = CONCAT('Table ', tableNO, ' is available and will now be booked.');
        COMMIT;
    END IF;
    SELECT BookingStatus;
END//
DELIMITER ;

CALL AddValidBooking('2022-12-17', 6);



