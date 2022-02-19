select [UserName] from [User] where Password IS NULL;
use [17bang];
begin tran
delete [User] where [UserName] like '%17bang%' or [UserName] like '%Admin%';
rollback 

delete Problem

select * from Problem;


--id大小写不区分吗 不区分
insert Problem(id, Reward, PublishDateTime) values(1, 7, '2022/1/1');
insert Problem(id, Reward, PublishDateTime) values(2, 5, '2019/1/2');
insert Problem(id, Reward, PublishDateTime) values(3, 17, '2022/1/3');
insert Problem(id, Reward, PublishDateTime) values(4, 27, '2019/1/4');
insert Problem(id, Reward, PublishDateTime) values(5, 37, '2022/1/5');
insert Problem(id, Title, Reward, PublishDateTime) values(6, N'数据库', 47, '2021/1/5');
insert Problem(id, Title, Reward, PublishDateTime) values(7, N'数据%库', 57, '2021/12/5');
insert Problem(id, Title, Reward, PublishDateTime) values(8, N'一%二', 77, '2021/8/5');
insert Problem(id, Title, Reward, PublishDateTime) values(9, N'数据库%一二三', 97, '2021/8/8');
insert Problem(id, Title, Reward, PublishDateTime) values(10, N'1234数据库一二三', 98, '2017/8/8');

delete Problem where id = 2;

alter table Problem alter column Title nvarchar(18);

select * from Problem;





--前缀？汉字？n数据类型中也得是
update Problem set Title = concat(N'[推荐]',Title) where Reward > 10;
update Problem set Title = concat(N'[加急]',Title)
where Reward > 10 and PublishDateTime > '2019/10/10';

--转义？  注意''
begin tran
delete Problem where Title like '#[%#]%' ESCAPE '#';
rollback

--查找Title中第8个起，字符不为“数据库”且包含了百分号（%）的求助
--还是没有想到如何不用and直接写在一起咋弄
--(如果id不是按顺序排的咋办  字符不为“数据库" '#'作用位置)
select * from Problem 
where Title not like N'________数据库%' and Title like '%#%%'
escape '#';



drop table Keyword;
CREATE TABLE [dbo].[Keyword] (
    [Name] NVARCHAR (12) NOT NULL,
    [Used] INT       NOT NULL,
    PRIMARY KEY CLUSTERED ([Name] ASC)
);

delete Keyword;
select * from Keyword;

--表是空的，表头的数据类型可以随便改吗? 是的
alter table Keyword alter column [Name] nvarchar(12);


insert Keyword values(N'赵一',3);
insert Keyword values(N'钱二',40);
insert Keyword values(N'孙三',0);
insert Keyword values(N'李四',120);
insert Keyword values(N'周五',10);
--between and 是包含边界的
select [Name] from Keyword where Used > 10 and Used < 50;

update Keyword set Used = 1 where Used <=0 or Used is null or Used >100; 

begin tran
delete Keyword where Used % 2 =1;
rollback

select * from [User];

drop table [User];

CREATE TABLE [dbo].[User] (
    [UserName] NVARCHAR (18) NOT NULL,
    [Password] NVARCHAR (20) NULL,
);

INSERT [User]([UserName], Password) values('17bang', 1234);
INSERT [User]([UserName], Password) values('Admin', NULL);
INSERT [User]([UserName]) values('Admin-1');
INSERT [User]([UserName], Password) values('SuperAdmin', 123456);

alter table [User] drop column Id;
--在User表上的基础上：添加Id列，让Id成为主键
--(之前列有数据，新增id没数据和主键矛盾了，所以不行)
alter table [User] add Id int primary key(Id);

--ALTER TABLE [User] DROP CONSTRAINT;

--添加约束，让UserName不能重复（这个命名为啥没有表名，可以按自己习惯来）
alter table [User] add constraint UQ_UserName unique([UserName]);

--注意约束与表中数据的矛盾
--在Problem表的基础上：为NeedRemoteHelp添加NOT NULL约束，再删除NeedRemoteHelp上NOT NULL的约束(相当于变成null)
update Problem set NeedRemoteHelp = 1;
alter table Problem alter column NeedRemoteHelp bit not null;
alter table Problem alter column NeedRemoteHelp bit null;

--添加自定义约束，让Reward不能小于3
alter table Problem add constraint CK_Reward check(Reward > 3);