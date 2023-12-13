--                                   Dinesh Solanki G   
 --                       Coding Challenges: CareerHub, The Job Board              


--1 Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”. 
Create database CareerHub;
use CareerHub;

--2. Create tables for Companies, Jobs, Applicants and Applications. 
-- Companies table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(50),
    Location VARCHAR(100)
);

-- Jobs table
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(50),
    JobDescription TEXT,
    JobLocation VARCHAR(100),
    Salary DECIMAL,
    JobType VARCHAR(50),
    PostedDate DATETIME,
);

-- Applicants table
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FirstName VARCHAR(25),
    LastName VARCHAR(25),
    Email VARCHAR(50),
    Phone VARCHAR(12),
    Resume TEXT
);

-- Applications table
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME,
    CoverLetter TEXT,
);

--3. Define appropriate primary keys, foreign keys, and constraints. 

-- Add foreign key to Jobs table
ALTER TABLE Jobs
ADD CONSTRAINT FK_Jobs_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID);

-- Add foreign key to Applications table referencing Jobs table
ALTER TABLE Applications
ADD CONSTRAINT FK_Applications_Jobs FOREIGN KEY (JobID) REFERENCES Jobs(JobID);

-- Add foreign key to Applications table referencing Applicants table
ALTER TABLE Applications
ADD CONSTRAINT FK_Applications_Applicants FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID);


-- Inserting data into Companies table
INSERT INTO Companies
VALUES
    (1, 'Hexaware', 'Chennai'),
    (2, 'Capgemini', 'Bangalore'),
    (3, 'Vedantu', 'Mumbai'),
    (4, 'Google', 'Bangalore'),
    (5, 'Microsoft', 'Bangalore'),
    (6, 'Amazon', 'Pune'),
    (7, 'Adobe', 'Delhi'),
    (8, 'Netflix', 'Jaipur');
    

-- Inserting data into Jobs table
INSERT INTO Jobs 
VALUES
    (1, 1, 'Software Engineer', 'Develop software applications', 'Chennai', 85000.00, 'Full-time', '2023-01-01 08:00:00'),
    (2, 7, 'Marketing Specialist', 'Implement marketing strategies', 'Delhi', 62000.00, 'Part-time', '2023-01-02 10:30:00'),
    (3, 3, 'Data Analyst', 'Analyze data', 'Mumbai', 65000.00, 'Full-time', '2023-01-03 12:00:00'),
    (4, 2, 'UX/UI Designer', 'Design user interfaces', 'Bangalore', 85000.00, 'Full-time', '2023-01-04 14:30:00'),
    (5, 6, 'Graphic Designer', 'Create visual concepts', 'Pune', 50000.00, 'Part-time', '2023-01-05 09:45:00'),
    (6, 5, 'Software Tester', 'Test software applications', 'Bangalore', 55000.00, 'Full-time', '2023-01-06 11:15:00'),
    (7, 4, 'Financial Analyst', 'Conduct financial analysis', 'Bangalore', 72000.00, 'Full-time', '2023-01-07 13:30:00'),
    (8, 8, 'Customer Support', 'Assist customers', 'Jaipur', 50000.00, 'Part-time', '2023-01-08 15:45:00');
    

-- Inserting data into Applicants table
INSERT INTO Applicants 
VALUES
    (1, 'Dinesh', 'Solanki', 'dineshsg@email.com', '9535905179', 'Resume for Dinesh Solanki'),
    (2, 'Ashok', 'Rathore', 'ashokrathore@email.com', '2579854126', 'Resume for Ashok rathore'),
    (3, 'Rohit', 'Singh', 'rohitsingh@email.com', '9856874589', 'Resume for Rohit Singh'),
    (4, 'Karthik', 'Jha', 'karthik@email.com', '5678901234', 'Resume for Karthik Jha'),
    (5, 'Akansh', 'Jha', 'akanshjn@email.com', '7890123456', 'Resume for Akansh Jha'),
    (6, 'Ravi', 'Ujwal', 'raviujwal@email.com', '901-234-5678', 'Resume for Ravi Ujwal'),
    (7, 'David', 'Miller', 'davidm@email.com', '2259688901', 'Resume for David Miller'),
    (8, 'Swift', 'Taylor', 'swuifttaylor@email.com', '4561258962', 'Resume for Swift Taylor');
    

-- Inserting data into Applications table
INSERT INTO Applications 
VALUES
    (1, 1, 1, '2023-01-03 12:45:00', 'Cover letter for Software Engineer from Dinesh Solanki'),
    (2, 2, 2, '2023-01-04 14:20:00', 'Cover letter for Marketing Specialist from Ashok rathore'),
    (3, 3, 3, '2023-01-05 15:30:00', 'Cover letter for Data Analyst from Rohit Singh'),
    (4, 4, 4, '2023-01-06 16:45:00', 'Cover letter for UX/UI Designer from Karthik Jha'),
    (5, 5, 5, '2023-01-07 18:00:00', 'Cover letter for Graphic Designer from Akansh Jha'),
    (6, 6, 6, '2023-01-08 19:15:00', 'Cover letter for Software Tester from Laura Miller'),
    (7, 7, 7, '2023-01-09 20:30:00', 'Cover letter for Financial Analyst from Ravi Ujwal'),
    (8, 7, 8, '2023-01-10 21:45:00', 'Cover letter for Financial Analyst from Swift Taylor');
    
--4 Ensure the script handles potential errors, such as if the database or tables already exist.
   
   select * from Companies;

-- 5.Write an SQL query to count the number of applications received for each job listing in the
--"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all
--jobs, even if they have no applications  

