
--观察一起帮的“关键字”功能，新建Keywords表，
--要求带一个自增的主键Id，起始值为10，步长为5；并存入若干条数据
create table Keywords(
	[Id] int identity(10, 5),
	UserName nvarchar(20),
	Used varchar(20)
)

insert Keywords(UserName, Used) values('html', 32);
insert Keywords(UserName, Used) values('css', 13);
insert Keywords(UserName, Used) values('javascript', 55);
insert Keywords(UserName, Used) values('sql', 18);
insert Keywords(UserName, Used) values('c#', 97);
insert Keywords(UserName, Used) values('Linux', 12);

select * from Keywords