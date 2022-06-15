/*
  

 
  


*/

use SEDCHome

--1 ●Requirements○Find all Students  with FirstName = Antonio○ 
Select * 
from dbo.Student
Where FirstName = 'Antonio'

---2 ●Find all Students with DateOfBirth greater than ‘01.01.1999’○ ---
Select *
from dbo.Student
Where DateOfBirth > '1999.01.01'

--3  ●Find all Students with LastName starting With ‘J’ enrolled in January/1998--

Select Student.*
from dbo.Student
Where LastName like 'J%' and
EnrolledDate >= '1998.01.01' and 
EnrolledDate < '1998.02.01'

-- 4. ●List all Students ordered  by FirstName

Select *
from dbo.Student
Order by FirstName Asc

-- 5.●List all Teacher  Last Names and Student Last Names in single result set. Remove  duplicates

Select LastName
from dbo.Teacher
Union
Select LastName
from dbo.Student

-- 6 ●List all possible combinations  of Courses  names and AchievementType names that can be passed  by student

Select c.Name, a.Name
from dbo.Grade as G
cross join dbo.Course as C 
Cross join dbo.GradeDetails as GD
Cross join dbo.AchievementType as A


-- 7 ●List all Teachers  without exam Grade

Select  
t.ID, t.FirstName , t.LastName, t.AcademicRank, t.DateOfBirth, t.HireDate, g.ID, g.TeacherID,g.StudentID, G.CreatedDate,
g.CreatedDate
from dbo.Teacher as T
inner join dbo.Grade as G On t.ID = g.TeacherID