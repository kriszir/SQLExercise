--Creating Tables
CREATE TABLE Employer (
Employer_ID INTEGER PRIMARY KEY,
FullName TEXT NOT NULL,
JoiningDate datetime,
CurrentPosition TEXT,
Department TEXT,
AssignedProject TEXT 
);
CREATE TABLE Services (
Software_ID INTEGER PRIMARY KEY,
Name TEXT,
Category TEXT,
Size REAL,
NumberOfInstallments INT DEFAULT 0
);
CREATE TABLE Software_Requests (
Employer_ID INTEGER,
Software_ID INTEGER,
Request_Start_Date date,
Request_Close_Date date,
Status Text NOT NULL,
PRIMARY KEY (Employer_ID, Software_ID)
FOREIGN KEY (Employer_ID) REFERENCES Employer(Employer_ID),
FOREIGN KEY (Software_ID) REFERENCES Services(Software_ID)
);

CREATE TRIGGER IF NOT EXISTS RequestTrigger01 
	AFTER INSERT ON Software_Requests
	BEGIN
	UPDATE Services SET NumberOfInstallments = NumberOfInstallments+1 WHERE Software_ID = NEW.Software_ID;
	END;

	
--Inserts
INSERT INTO Employer VALUES(233555,'Houghie Campbell','2018-10-10 11:10:10', 'Staff', 'IT Support', 'The Boys');
INSERT INTO Employer VALUES(566266,'Billy Butcher','2010-06-10 16:17:14', 'Boss', 'Finance', 'The Boys');
INSERT INTO Employer VALUES(222333,'Serge Frenchie','2015-09-23 19:37:28', 'Manager', 'HR', 'The Boys');

INSERT INTO Services VALUES(119, 'Program V', 'A', 140.30,0);
INSERT INTO Services VALUES(129, 'Time Hacker', 'B', 190.30,0);
INSERT INTO Services VALUES(5490, 'Project C', 'C', 1240.38,0);
INSERT INTO Services VALUES(9990, 'Hammer Time', 'D', 12690.381,0);
 
INSERT INTO Software_Requests VALUES(233555, 119, '2022.7.10', '2022.8.12', 'Closed');
INSERT INTO Software_Requests VALUES(222333, 5490, '2021.5.12', '2022.8.12', 'Closed');





