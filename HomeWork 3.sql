Use SEDCHome
--●Calculate the count of all grades per Teacher in the system
Select t.FirstName, t.LastName, Count(Grade) as CountGrade
From dbo.Grade as G
Inner join dbo.Teacher as T on T.ID = g.TeacherID
Group by FirstName, LastName

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
Select s.FirstName, s.FirstName, s.ID, count(Grade) as CountGrade
From dbo.Grade as G
Inner join dbo.Student as S On G.StudentID = s.ID
Where s.ID < 100
Group by FirstName, LastName, s.ID

--●Find the Maximal Grade, and the Average Grade per Student on all grades in the system

/*
     ---Prvicno vaka go napisav i ne raboti---
Select s.FirstName, s.LastName, AVG(Grade) as AveradgeGrade, MAX(Grade) as MaxGrade
From dbo.Grade as G                 
Inner join dbo.Student as S On g.StudentID = s.ID
Group by FirstName, LastName
*/

Select s.FirstName, s.LastName,
MAX(Grade) as MaxGrade, -- Zosto tuka ne mi ja dava maksimalnata otcenka???
AVG(CAST([Grade] as DECIMAL(9,2))) AS [Average of Grade] --  ova go najdov od net!!!?? Zost AVG(Grade) dava error ????
From dbo.Grade as G
Inner join dbo.Student as S On G.StudentID = S.ID
group by FirstName, LastName

/*Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200*/

Select t.FirstName, t.LastName, Count(Grade) as CountGrade
From dbo.Grade as G
Inner join dbo.Teacher as T on T.ID = g.TeacherID
Group by FirstName, LastName
Having COUNT(Grade) > 200

/*Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system.
Filter only records where Maximal Grade is equal to Average Grade*/
Select g.StudentID,
MAX(Grade) as MaxGrade, 
AVG(CAST([Grade] as INT)) AS [Average of Grade]
From dbo.Grade as G
Inner join dbo.Student as S On G.StudentID = S.ID
group by StudentID
Having MAX(Grade) = AVG(CAST([Grade] as INT))

/*●List Student First Name and Last Name next to the other details from previous query*/
Select s.FirstName,s.LastName,
MAX(Grade) as MaxGrade, 
AVG(CAST([Grade] as INT)) AS [Average of Grade]
From dbo.Grade as G
Inner join dbo.Student as S On G.StudentID = S.ID
group by FirstName, LastName
Having MAX(Grade) = AVG(CAST([Grade] as INT))

/*●Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student*/

Create View dbo.vv_StudentGrades
as
Select g.StudentID, Count(Grade) as CountGrades
from dbo.Grade as G
group by g.StudentID 


Select * from dbo.vv_StudentGrades order by StudentID asc

/*●Change the view to show Student First and Last Names instead of StudentID*/

Alter View dbo.vv_StudentGrades
as
Select s.FirstName, s.LastName, Count(Grade) as CountGrades
from dbo.Grade as G
inner join dbo.Student as S On g.StudentID = S.ID
group by s.FirstName, s.LastName

/*List all rows from view ordered by biggest Grade Count*/
Select * from dbo.vv_StudentGrades order by CountGrades Desc






select MAX(Grade) from dbo.Grade

select * from dbo.GradeDetails
select * from dbo.AchievementType
select * from dbo.Grade
Select * from dbo.Teacher
select * from dbo.Student