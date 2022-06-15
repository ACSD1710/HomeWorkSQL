
use SEDCHome
go
/*●Calculate the count of all grades per Teacher in the system*/
-----------1-----------------
Select t.ID, t.FirstName, t.LastName, t.DateOfBirth, t.AcademicRank, t.HireDate, Count(Grade) as Count_AllGrades 
from dbo.Teacher as T
Inner join dbo.Grade as G on T.ID = G.TeacherID
Group by t.ID, t.FirstName, t.LastName, t.DateOfBirth, t.AcademicRank, t.HireDate
Order by t.ID asc

/*●Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)*/
-----------2--------------

Select t.ID, g.StudentID, t.FirstName, t.LastName, t.DateOfBirth, t.AcademicRank, 
t.HireDate, count(Grade) as Count_AllGrades  
from dbo.Grade as G
Inner join dbo.Teacher as T On G.TeacherID = T.ID
Where StudentID < 100
Group by t.ID,g.StudentID, t.FirstName, t.LastName, t.DateOfBirth, t.AcademicRank, t.HireDate
Order by t.ID, g.StudentID asc

/*●Find the Maximal Grade, and the Average Grade per Student on all grades in the system*/
	--------------3---------------

Select S.ID, S.FirstName, S.LastName, S.DateOfBirth, S.EnrolledDate, S.Gender, S.NationalIDNumber, 
S.StudentCardNumber, Max(Grade) as Max_Grade, AVG(Grade) as Average_Grade
from dbo.Grade as G
Inner join dbo.Student as S On g.StudentID = S.ID
Group by S.ID, S.FirstName, S.LastName, S.DateOfBirth, S.EnrolledDate, S.Gender, S.NationalIDNumber, 
S.StudentCardNumber
Order by S.ID asc

/*●Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200*/
	----------------4------------------

Select t.ID, t.FirstName, t.LastName, t.DateOfBirth, t.AcademicRank, t.HireDate, Count(Grade) as Count_AllGrades 
from dbo.Teacher as T
Inner join dbo.Grade as G on T.ID = G.TeacherID
Group by t.ID, t.FirstName, t.LastName, t.DateOfBirth, t.AcademicRank, t.HireDate
Having Count(Grade) > 200 
Order by Count_AllGrades asc

/*●Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. 
	Filter only records where Maximal Grade is equal to Average Grade*/
/*●List Student First Name and Last Name next to the other details from previous query*/
	----------------5, 6--------------------
Select S.ID, S.FirstName, S.LastName, S.DateOfBirth, S.EnrolledDate, S.Gender, S.NationalIDNumber, 
S.StudentCardNumber, Count(Grade) as Count_Grade, Max(Grade) as Max_Grade, AVG(Grade) as Average_Grade
From dbo.Grade as G
Inner join dbo.Student as S On g.StudentID = S.ID
Group by S.ID, S.FirstName, S.LastName, S.DateOfBirth, S.EnrolledDate, S.Gender, S.NationalIDNumber, 
S.StudentCardNumber
Having Max(Grade) = AVG(Grade)
Order by S.FirstName desc

/*●Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student*/
			
			----------7---------------

DROP View IF EXISTS dbo.vv_StudentGrades
go
Create View dbo.vv_StudentGrades
As
Select StudentID, Count(Grade) as Count_Grade
From dbo.Grade
Group by StudentID

Select * 
From dbo.vv_StudentGrades d
Order By StudentID ASc

/*●Change the view to show Student First and Last Names instead of StudentID
	●List all rows from view ordered by biggest Grade Count*/
	 -------8, 9------
Alter view dbo.vv_StudentGrades
AS
Select S.FirstName, S.LastName, COUNT(Grade) as Count_Grade
From dbo.Grade as G
Inner join dbo.Student as S On G.StudentID = S.ID
Group by  S.FirstName, S.LastName

Select * 
From dbo.vv_StudentGrades d
Order By Count_Grade ASC


