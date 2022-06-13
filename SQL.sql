Create database Store

use Store

Create Table Brands
(
	Id int primary key identity(1,1),
	Name nvarchar(50) not null,

)

Create Table Notebooks 
(
	Id int primary key identity(1,1),
	Name nvarchar(50) not null,
	Price money,
	BrandId int foreign key references Brands(Id)
)

Create Table Phones
(
	Id int primary key identity(1,1),
	Name nvarchar(50) not null,
	Price money,
	BrandId int foreign key references Brands(Id)
)

--3) Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.

Select (Brands.Name+' '+Notebooks.Name) as 'BrandName',Notebooks.Price from Notebooks
Join Brands on Notebooks.BrandId=Brands.Id

--4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
Select (Brands.Name+' '+Phones.Name) as 'BrandName',Phones.Price from Phones
Join Brands on Phones.BrandId=Brands.Id

--5) Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
Select n.Name,n.Price,b.Name from Notebooks n
join Brands b on n.BrandId= b.Id where (b.Name like '%s%')

--6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.
Select * from Notebooks where  (price between 2000 and 5000) or price >5000

--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
select * from Phones where (price between 1000 and 1500)  or price>1500

--8) Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
Select Brands.Name, COUNT(Notebooks.Name) from Notebooks 
join Brands on Notebooks.BrandId=Brands.Id
group by Brands.Name

--9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
select Brands.Name,count(*) from Phones
join Brands on Phones.BrandId=Brands.Id
group by Brands.Name

--10) Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.

select Notebooks.Name,Notebooks.BrandId from Notebooks inner join Phones on Notebooks.Name=Phones.Name

--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
select * from Notebooks 
union 
select * from Phones

--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
select Notebooks.Id,Notebooks.Name,Notebooks.Price,Brands.Name as 'BrandName'from Notebooks join Brands on Notebooks.BrandId=Brands.Id
union 
select Phones.Id,Phones.Name,Phones.Price,Brands.Name as 'BrandName' from Phones join Brands on Phones.BrandId=Brands.Id

--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
select n.Id,n.Name,n.Price,b.Name as 'BrandName' from Notebooks n join Brands b on n.BrandId=b.Id where n.Price>1000
union 
select p.Id,p.Name,p.Price,b.Name as 'BrandName' from Phones p join Brands b on p.BrandId=b.Id where p.Price>1000

--14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple                   6750                3
--Samsung            3500                4
--Redmi                 800                1

select b.Name as 'BrandName',SUM(p.Price) as 'TotalPrice', COUNT(p.Name) as 'ProductCount' from Phones p 
join Brands b on p.BrandId=b.Id
group by b.Name


--15) Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple                    6750                3
--Samsung              3500                4


select b.Name as 'Brandname', SUM(n.Price) as 'TotalPrice', COUNT(n.Name) as 'ProductCount' from Notebooks n
join Brands b on n.BrandId=b.Id
group by b.Name