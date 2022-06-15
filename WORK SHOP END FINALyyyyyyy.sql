/*Напомена:За потребите на задачата ќе ви биде доставена скрипта со функција за кирилица
1) Да се искреира табела dbo.businessentity_details 
Табелата треба да има foreign key со табелата BusinessEntity.ID.
2) Скрипта со пополнување на вредности ќе биде испратена. 
Да се изврши и по потреба да се корегираат податоците.
3)Дополнително треба да ги има следните ограничувања:
	1)Колоната AccountNumberтреба да биде UNIQUE
	2)Колоната emailтреба да проверува дали содржи знак @ и знак “.”
	3)Првите два знака од колоната Contactтреба да бидат 07.
	4)Да се направи UPDATE на колона comment со вредност:
					Nema zabaleshka za smetkaна сите колини од табелата dbo.businessentity_details
	5)Да се искреира функција за пресметка на вкупна количина на нарачки по продукт
	6)Да се искреира функција за пресметка на вкупна сума на нарачки по продукт
	7)Потребно е да се направи view за приказ на:-име на компанија-регион(пошта -име на регион)-
				број на сметка-адреса, вредноста XXXXда се замени со ‘Улица број’-име на продукт
-вкупна продадена количина по продукт да биде во податочен тип int-вкупна сума по продукт 
да биде дополнета со валута МКДВо искреираното view колоните да се прикажат на 
кирилица и податоците воколоните за име на комапнија, име на регион и име напродукт
исто така да бидатна кирилица.View-то да прикажува само ставки за продукт со име Granola.
На крај да се направи подредување по колона Име на компанија*/

USE SEDC
Go
/*1) Да се искреира табела dbo.businessentity_details 
Табелата треба да има foreign key со табелата BusinessEntity.ID.*/

Drop table if exists dbo.businessentity_details
create table dbo.businessentity_details 
(
 ID int identity(1,1) primary key clustered ([ID] asc),
 BusinessentityID int NOT NULL constraint FK_businessentity_detailsID foreign key ([Businessentityid]) references dbo.businessentity([ID]),
 AccountNumber nvarchar(15) not null,
 [Address] nvarchar(250) not null,
 Contact nvarchar(100) not null,
 email nvarchar(250) not null,
 comment nvarchar(max) NULL
)
-------------------------------------------------------------------------
/*2) Скрипта со пополнување на вредности ќе биде испратена. 
Да се изврши и по потреба да се корегираат податоците.*/
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(0,'210500222333','Partizanski Odredi 15','070555666','aaa@vitalia.com','Nema zabeleshka')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(1,'210500222334','XXXX 15','070779523','bbb@vitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(2,'210500222335','XXXX 16','070779523','ccc@vitalia.com','TEST 1')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(3,'210500222336','XXXX 17','070779523','dddvitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(4,'210500222337','XXXX 18','070779544','vvv@vitalia.com','Nema plateno faktura')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(5,'210500222338','XXXX 19','070779555','ddd@vitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(6,'210500222339','XXXX 20','070779566','aa@vitalia.com','Nevaliden kontakt')
go
-----------------------------------------------------------------------
/*3)Дополнително треба да ги има следните ограничувања:
	1)Колоната AccountNumberтреба да биде UNIQUE
	2)Колоната emailтреба да проверува дали содржи знак @ и знак “.”
	3)Првите два знака од колоната Contactтреба да бидат 07.*/

----------1--------
Alter Table dbo.businessentity_details With check
ADD Constraint UNQ_AccountNumber 
UNIQUE (AccountNumber)
----------2---------
Alter Table dbo.businessentity_details with check
Add Constraint CH_Email
CHECK(email LIKE '%@%.%')
Update dbo.businessentity_details
set email = 'ddd@vitalia.com'
where Id = 4
-----------3----------
Alter Table dbo.businessentity_details with check
Add Constraint CH_Contact
Check(Left(Contact,2) = '07')

select * from dbo.businessentity_details

/*4)Да се направи UPDATE на колона comment со вредност:
					Nema zabaleshka za smetkaна сите колини од табелата dbo.businessentity_details*/

Update dbo.businessentity_details
Set comment = 'Nema zabeleska za smetka na site koloni od tabelata dbo.businessentity_details'


/*5)Да се искреира функција за пресметка на вкупна количина на нарачки по продукт
	6)Да се искреира функција за пресметка на вкупна сума на нарачки по продукт*/

--------------------5-------------------------
Alter Function dbo.Quantity_Of_Product(@ProductId int)
Returns int
AS 
BEGIN
		Declare @Result int
		Select @Result = SUM(Quantity)
		From dbo.[Order] as O
		Inner Join dbo.OrderDetails as Od On O.Id = od.OrderId
		inner join dbo.Product as P ON Od.ProductId = P.Id
		Where Od.ProductId = @ProductId
		Return @Result
END

Select distinct dbo.Quantity_Of_Product(Id) from dbo.Product as Quantity_Of_Product

-------------------6-------------------------

Create function dbo.Amount_Of_Orders_Per_Product(@ProductId int)
Returns int
AS
BEGIN
	Declare @Result int
	Select @Result = sum(P.Price * od.Quantity)
	from dbo.Product as P
	Inner join dbo.OrderDetails as Od ON p.Id = Od.ProductId
	inner join dbo.[Order] as O ON o.Id = od.OrderId
	where od.ProductId = @ProductId
	Return @Result

End


Select distinct dbo.Amount_Of_Orders_Per_Product(Id) from dbo.Product as Amount_Of_Orders_Per_Product



/*	7)Потребно е да се направи view за приказ на:-име на компанија-регион(пошта -име на регион)-
				број на сметка-адреса, вредноста XXXXда се замени со ‘Улица број’-име на продукт
-вкупна продадена количина по продукт да биде во податочен тип int-вкупна сума по продукт 
да биде дополнета со валута МКДВо искреираното view колоните да се прикажат на 
кирилица и податоците воколоните за име на комапнија, име на регион и име напродукт
исто така да бидатна кирилица.View-то да прикажува само ставки за продукт со име Granola.
На крај да се направи подредување по колона Име на компанија*/

Use SEDC
Select * from dbo.BusinessEntity
SElect * from dbo.businessentity_details
Select * from [Order]
Select * from dbo.OrderDetails

Create View dbo.vv_CrazyTAble
AS
	Select  
		b.Name as Име_на_Компанија,
		CONCAT(b.Region,' - ',N'Поштенски Број', ' - ', b.Zipcode) as Регион,
		Bd.AccountNumber as [Број на сметка],
		Replace(bd.Address, 'XXXХ', N'Улица и Број') as [Улица и број],
		P.Name as [Име на Производ],Cast(Sum(od.Quantity) as Int) as [Продадена количина],
		Concat(Sum(od.Quantity * od.Price), ' ', N'МКД') as [Вкупна сума]
From dbo.Product as P
inner join dbo.OrderDetails as OD ON p.Id = OD.OrderId
Inner join dbo.[Order] as O On O.Id = Od.OrderId
Inner Join dbo.BusinessEntity as B On b.Id = O.BusinessEntityId
Inner join dbo.businessentity_details as BD On bd.BusinessentityID = b.Id
Where p.Name = 'Granola'
group by b.Name, b.Region, b.Zipcode, Bd.AccountNumber, bd.Address, p.Name

select * from dbo.vv_CrazyTAble
Order by Име_на_Компанија asc





