create schema hms;


Create table userdetails(
    userid int primary key not null auto_increment,
    UserName varchar(256) unique,
    fName varchar(256),
    lName varchar(256),
    Email varchar(256),
    Password varchar(256),
    UserType varchar(256),
    CreatedOn timestamp,
    UpdatedOn timestamp,
    EmployeeNo varchar(256) unique,
    Phone varchar(256)
);
Select * from userdetails;
delete from userdetails where userid = 4;
CREATE TABLE rooms(
    roomid int primary key not null auto_increment,
    room_no int,
    status varchar(256),
    room_type varchar(256),
    type_id int,
    price_per_day decimal(10,3) constraint chk_price check(price_per_day > 0),
    room_dscrpt varchar(256),
    created_on timestamp,
    updated_on timestamp,
    created_by int,
    updated_by int,
    foreign key(created_by) references userdetails(userid),
    foreign key(updated_by) references userdetails(userid),
    foreign key(type_id) references roomsTypesDetails(type_id)
);
select * From rooms;
Insert into rooms(room_no, status, room_type, price_per_day, room_dscrpt, created_on, created_by, type_id) values (110 ,'Unoccupied','Five Capacity room',4700,'along with wifi-2bed-1pool',now(),1,7);


CREATE TABLE guests(
    guestid int primary key not null auto_increment,
    lname varchar(256),
    fname varchar(256),
    address1 varchar(256),
    address2 varchar(256),
    city varchar(256),
    state varchar(256),
    country varchar(256),
    pincode int,
    UID_type varchar(256),
    UID_NO varchar(256),
    phone varchar(256),
    created_on timestamp,
    update_on timestamp,
    created_by int,
    updated_by int,
    foreign key(created_by) references userdetails(userid),
    foreign key(updated_by) references userdetails(userid)
);
Select * From guests;
INSERT INTO guests(lname,fname,address1,address2,city,state,country,pincode,UID_type,UID_NO,phone,created_on,created_by)VALUES ('Doe','John','123 Main Street','Apt 4B','Mumbai','Maharashtra','India',400001,'Aadhar','1234-5678-9012','9876543210',NOW(),1);


select UserId,fname from userdetails where BINARY UserName = 'Tejas007' and BINARY Password = 'Tejas007';
Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'CREATE TABLE Bookings(     bookingid int primary key not null auto_increment,   ' at line 4


CREATE TABLE Bookings(
    bookingid int primary key not null auto_increment,
    guestid int,
    roomid int,
    foreign key (guestid) references guests(guestid),
    foreign key (roomid) references rooms(roomid),
    total_bill decimal(10,2) constraint chk_total_bill check(total_bill > 0),
    room_price decimal(10,2) constraint chk_room_price check(room_price > 0),
    taxes decimal(10,2) constraint chk_taxes check(taxes > 0),
    beverages decimal(10,2) constraint chk_beverages check(beverages > 0),
    check_in timestamp,
    check_out timestamp,
    booked_days int,
    booked_by int,
    foreign key (booked_by) references userdetails(userid)
);
select * from Bookings;
INSERT INTO Bookings( guestid, roomid, room_price, taxes, beverages, check_in, booked_days, booked_by ) VALUES ( 4, 3, 5000.00, 500.00, 200.00, NOW(), 3, 1 );

# bookingid, guestid, roomid, total_bill, room_price, taxes, beverages, check_in, check_out, booked_days, booked_by


DELIMITER $$

CREATE TRIGGER calculateTotal_Bill_Update
BEFORE update
ON Bookings
FOR EACH ROW
BEGIN
    SET NEW.total_bill = COALESCE(NEW.room_price, 0) * COALESCE(NEW.booked_days, 0)
                       + COALESCE(NEW.taxes, 0) 
                       + COALESCE(NEW.beverages, 0);
END$$

DELIMITER ;


Drop trigger calculateTotal_Bill;


Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'OR UPDATE ON Bookings FOR EACH ROW BEGIN     SET NEW.total_bill = NEW.room_price' at line 2


Create table roomsTypesDetails(
   type_id int primary key not null auto_increment,
   type varchar(256),
   type_price decimal(10,2) constraint chk_type_price check(type_price > 0),
   created_on timestamp,
   updated_on timestamp,
   created_by int,
   updated_by int,
   foreign key (created_by) references userdetails(userid),
   foreign key (updated_by) references userdetails(userid)
);
Select * from roomstypesdetails;
select type, type_price, created_by,fname from roomstypesdetails rtp 
join (
Select userid,fname from userdetails
)ud on ud.userid = rtp.created_by;





Select roomid from rooms where room_no = 342;

Select type from roomstypesdetails where type_id = 1;

Select * from rooms;




SELECT roomid, room_no, status, room_type, price_per_day, room_dscrpt, created_on, DATE_FORMAT(created_on, '%d-%m-%Y') AS Created_on,u.fName FROM rooms r 
inner join (
    Select userid,fName from userdetails
)u on u.userid = r.created_by
 WHERE 1=1;



# guestid, lname, fname, address1, address2, city, state, country, pincode, UID_type, UID_NO, phone, created_on, update_on, created_by, updated_by


SELECT 
    g.guestid, 
    g.lname, 
    g.fname, 
    g.address1, 
    g.address2, 
    g.city, 
    g.state, 
    g.country, 
    g.pincode, 
    g.UID_type, 
    g.UID_NO, 
    g.phone, 
    DATE_FORMAT(g.created_on, '%d-%m-%Y') AS createdOn,
    DATE_FORMAT(g.update_on, '%d-%m-%Y') AS updatedOn,
    u.fName AS created_by, 
    ul.fName AS updated_by
FROM guests g
JOIN userdetails u ON u.userid = g.created_by
JOIN userdetails ul ON ul.userid = g.updated_by
WHERE 1=1;




SELECT * FROM guests WHERE guestid = 1;

Delete from roomstypesdetails where type_id = 1;



Select concat(g.fname," ", g.lname) as GuestName, room_no, total_bill, room_price, taxes, beverages, check_in, check_out, booked_days, ud.fname as createdBy from bookings b 
join(
Select guestid, lname, fname from guests
)g on g.guestid = b.guestid
join(
Select userid, fname from userdetails
)ud on ud.userid = b.booked_by
join(
Select roomid, room_no from rooms
)r on r.roomid = b.roomid
Where 1=1 ;


Delimiter $$
Create procedure GetBookingsDtls(
	IN query varchar(256)
)
BEGIN
	SET @query = concat('Select concat(g.fname," ", g.lname) as GuestNamecalculateTotal_BillcalculateTotal_Bill,bookingid, room_no, total_bill, room_price, taxes, beverages,DATE_FORMAT(check_in, ''%d-%m-%Y %H:%i:%s'') as check_in , DATE_FORMAT(check_out, ''%d-%m-%Y %H:%i:%s'') as check_out, booked_days, ud.fname as createdBy from bookings b 
join(
Select guestid, lname, fname from guests
)g on g.guestid = b.guestid
join(
Select userid, fname from userdetails
)ud on ud.userid = b.booked_by
join(
Select roomid, room_no from rooms
)r on r.roomid = b.roomid
Where 1=1 ', query);
prepare stmt from @query;
execute stmt;
END$$

Call GetBookingsDtls('');
Call GetBookingsDtls(' AND check_in >= ''2024-calculateTotal_Bill10-05 00:00:00'' and check_in <= ''2024-10-05 23:59:59'' ');
select * from bookings where bookingid = 3;
select UserId,fname from userdetails where BINARY UserName = 'Tejas008' and BINARY Password = 'Tejas008';

select * from rooms;

select check_out from bookings;