CREATE TABLE [dbo].[Teacher] (
    [Id]     INT          NOT NULL,
    [Name]   NVARCHAR (25) NULL,
    [Age]    INT           NULL,
    [Gender] BIT           NULL,
);

drop table [Teacher]; 

INSERT Teacher(Id) values(1);
INSERT Teacher(Id) values(2);
INSERT Teacher(Id) values(3);
INSERT Teacher(Id) values(4);
INSERT Teacher(Id) values(5);
INSERT Teacher(Id) values(6);
INSERT Teacher(Id) values(7);
INSERT Teacher(Id) values(8);

alter table Teacher add constraint UQ_Teacher_Id Unique(Id);

--删除唯一约束，该约束所依赖的唯一索引会一起被删除么？
alter table Teacher drop constraint UQ_Teacher_Id;
--会

--新建一个UNIQUE约束，会不会利用已有的UNIQUE索引？
create unique index IX_Teacher_Id2 on Teacher(Id);
alter table Teacher add constraint UQ_Teacher_Id Unique(Id);
--会

--删除一个UNIQUE约束依赖的UNIQUE索引，会有什么结果？
drop index Teacher.IX_Teacher_Id2;

SELECT [name], [type], is_unique, is_primary_key, is_unique_constraint 
FROM sys.indexes 
WHERE object_id = OBJECT_ID('Teacher');
--用回系统自建的
--还有系统建的非聚集索引


select Id from Teacher where Id = 1;
select Id from Teacher;

--一个是seek一个是scan

select * from Teacher where Id = 1;