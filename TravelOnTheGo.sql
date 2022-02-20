CREATE DATABASE IF NOT EXISTS TravelOnTheGo;

USE TravelOnTheGo;

#Query1: You are required to create two tables PASSENGER and PRICE with the following attributes and properties
CREATE TABLE IF NOT EXISTS Passenger
(
Passenger_name varchar(30) not null primary key,
Category varchar(10),
Gender char(10),
Boarding_City varchar(30),
Destination_City varchar(30),
Distance int,
Bus_Type varchar(20)
);

CREATE TABLE IF NOT EXISTS Price
(
Bus_Type varchar(20),
Distance int,
Price int
);

#Query2: Insert the following data in the tables
INSERT INTO Passenger VALUES('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
INSERT INTO Passenger VALUES('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting');
INSERT INTO Passenger VALUES('Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper');
INSERT INTO Passenger VALUES('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
INSERT INTO Passenger VALUES('Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper');
INSERT INTO Passenger VALUES('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
INSERT INTO Passenger VALUES('Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper');
INSERT INTO Passenger VALUES('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
INSERT INTO Passenger VALUES('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

INSERT INTO Price VALUES('Sleeper',350,770);
INSERT INTO Price VALUES('Sleeper',500,1100);
INSERT INTO Price VALUES('Sleeper',600,1320);
INSERT INTO Price VALUES('Sleeper',700,1540);
INSERT INTO Price VALUES('Sleeper',1000,2200);
INSERT INTO Price VALUES('Sleeper',1200,2640);
INSERT INTO Price VALUES('Sleeper',1500,2700);
INSERT INTO Price VALUES('Sitting',500,620);
INSERT INTO Price VALUES('Sitting',600,744);
INSERT INTO Price VALUES('Sitting',700,868);
INSERT INTO Price VALUES('Sitting',1000,1240);
INSERT INTO Price VALUES('Sitting',1200,1488);
INSERT INTO Price VALUES('Sitting',1500,1860);

#Query3: How many females and how many male passengers travelled for a minimum distance of 600 KMs?
select Gender,count(Gender) from Passenger,Price where Passenger.Distance >= 600 and 
Passenger.Distance = Price.Distance  group by Gender;

#Query4: Find the minimum ticket price for Sleeper Bus. 
SELECT MIN(price) FROM Price WHERE Bus_Type = 'sleeper';

#Query5: Select passenger names whose names start with character 'S'
select Passenger_Name from Passenger where Passenger_Name like 's%';

#Query6: Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output
SELECT Passenger_name , p1.Boarding_City, p1.Destination_city, p1.Bus_Type, p2.Price 
FROM Passenger p1, price p2 WHERE p1.Distance = p2.Distance and p1.Bus_type = p2.Bus_type;

#Query7: What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KMs?
SELECT p1.Passenger_name, p1.Boarding_city, p1.Destination_city, p1.Bus_type, p2.Price FROM passenger p1, price p2 
WHERE p1.Distance = 1000 and p1.Bus_type = 'Sitting' and p1.Distance = 1000 and p1.Bus_type = 'Sitting';

#Query8: What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT DISTINCT p1.Passenger_name, p1.Boarding_city as Destination_city, p1.Destination_city as Boardng_city, p2.Bus_type, p2.Price 
FROM passenger p1, price p2 WHERE Passenger_name = 'Pallavi' and p1.Distance = p2.Distance; 


#Query9: List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order
SELECT DISTINCT Distance FROM passenger ORDER BY Distance desc;

#Query10: Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables
select passenger_name,distance * 100 /(select sum(distance) from passenger) as percentage from passenger;

#Query11: Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise

Delimiter $$
create procedure proc1()
begin
Select Price.Distance, Price.Price, 
case 
 when Price.Price > 1000 then 'Expensive'
 when Price.Price < 1000 and Price.Price > 500 then 'Average Cost'
 else 'Cheap'
end
as verdict from Price;
end $$

call proc1;

