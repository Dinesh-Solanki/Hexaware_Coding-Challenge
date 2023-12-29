/*                                    Dinesh Solanki G   
                        Coding Challenges: Crime Management                           */


--Creating Database
Create Database CrimeManagement

Use CrimeManagement

--Creating Entity
CREATE TABLE Crime (
 CrimeID INT PRIMARY KEY,
 IncidentType VARCHAR(255),
 IncidentDate DATE,
 Location VARCHAR(255),
 Description TEXT,
 Status VARCHAR(20)
)

CREATE TABLE Victim (
 VictimID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 ContactInfo VARCHAR(255),
 Injuries VARCHAR(255),
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);


CREATE TABLE Suspect (
 SuspectID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 Description TEXT,
 CriminalHistory TEXT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

--Inserting Values Into the Tables

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
 (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
 (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
 (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed'),
 (4, 'Assault', '2023-02-15', '2nd block Rajajinagar', 'Physical assault in a bar', 'Open'),
 (5, 'Fraud', '2023-05-20', '30 Rajankune', 'Credit card fraud', 'Closed'),
 (6, 'Robbery', '2023-06-12', '303 church St', 'Robbery at a park', 'Open'),
 (7, 'Homicide', '2023-07-18', '404 Yelankha St', 'murder case', 'Open'),
 (8, 'Assault', '2023-08-25', '505 St', 'Assault at park', 'Open'),
 (9, 'Domestic Violence', '2023-09-30', '606 Spruce St', 'Domestic dispute turned violent', 'Under Investigation'),
 (10, 'Theft', '2023-10-15', '707 Fir St', 'Shoplifting at a retail store', 'Closed');


INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
 (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
 (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
 (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None'),
 (4, 4, 'Dinesh', 'dinesh@gmail', 'Fatal gunshot wound'),
 (5, 5, 'Ravi Doe', 'ravi@gmail', 'Financial loss'),
 (6, 6, 'MDoe Brown', 'mdoe@gmail.com', 'Missing child'),
 (7, 7, 'Cammon Green', 'char@gmail.com', 'None'),
 (8, 8, 'David Miller', 'miller@gmail', 'None'),
 (9, 9, 'David Warner', 'david@gmail', 'Minor injuries'),
 (10, 10, 'GauravDoe ', 'gaurav@gmail', 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
 (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
 (2, 2, 'Unknown', 'Investigation ongoing', NULL),
 (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests'),
 (4, 6, 'Unknown', 'Investigation ongoing', NULL),
 (5, 7, 'Cammon Green', 'Drug trafficking suspect', 'Previous drug offenses'),
 (6, 9, 'David Warner', 'Domestic violence suspect', 'Previous domestic violence incidents'),
 (7, 10, 'Cammon Green', 'Theft suspect', 'Previous theft convictions'),
 (8, 4, 'White', 'Assault suspect', 'Previous assault charges'),
 (9, 3, 'White', 'Fraud suspect', 'Previous fraud convictions'),
 (10, 7, 'Cammon Green', 'Vandalism suspect', 'No known criminal history');
 
--Queries

--1. Select all open incidents.
SELECT * FROM Crime
WHERE status ='Open';

--2. Find the total number of incidents.
SELECT COUNT(*) AS TotalIncidents
FROM Crime;

--3. List all unique incident types.
SELECT DISTINCT IncidentType
FROM Crime;

--4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.
SELECT * FROM Crime
WHERE IncidentDate BETWEEN '2023-09-01' AND '2023-09-10';

--5. List persons involved in incidents in descending order of age.
--Note : No age attribute is been specified in table so here we will be adding age attribute using alter
ALTER TABLE Victim
ADD VAge INT;


ALTER TABLE Suspect
ADD SAge int;

--Adding values of age attribute to suspect and victim table
UPDATE Victim
SET VAge=22
WHERE VictimID=1;

UPDATE Victim
SET VAge=37
WHERE VictimID=2;

UPDATE Victim
SET VAge=47
WHERE VictimID=3;

UPDATE Victim
SET VAge=35
WHERE VictimID=4;

UPDATE Victim
SET VAge=35
WHERE VictimID=5;

UPDATE Victim 
SET Vage=30
WHERE VictimID=6;

UPDATE Victim 
SET Vage=30
WHERE VictimID=7;

UPDATE Victim 
SET Vage=30
WHERE VictimID=8;

UPDATE Victim 
SET Vage=30
WHERE VictimID=9;

UPDATE Victim 
SET Vage=30
WHERE VictimID=10;

UPDATE Suspect
SET SAge=35;

UPDATE Suspect
SET SAge=26
WHERE SuspectID=1;

UPDATE Suspect
SET SAge=53
WHERE SuspectID=2;

UPDATE Suspect
SET SAge=26
WHERE SuspectID=3;

UPDATE Suspect
SET SAge=30
WHERE SuspectID=4;

Select * from Victim
Select * from Suspect

SELECT VictimID, Name, VAge
FROM Victim
ORDER BY VAge DESC;

SELECT SuspectID, Name, SAge
FROM Suspect
ORDER BY SAge DESC;

--6. Find the average age of persons involved in incidents.
with average as(
SELECT AVG(VAge) AS Age
FROM Victim
UNION
SELECT AVG(SAge) 
FROM Suspect)
select avg(age) as 'Average age of persons' from average;


--7. List incident types and their counts, only for open cases.
Select IncidentType, Count(CrimeID) as counts
from Crime
where Status = 'Open'
Group by IncidentType

--8. Find persons with names containing 'Doe'.
SELECT Name
FROM Victim
WHERE Name LIKE '%Doe%'
UNION 
SELECT Name
FROM Suspect
WHERE Name LIKE '%Doe%';

--9. Retrieve the names of persons involved in open cases and closed cases.
SELECT V.VictimID, V.Name, S.SuspectID, S.Name, Status
FROM Victim V
JOIN Crime C ON C.CrimeID = V.CrimeID
JOIN Suspect S ON S.CrimeID = C.CrimeID
WHERE Status IN('Open','Closed');

--10. List incident types where there are persons aged 30 or 35 involved.
SELECT DISTINCT IncidentType
FROM Crime C
JOIN Victim V ON C.CrimeID = V.CrimeID
JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE V.VAge IN (30, 35) OR S.SAge IN (30, 35);

--11. Find persons involved in incidents of the same type as 'Robbery'.
SELECT V.VictimID, V.Name AS VictimName, S.SuspectID, S.Name AS SuspectName
FROM Victim V
JOIN Crime C ON C.CrimeID = V.CrimeID
JOIN Suspect S ON S.CrimeID = C.CrimeID
WHERE C.IncidentType = 'Robbery';

--12. List incident types with more than one open case.
SELECT IncidentType, COUNT(*) AS OpenCaseCount
FROM Crime
WHERE Status = 'Open'
GROUP BY IncidentType
HAVING COUNT(*) > 1;


--13. List all incidents with suspects whose names also appear as victims in other incidents.
SELECT C.CrimeID, C.IncidentType, V.VictimID, V.Name AS VictimName, S.SuspectID, S.Name AS SuspectName
FROM Crime C
JOIN Victim V ON V.CrimeID = C.CrimeID
JOIN Suspect S ON S.CrimeID = C.CrimeID
WHERE S.Name IN (SELECT Name FROM Victim);


--14. Retrieve all incidents along with victim and suspect details.
SELECT C.CrimeID, C.IncidentType, C.IncidentDate, C.Location, C.Description, C.Status,
V.VictimID, V.Name AS VictimName, V.ContactInfo, V.Injuries,
S.SuspectID, S.Name AS SuspectName, S.Description AS SuspectDescription, S.CriminalHistory
FROM Crime C
LEFT JOIN Victim V ON C.CrimeID = V.CrimeID
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;


--15. Find incidents where the suspect is older than any victim.
SELECT C.IncidentType, V.VAge, S.SAge 
FROM Crime C
LEFT JOIN Victim V ON C.CrimeID = V.CrimeID
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE S.SAge > V.VAge;

--16. Find suspects involved in multiple incidents.
SELECT S.SuspectID, S.Name, COUNT(C.CrimeID) AS IncidentCount
FROM Suspect S
JOIN Crime C ON S.CrimeID=C.CrimeID
GROUP BY S.SuspectID, S.Name
HAVING COUNT(C.CrimeID) > 1;
--Note: no such data is available for he above query)


--17. List incidents with no suspects involved.
SELECT C.*
FROM Crime C
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE S.SuspectID IS NULL;

--18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.
SELECT C.*
FROM Crime C
WHERE IncidentType in ('Homicide','Robbery');

--19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.
SELECT C.*, ISNULL(S.Name, 'No Suspect') AS SuspectName
FROM Crime C
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;

--20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'
SELECT S.*
FROM Suspect S
JOIN Crime C ON S.CrimeID = C.CrimeID
WHERE C.IncidentType IN ('Robbery', 'Assault');

