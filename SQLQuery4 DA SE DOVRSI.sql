select * from dbo.BusinessEntity

insert into dbo.[Order](OrderDate,
						Status,
						BusinessEntityId,
						CustomerId,
						EmployeeId,
						TotalPrice,
						Comment)
select '2019.05.01', 0, 1, 1, 200, 100, 'Test'


select * from dbo.[Order]
where BusinessEntityId = 100

alter table dbo.[Order] with check
add constraint [FK_Order_BusinessEntity]
foreign key ([BusinessEntityId])
references dbo.BusinessEntity(Id)

update dbo.[Order]
set BusinessEntityId = 1
where Id in (4200)

alter table dbo.[Order] with check
add constraint [FK_Order_Customer]
foreign key ([CustomerId])
references dbo.Customer(Id)

alter table.dbo.[Order] with check
add constraint [FK_Order_Employee]
foreign key ([EmployeeId])
references dbo.Employee(Id)

alter table dbo.[OrderDetails] with check
add constraint [FK_OrderDetails_Order]
foreign key([OrderId])
references dbo.[Order](Id)


alter table dbo.OrderDetails with check
add constraint [Fk_OrderDetails_Product]
foreign key ([ProductId])
references dbo.[Product](Id)


/*=============JOIN TYPER===============*/
/*DROP TABLE IF EXIST TABLEA*/--Good Practice
 /*
 ●List all possible combinations of Customer names and Product names that can be ordered from specific customer 
 ●List all Business Entities that has any order
 ●List all Entities without orders
 ●List all Customers without orders (using Right Join and using Left join)
*/
select b.name, o.OrderDate, o.TotalPrice 
from dbo.BusinessEntity as b
inner join dbo.[Order] as o on b.Id = o.BusinessEntityId

select b.*
from dbo.BusinessEntity as b
left join dbo.[Order] as o on b.Id = o.BusinessEntityId
where o.Id is null

select c.*
from dbo.Customer as c
left join dbo.[Order] as o on c.Id = o.CustomerId
where o.CustomerId is null

select c.*
from dbo.[Order] as o
right join dbo.Customer as c on c.Id = o.CustomerId
where o.CustomerId is null

select c.Name,p.Name
from dbo.Customer as c
cross join dbo.Product as p

/* Grupping functions FILTERING DATA*/

select count(*)
from dbo.Employee

select Gender, count(*) as Total
from dbo.Employee
group by Gender

/*
•Calculate the total amount on all orders in the system
•Calculate the total amount per BusinessEntity on all orders in the system
•Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 20
•Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system
•Suggest a question about some information that needs to be extracted from the Orders table
*/
/*•Calculate the total amount on all orders in the system*/
select sum(TotalPrice) as TotalPrice
from dbo.[Order]

/*•Calculate the total amount per BusinessEntity on all orders in the system*/
select b.Name, sum(TotalPrice) 
from dbo.[Order] as o
inner join dbo.BusinessEntity as b on b.Id = o.BusinessEntityId
group by Name



