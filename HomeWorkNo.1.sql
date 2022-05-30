CREATE DATABASE SEDCHome

USE SEDCHome
GO

CREATE TABLE dbo.Student
(
  [ID] int identity (1,1) NOT NULL,
  [FirstName] nvarchar(100) NOT NULL,
  [LastName] nvarchar (100) NOT NULL,
  [DateOfBirth] date NULL,
  [EnrolledDate] date NULL,
  [Gender] nchar (1) NULL,
  [NationalIDNumber] nvarchar (20) NULL,
  [StudentCardNumber] nvarchar (20) NULL,

  CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED (ID)
)
CREATE TABLE dbo.Teacher
(
 [ID] int identity (1,1) NOT NULL,
 [FirstName] nvarchar (100) NOT NULL,
 [LastName] nvarchar (100) NOT NULL,
 [DateOfBirth] date NULL,
 [AcademicRank] nvarchar (100) NULL,
 [HireDate] date NULL,
 
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED (ID)
)

CREATE TABLE dbo.Grade
(
  [ID] int identity (1,1) NOT NULL,
  [StudentID] int NOT NULL,
  [CourseID] int NOT NULL,
  [TeacherID] int NOT NULL,
  [Grade] nchar(2) NULL,
  [Comment] nvarchar(MAX) NULL,
  [CreatedDate] date NULL,
  
  CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED (ID)
)

CREATE TABLE dbo.Course
( 
  [ID] int identity (1,1) NOT NULL,
  [Name] nvarchar (50) NOT NULL,
  [Credit] nvarchar(50) NOT NULL,
  [AcademicYear] date NOT NULL,
  [Semester] nchar(2) NOT NULL

  CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED (ID)
)

CREATE TABLE dbo.GradeDetails 
(
 [ID] int identity (1,1) NOT NULL,
 [GradeID] int NULL,
 [AchievementTypeID] int NULL,
 [AchievementPoints] int NULL,
 [AchievementMaxPoint] int NULL,
 [AchievementDate] date NOT NULL,

 CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED (ID)
)

CREATE TABLE dbo.AchievementType
(
 [ID] int identity (1,1) NOT NULL,
 [Name] nvarchar (200) NOT NULL,
 [Discription] nvarchar (MAX) NULL,
 [ParticipationRate] nvarchar NULL,
)