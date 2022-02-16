drop table [Student3];
create table [Student3](
	Id  int  null,
	[Name]  nvarchar(30) not null,
	TeacherId int null 
)



drop table [Teacher3];
create table [Teacher3](
	Id  int  null,
	[Name]  nvarchar(30) not null,
)

select * from [Student3];
select * from [Teacher3];


alter table [Teacher3] add constraint UQ_Teacher3_Id
Unique(Id);

alter table [Student3]
add constraint FK_Student3_TeacherId 
Foreign Key(TeacherId) references [Teacher3](Id)
ON DELETE CASCADE	-- 在主表数据被删除时自动删除所有从表数据
ON UPDATE SET NULL;	-- 在主表主键被更新时自动设置相应从表外键值为NULL

delete [Teacher3] where Id = 11;
update [Teacher3] set Id =13 where Name = N'二';
