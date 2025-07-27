create schema empinfo;


Create table emp(
Name Varchar(255),
Occupation Varchar(255),
Working_Date date, 
Working_hours decimal(10,2)
);
drop table emp;
Select * from emp;

Insert into emp VALUES 
('Raj', 'Engineer', '2020-08-11' ,10),
('Ravi' ,'Actor' ,'2020-10-22', 10),
('Rahul', 'Doctor', '2020-10-04', 11);

Delimiter $$
Create Trigger validateNegativeHours 
before insert on emp
for each row
begin 
    if NEW.Working_hours < 0 then 
    set NEW.Working_hours = 0;
    end if;
end$$
delimiter ;


create table emp_audit(
name varchar(18),
audit_description varchar(100)
);

DELIMITER $$
CREATE TRIGGER trgInsertIntoEmpAudit
AFTER INSERT ON emp
FOR EACH ROW
BEGIN
    INSERT INTO emp_audit
    VALUES (NEW.name, CONCAT('A row has been inserted in emp table at ', DATE_FORMAT(NOW(), '%d-%m-%Y'), ' at ', DATE_FORMAT(NOW(), '%h:%i:%s %p')));
END $$
DELIMITER ;

Delimiter $$
Create trigger ValidateWorkingDate 
before insert on emp
for each row
Begin
    if new.Working_Date > date_format(now(), '%Y-%m-%d') then 
        signal sqlstate '45000'
        set message_text = "working Date cannot be greater then the entered date!";
    end if;
end$$
Delimiter ;


Create table EmpChanges(
   Name varchar(256), 
   New_Occupation varchar(256), 
   Old_Occupation varchar(256),
   Updatedate date
);

delimiter $$
Create Trigger empUpdateData
after update on emp 
for each row 
begin
    insert into EmpChanges values (new.Name, new.Occupation, old.Occupation, date_format(now(), '%Y-%m-%d'));
end$$
delimiter ;


set sql_safe_updates = 0;
Update emp set Occupation = 'Software Eng' where Name like '%Raj%';
Select * from EmpChanges;




Create table Emp_archeives(
Name varchar(256),
Occupation varchar(256),
Working_date date,
WorkingHours decimal(10,2), 
Deletedate date
);


Delimiter $$
create trigger empArcheives
before delete on emp
for each row
begin
   insert into  Emp_archeives values (old.Name, old.Occupation, old.Working_Date, old.Working_hours, date_format(now(),'%Y-%m-%d'));
end$$

delimiter ;

Delete from emp where Name like '%Rahul%';
select * from Emp_archeives;



Create table Total_working_hours(
    total_hrs decimal(10,2)
);
insert into Total_working_hours values (0);

delimiter $$
Create trigger TotalWorkingHrsInsert
after insert on emp 
for each row 
begin
    update Total_working_hours set total_hrs = (Select ifnull(sum(Working_hours),0) from emp);
end$$
delimiter ;

delimiter $$
Create trigger TotalWorkingHrsUpdate
after update on emp 
for each row 
begin
    update Total_working_hours set total_hrs = (Select ifnull(sum(Working_hours),0) from emp);
end$$
delimiter ;

delimiter $$
Create trigger TotalWorkingHrsDelete
after delete on emp 
for each row 
begin
    update Total_working_hours set total_hrs = (Select ifnull(sum(Working_hours),0) from emp);
end$$
delimiter ;


select * from Total_working_hours;

delete from emp where Name like '%Tejas%';

