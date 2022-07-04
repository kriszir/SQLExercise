BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Employer" (
	"Employer_ID"	INTEGER,
	"FullName"	TEXT NOT NULL,
	"JoiningDate"	datetime,
	"CurrentPosition"	TEXT,
	"Department"	TEXT,
	"AssignedProject"	TEXT,
	PRIMARY KEY("Employer_ID")
);
CREATE TABLE IF NOT EXISTS "Services" (
	"Software_ID"	INTEGER,
	"Name"	TEXT,
	"Category"	TEXT,
	"Size"	REAL,
	"NumberOfInstallments"	INT DEFAULT 0,
	PRIMARY KEY("Software_ID")
);
CREATE TABLE IF NOT EXISTS "Software_Requests" (
	"Employer_ID"	INTEGER,
	"Software_ID"	INTEGER,
	"Request_Start_Date"	date,
	"Request_Close_Date"	date,
	"Status"	Text NOT NULL,
	PRIMARY KEY("Employer_ID","Software_ID"),
	FOREIGN KEY("Employer_ID") REFERENCES "Employer"("Employer_ID"),
	FOREIGN KEY("Software_ID") REFERENCES "Services"("Software_ID")
);
INSERT INTO "Employer" ("Employer_ID","FullName","JoiningDate","CurrentPosition","Department","AssignedProject") VALUES (222333,'Serge Frenchie','2015-09-23 19:37:28','Manager','HR','The Boys');
INSERT INTO "Employer" ("Employer_ID","FullName","JoiningDate","CurrentPosition","Department","AssignedProject") VALUES (233555,'Houghie Campbell','2018-10-10 11:10:10','Staff','IT Support','The Boys');
INSERT INTO "Employer" ("Employer_ID","FullName","JoiningDate","CurrentPosition","Department","AssignedProject") VALUES (566266,'Billy Butcher','2010-06-10 16:17:14','Boss','Finance','The Boys');
INSERT INTO "Services" ("Software_ID","Name","Category","Size","NumberOfInstallments") VALUES (119,'Program V','A',140.3,1);
INSERT INTO "Services" ("Software_ID","Name","Category","Size","NumberOfInstallments") VALUES (129,'Time Hacker','B',190.3,0);
INSERT INTO "Services" ("Software_ID","Name","Category","Size","NumberOfInstallments") VALUES (5490,'Project C','C',1240.38,1);
INSERT INTO "Services" ("Software_ID","Name","Category","Size","NumberOfInstallments") VALUES (9990,'Hammer Time','D',12690.381,0);
INSERT INTO "Software_Requests" ("Employer_ID","Software_ID","Request_Start_Date","Request_Close_Date","Status") VALUES (233555,119,'2022.7.10','2022.8.12','Closed');
INSERT INTO "Software_Requests" ("Employer_ID","Software_ID","Request_Start_Date","Request_Close_Date","Status") VALUES (222333,5490,'2021.5.12','2022.8.12','Closed');
CREATE TRIGGER RequestTrigger01 
	AFTER INSERT ON Software_Requests
	BEGIN
	UPDATE Services SET NumberOfInstallments = NumberOfInstallments+1 WHERE Software_ID = NEW.Software_ID;
	END;
COMMIT;
