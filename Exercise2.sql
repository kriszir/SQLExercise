--1.
SELECT artists.name AS 'Artist Name', ifnull(albums.Title, 'No Album') AS 'Album Name'  FROM artists 
LEFT JOIN albums ON artists.ArtistId = albums.ArtistId 
ORDER BY artists.name;
--2.
SELECT artists.name AS 'Artist Name', albums.Title AS 'Album Name' FROM artists
JOIN albums ON artists.ArtistId = albums.ArtistId ORDER BY albums.Title DESC;
--3.
SELECT artists.name AS 'Artist Name' FROM artists WHERE artists.ArtistId NOT IN 
(SELECT artists.ArtistId FROM artists JOIN albums ON albums.ArtistId = artists.ArtistId)
ORDER BY artists.Name;
--4.
SELECT artists.name AS 'Artist Name', Count(albums.Title) AS 'No of Albums' FROM artists 
LEFT JOIN albums ON albums.ArtistId = artists.ArtistId 
GROUP BY artists.name 
ORDER BY Count(albums.Title) DESC, artists.name;

--5.
SELECT artists.name AS 'Artist Name', Count(albums.Title) AS 'No of Albums' From artists 
JOIN albums ON artists.ArtistId = albums.ArtistId
GROUP BY artists.Name HAVING Count(albums.Title) >9
ORDER BY Count(albums.Title) DESC, artists.Name;
;

--6.
SELECT artists.name AS 'Artist Name', Count(albums.Title) AS 'No of Albums' From artists 
JOIN albums ON artists.ArtistId = albums.ArtistId
GROUP BY artists.Name
ORDER BY Count(albums.Title) DESC
LIMIT 3;

--7.
SELECT artists.Name AS 'Artist Name', albums.Title AS 'Album Title', tracks.Name AS 'Track' FROM artists 
JOIN albums ON artists.ArtistId = albums.ArtistId 
JOIN tracks ON tracks.AlbumId = albums.AlbumId
WHERE artists.Name = 'Santana'
Order By tracks.TrackId;

--8.
CREATE VIEW managers AS 
SELECT employees.FirstName || ' ' || employees.LastName AS 'Manager_Name', employees.EmployeeId , employees.Title FROM employees 
WHERE employees.Title LIKE '%Manager%';
Select * from managers;
SELECT employees.EmployeeId AS 'Employee ID', employees.FirstName || ' ' || employees.LastName AS 'Employee Name' ,
employees.Title AS 'Employee Title', 
(SELECT managers.EmployeeId  FROM managers where employees.ReportsTo =managers.EmployeeId) AS 'Manager ID',
(SELECT managers.Manager_Name FROM managers where employees.ReportsTo =managers.EmployeeId)  AS 'Manager Name',
(SELECT managers.Title From managers where employees.ReportsTo =managers.EmployeeId ) AS 'Manager Title' FROM employees;

--9.
CREATE VIEW top_employees AS
SELECT employees.EmployeeId AS 'emp_id', employees.FirstName || ' ' || employees.LastName AS 'emp_name' ,
Count(customers.CustomerId) AS 'cust_count' FROM employees
JOIN customers ON employees.EmployeeId = customers.SupportRepId
GROUP BY employees.EmployeeId
ORDER BY Count(customers.CustomerId) DESC
LIMIT 1;
SELECT top_employees.emp_name AS 'Employee Name', customers.FirstName || ' ' || customers.LastName AS 'Customer Name' From top_employees 
JOIN customers ON top_employees.emp_id = customers.SupportRepId ;

--10.
INSERT INTO media_types (Name) VALUES('MP3');
CREATE TRIGGER prevention 
BEFORE INSERT ON tracks
WHEN New.MediaTypeId = 6
BEGIN
SELECT RAISE(ABORT, 'MP3 song can not be inserted!');
END;
--EX. FOR THE TRIER
INSERT INTO tracks (MediaTypeId) VALUES(6);

--11.
CREATE TABLE IF NOT EXISTS tracks_audit_log (
Operation TEXT ,
Datettime datetime,
Username TEXT,
Old_value TEXT,
New_value TEXT
);
CREATE TRIGGER tracks_audit_insert 
AFTER INSERT ON TRACKS 
BEGIN
INSERT INTO tracks_audit_log VALUES('INSERT', datetime('now'), 'user', ' ', new.Name);
END;

CREATE TRIGGER  tracks_audit_update
AFTER UPDATE ON tracks
BEGIN
INSERT INTO tracks_audit_log VALUES('UPDATE', datetime('now'), 'user', old.Name, new.Name);
END;


CREATE TRIGGER  tracks_audit_delete
AFTER DELETE ON tracks
BEGIN
INSERT INTO tracks_audit_log VALUES('DELETE', datetime('now'), 'user', Old.Name, ' ');
END;

--tests
INSERT INTO TRACKS (Name, MediaTypeId, Milliseconds, UnitPrice) VALUES('HeloBeloInserted',2,10000, 120);
SELECT * FROM tracks_audit_log;
UPDATE tracks SET Name = 'I want to be deleted' WHERE Name = 'HeloBeloInserted';
SELECT * FROM tracks_audit_log;
DELETE FROM tracks WHERE Name = 'I want to be deleted';
SELECT * FROM tracks_audit_log;


