--关闭开启自增列
--set identity_insert 某表 on；
--set identity_insert 某表 off;


--将User表中Id列修改为可存储GUID的类型，并存入若干条包含GUID值的数据
select * from [User];
--alter table [User] alter column Id varchar(50);
alter table [User] drop column Id;
alter table [User] add Id varchar(50);
insert [User]([UserName], Id) values('18bang', newid());
insert [User]([UserName], Id) values('19bang', newid());
insert [User]([UserName], Id) values('20bang', newid());
insert [User]([UserName], Id) values('21bang', newid());


--Teacher表已有Id列，如何给该列加上IDENTITY属性？
--建一个一样的新表加上identity，关闭自增，复制数据，再打开。
DROP TABLE Teacher2;

CREATE TABLE [dbo].[Teacher2] (
    [Id]     INT IDENTITY   NOT NULL,
    [Name]   NVARCHAR (25) NULL,
    [Age]    INT           NULL,
    [Gender] BIT           NULL,
);


SET IDENTITY_INSERT Teacher2 ON;

SELECT * FROM Teacher;
SELECT * FROM Teacher2;

INSERT  Teacher2(Id, [Name], Age, Gender)
SELECT Id, [Name], Age, Gender FROM Teacher; 
--


SET IDENTITY_INSERT Teacher2 OFF;

