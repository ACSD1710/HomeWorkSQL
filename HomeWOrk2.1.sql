
/*1.Find all Students  with FirstName = Antonio*/

Select *
from dbo.Student
where FirstName ='Antonio'

/*2.Find all Students with DateOfBirth greater than ‘01.01.1999’*/

Select *
from.dbo.Student
where DateOfBirth > '1999.01.01'

/*3.Find all Students with LastName starting With ‘J’ enrolled in January/1998*/

Select * 
from dbo.Student
where FirstName like 'j%'
      and EnrolledDate >='1998.01.01'
	  and EnrolledDate < '1998.02.01'
/*4.List all Students ordered  by FirstName*/

Select * 
from dbo.Student
order by FirstName asc

/*5.List all Teacher  Last Names and Student Last Names in single result set. Remove  duplicates*/

Select LastName
from dbo.Teacher
union 
Select LastName
from Student

/*6.Create  Foreign key constraints  from diagram or with script*/

Alter table dbo.Grade With check
Add constraint [FK_Grade_Student]
Foreign key ([StudentID])
References dbo.Student(Id)

Alter table dbo.Grade With check
Add constraint [FK_Grade_Course]
Foreign key ([CourseID])
References dbo.Course (Id)

Alter table dbo.Grade With check
Add constraint [FK_Grade_Teacher]
Foreign key ([TeacherID])
References dbo.Teacher (ID)

Alter table dbo.GradeDetails With check
Add Constraint [FK_GradeDetails_AchievementTypeID]
Foreign key ([AchievementTypeID])
References dbo.AchievementType (ID)

Alter table dbo.GradeDetails With check
Add constraint [FK_GradeDetails_GradeId]
Foreign key ([GradeId])
References dbo.Grade (ID)

/*List all possible combinations  of Courses  names and AchievementType names that can be passed  by student*/

/*Select c.Name, ACT.Name
From
dbo.[Grade] as G
Cross join dbo.[Course] as C
Cross join dbo.[GradeDetails] as GD
Cross join dbo.AchievementType as ACT 
Group by c.Name, ACT.Name*/

Select c.Name, ACT.Name
From dbo.Course as c
cross join dbo.AchievementType as ACT
Group by c.Name, ACT.Name 
Order by c.Name Asc

/*List all Teachers  without exam Grade*/
Select t.*
from dbo.Teacher as T
inner join dbo.Grade as G on G.TeacherID = T.ID
where g.TeacherID = 0
-- where g.TeacrId is null vaka ne dava nitu eden 





