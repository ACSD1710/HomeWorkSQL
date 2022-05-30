
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

