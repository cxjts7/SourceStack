--创建求助的应答表 TResponse(Id, Content, AuthorId,
--ProblemId, CreateTime)
create table TResponse
(
	Id int,
	Content nvarchar(max),
	AuthorId int constraint FK_Response_User Foreign Key 
	references [User](Id),
	ProblemId int constraint FK_Response_Problem Foreign Key 
	references Problem(Id),
	CreateTime datetime
);

select * from TResponse;


--然后生成一个视图VResponse(ResponseId, Content, 
--AuthorId, AuthorName, ProblemId, ProblemTitle, CreateTime)，
--要求该视图：
--能展示应答作者的用户名、应答对应求助的标题和作者用户名
--只显示求助悬赏值大于15的数据
--已被加密
--保证其使用的基表结构无法更改

go
create view VResponse
with schemabinding, encryption
as 
select 
	R.Id  ResponseId, 
	R.Content Content, 
	R.AuthorId AuthorId, 
	RU.UserName AuthorName, 
	R.ProblemId ProblemId, 
	P.Title ProblemTitle, 
	R.CreateTime CreateTime,
	P.Reward Reward
from dbo.TResponse R
	join dbo.[User] RU on R.AuthorId = RU.Id
	join dbo.Problem P on R.ProblemId = P.Id
	join dbo.[User] PU on P.Id = PU.Id	
where P.Reward > 15;

go
SELECT * FROM Problem;
SELECT * FROM [User];
SELECT * FROM TResponse;

SELECT * FROM VResponse;


--演示：在VResponse中插入一条数据，却不能在视图中显示
--也得连接上
insert VResponse(AuthorId, ProblemId, Reward)
values(8, 8, 18);
--不能影响多表

--修改VResponse，让其能避免上述情形
go
ALTER VIEW VResponse
WITH SCHEMABINDING, encryption
AS SELECT 
	R.Id  ResponseId, 
	R.Content Content, 
	R.AuthorId AuthorId, 
	RU.UserName AuthorName, 
	R.ProblemId ProblemId, 
	P.Title ProblemTitle, 
	R.CreateTime CreateTime,
	P.Reward Reward
from dbo.TResponse R
	join dbo.[User] RU on R.AuthorId = RU.Id
	join dbo.Problem P on R.ProblemId = P.Id
	join dbo.[User] PU on P.Id = PU.Id	
WHERE P.Reward > 15 WITH CHECK OPTION



--创建视图VProblemKeyword(ProblemId, ProblemTitle, ProblemReward, 
--KeywordAmount)，要求该视图：
--能反映求助的标题、使用关键字数量和悬赏
--在ProblemId上有一个唯一聚集索引
--在ProblemReward上有一个非聚集索引

go
create view VProblemKeyword
with schemabinding
as select
	P.Id ProblemId, 
	P.Title ProblemTitle, 
	P.Reward ProblemReward, 
	K.Used KeywordAmount 
from dbo.Problem P join dbo.Keyword K on P.Id =K.Id2;
go

--索引列的数据类型必须足够“大”，比如INT不够只能是BIGINT
--CREATE UNIQUE CLUSTERED INDEX IX_VProblemKeyword_Schema
--ON VProblemKeyword(Id);

select * from VProblemKeyword;


--在基表中插入/删除数据，观察VProblemKeyword是否相应的发生变化

--INSERT Problem(Id) VALUES(88);
--INSERT Keyword(Id2) VALUES(88);
--有外键。。。
--select * from VProblemKeyword;

--会///
