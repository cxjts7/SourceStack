--新建表Message(Id, FromUser, ToUser, UrgentLevel, 
--Kind, HasRead, IsDelete, Content)，使用该表和SQL语句，证明：

--并利用“执行计划”图演示说明：Scan、Seek和Lookup的使用和区别。

drop table Message;
create table Message(
	Id int not null,
	FromUser nvarchar(50) not null,
	ToUser nvarchar(50) not null,
	UrgentLevel int not null,
	Kind nvarchar(50) not null,
	HasRead nvarchar(50) not null,
	IsDelete bit not null,
	Content ntext  null,
)

select * from Message;

insert Message 
values(1, N'赵一', N'钱二', 1, N'鞋', 'has', 0, N'内容');

insert Message 
values(2, N'赵三', N'钱四', 2, N'鞋', 'has', 0, N'内容哈');

insert Message 
values(3, N'赵五', N'钱六', 3, N'鞋', 'has', 1, N'内容一');

insert Message 
values(4, N'赵五', N'钱七', 4, N'鞋', 'has', 1, N'内容二');

insert Message 
values(5, N'赵五', N'钱八', 5, N'鞋', 'has', 1, N'内容三');

select * from Message;

--唯一约束依赖于唯一索引
--设立唯一（UNIQUE）约束：会自动创建一个唯一非聚集索引。
alter table Message 
add constraint UQ_Message_Id unique(Id);

-- [type]：1 聚集; >1 非聚集

SELECT [name], [type], is_unique, is_primary_key, is_unique_constraint 
FROM sys.indexes 
WHERE object_id = OBJECT_ID('Message');

SELECT Id from Message;

--主键上可以是非聚集索引
create unique clustered index IX_Message_UrgentLevel 
on Message(UrgentLevel);

alter table Message 
add constraint PK_Message_Id Primary Key(Id);


-- [type]：1 聚集; >1 非聚集
SELECT [name], [type], is_unique, is_primary_key, is_unique_constraint 
FROM sys.indexes 
WHERE object_id = OBJECT_ID('Message');