SELECT
    J.JobID,
    J.JobTitle,
    COUNT(A.ApplicationID) AS ApplicationCount
FROM
    Jobs J
LEFT JOIN
    Applications A ON J.JobID = A.JobID
GROUP BY
    J.JobID, J.JobTitle;
    
 
--6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary
--range. Allow parameters for the minimum and maximum salary values. Display the job title,
--company name, location, and salary for each matching job.

SELECT
    J.JobTitle,
    C.CompanyName,
    J.JobLocation,
    J.Salary
FROM
    Jobs J
JOIN
    Companies C ON J.CompanyID = C.CompanyID
WHERE
    J.Salary >= 50000
    AND J.Salary <= 80000;
    
    
--7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a
--parameter for the ApplicantID, and return a result set with the job titles, company names, and
--application dates for all the jobs the applicant has applied to.

SELECT
    J.JobTitle,
    (SELECT CompanyName FROM Companies WHERE CompanyID = J.CompanyID) AS CompanyName,
    A.ApplicationDate
FROM
    Applications A
JOIN
    Jobs J ON A.JobID = J.JobID
WHERE
    A.ApplicantID = 1;
    

--8. Create an SQL query that calculates and displays the average salary offered by all companies for
--job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.

SELECT
    AVG(Salary) AS AvgSalary
FROM
    Jobs
WHERE
    Salary > 0;
    
--9. Write an SQL query to identify the company that has posted the most job listings. Display the
--company name along with the count of job listings they have posted. Handle ties if multiple
--companies have the same maximum count.

SELECT TOP 1 WITH TIES
    C.CompanyName,
    COUNT(J.JobID) AS JobCount
FROM
    Companies C
LEFT JOIN
    Jobs J ON C.CompanyID = J.CompanyID
GROUP BY
    C.CompanyID, C.CompanyName
ORDER BY
    JobCount DESC;
    
--10. Find the applicants who have applied for positions in companies located in 'CityX' and have at
--least 3 years of experience.

ALTER TABLE Applicants
ADD Experience INT;

UPDATE Applicants
SET Experience = 4 
WHERE ApplicantID = 1; 

SELECT DISTINCT a.FirstName, a.LastName
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'Chennai'
AND DATEDIFF(YEAR, a.Experience, GETDATE()) >= 3;
	
 -- 11.Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.

SELECT DISTINCT
    JobTitle,
    Salary
FROM
    Jobs
WHERE
    Salary BETWEEN 60000 AND 80000;
    
-- 12. Find the jobs that have not received any applications

SELECT
    J.*
FROM
    Jobs J
LEFT JOIN
    Applications A ON J.JobID = A.JobID
WHERE
    A.ApplicationID IS NULL;
    

--13.Retrieve a list of job applicants along with the companies they have applied to and the positions  they have applied for.
SELECT a.FirstName ,a.LastName,c.CompanyName ,j.jobTitle FROM Applicants a
JOIN Applications ap ON a.ApplicantID =ap.ApplicantID
JOIN Jobs J ON ap.JobID=j.JobID
JOIN Companies c ON j.CompanyID =c.CompanyID;

--14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not  received any applications.

SELECT c.CompanyName ,COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID =j.CompanyID
GROUP BY c.CompanyName;

--15. List all applicants along with the companies and positions they have applied for, including those  who have not applied

SELECT a.FirstName , a.LastName ,c.CompanyName ,j.JobTitle
FROM Applicants a
LEFT JOIN Applications ap ON a.ApplicantID=ap.ApplicantID
LEFT JOIN Jobs j ON ap.JobID =j.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID;

--16. Find companies that have posted jobs with a salary higher than the average salary of all jobs.

SELECT DISTINCT
    C.CompanyName
FROM
    Companies C
JOIN
    Jobs J ON C.CompanyID = J.CompanyID
WHERE
    J.Salary > (SELECT AVG(Salary) FROM Jobs);
    
--17. Display a list of applicants with their names and a concatenated string of their city and state.


ALTER TABLE Applicants
ADD City VARCHAR(50),
    State VARCHAR(50);

UPDATE Applicants
SET City = 'Bangalore', State = 'Karnataka'
WHERE ApplicantID = 1;

UPDATE Applicants
SET City = 'Chennai', State = 'TamilNadu'
WHERE ApplicantID = 2;

UPDATE Applicants
SET City = 'Bangalore', State = 'Karnataka'
WHERE ApplicantID = 3;

UPDATE Applicants
SET City = 'Mumbai', State = 'Maharashtra'
WHERE ApplicantID = 3;


SELECT
    ApplicantID,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    CONCAT(City, ', ', State) AS Location
FROM
    Applicants; 
    
--18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.

SELECT
    *
FROM
    Jobs
WHERE
    JobTitle LIKE '%Developer%'
    OR JobTitle LIKE '%Engineer%';    

 --19. Retrieve a list of applicants and the jobs they have applied for, including those who have not
--applied and jobs without applicants.

SELECT
    A.FirstName,
    A.LastName,
    J.JobTitle
FROM
    Applicants A
LEFT JOIN 
    Applications AP ON A.ApplicantID = AP.ApplicantID
LEFT JOIN 
    Jobs J ON AP.JobID = J.JobID;

--20. List all combinations of applicants and companies where the company is in a specific city and the
--applicant has more than 2 years of experience. For example: city=Chennai 

SELECT
    A.ApplicantID,
    A.FirstName,
    A.LastName,
    A.Experience,
    C.CompanyID,
    C.CompanyName,
    C.Location AS CompanyLocation
FROM
    Applicants A
CROSS JOIN
    Companies C
WHERE
    C.Location = 'Chennai'
    AND A.Experience > 2;    
    
    
    