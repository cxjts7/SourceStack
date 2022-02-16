--帮帮点说明：新建Credit表，可以记录用户的每一次积分获得过程，
--即：某个用户，在某个时间，因为某某原因，获得若干积分
create table [Credit](
	[Name] nvarchar(20) null,
	[Time]	datetime null,
	reason nvarchar(2) null,
	integral int null
) 

select * from [Credit];
insert [Credit](reason) values(N'单1');
--带N的文字，字母都是一个字符占两个字节


--发布求助，在Problem和User之间建立1:n关联（含约束）。用SQL语句演示：

alter table [User] --drop constraint PK_User_Id;
add constraint PK_User_Id Primary Key(Id);
alter table [User] alter column Id int not null;

alter table Problem
add constraint FK_Problem_Id Foreign Key(Id) 
references [User](Id)
on delete cascade on update set null;

SELECT * FROM Problem;
SELECT * FROM [User];

--某用户发布一篇求助
insert Problem(Id) VALUES(7);
insert Problem(Id, Title) VALUES(7, N'一');

--将该求助的作者改成另外一个用户
update Problem Set Id = 9 where Title = N'一';
--不行，不存在,没有9（实验）
update Problem Set Id = 6 where Title = N'一';
update [User] Set Id = 10 where [UserName] = '18bang';

--删除该用户
delete [User] where Id =6;


--求助列表：新建Keyword表，和Problem形成n:n关联（含约束）。用SQL语句演示：


SELECT * FROM Problem;
SELECT * FROM Keyword;

update Problem Set Id = 2 where Reward = 7;
update Problem Set Id = 2 where Reward = 26;

alter table Keyword add Id2 INT NULL;

DROP TABLE KeywordToProblem;
create table KeywordToProblem(
  Id2	int null,
  Id int null
)

insert KeywordToProblem(Id2, Id) VALUES(11, 2);
insert KeywordToProblem(Id2, Id) VALUES(11, 3);
insert KeywordToProblem(Id2, Id) VALUES(11, 4);
insert KeywordToProblem(Id2, Id) VALUES(12, 5);
insert KeywordToProblem(Id2, Id) VALUES(13, 5);
insert KeywordToProblem(Id2, Id) VALUES(14, 5);
insert KeywordToProblem(Id2, Id) VALUES(15, 7);
insert KeywordToProblem(Id2, Id) VALUES(15, 8);

--给两个主表设立唯一约束
alter table Keyword
add constraint UQ_Keyword_Id2 Unique(Id2);

alter table Problem
add constraint UQ_Problem_Id Unique(Id);

--添加外键约束
alter table KeywordToProblem
add constraint FK_KeywordToProblem_Id2 Foreign Key(Id2)
References Keyword(Id2);

alter table KeywordToProblem
add constraint FK_KeywordToProblem_Id Foreign Key(Id)
References Problem(Id);


--查询获得：每个求助使用了多少关键字，每个关键字被多少求助使用
select count(Id2) as count, Id2 from KeywordToProblem
where Id2 = 15 group by Id2;

select count(Id) as count, Id from KeywordToProblem
where Id = 5 group by Id;

--发布了一个使用了若干个关键字的求助
SELECT * FROM Problem;

insert Problem 
values(10, N'求助', 'help', 1, 17, '2022/2/16', N'张三');

insert KeywordToProblem values(11,10);
insert KeywordToProblem values(12,10);

SELECT * FROM KeywordToProblem;
--该求助不再使用某个关键字
delete KeywordToProblem where Id2 = 11 and Id = 10;


--删除该求助
delete KeywordToProblem where Id = 10;
delete Problem where Id = 10;


--删除某关键字
delete KeywordToProblem where Id2 = 13;
delete Keyword where Id2 = 13;

SELECT * FROM Keyword;