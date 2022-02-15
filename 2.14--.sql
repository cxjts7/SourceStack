
select * from TSCORE;
--比较没有HAVING过滤，和有HAVING和的区别。
SELECT Name, AVG(Score) FROM TSCORE 
GROUP BY Name 
HAVING AVG(Score) > 87 

--在Problem中插入不同作者（Author）不同悬赏（Reward）的若干条数据，

select * from Problem;
alter table Problem add Author nvarchar(50);

alter table Problem
add constraint DF_Problem_PublishDateTime
default '2021/1/1' for PublishDateTime;

alter table Problem nocheck constraint CK_Reward;
insert Problem(Id, Author, Reward) values(11, N'赵一', 1); 
insert Problem(Id, Author, Reward) values(12, N'钱二', 15); 
insert Problem(Id, Author, Reward) values(13, N'孙三', 25); 
insert Problem(Id, Author, Reward) values(14, N'李四', 35); 
insert Problem(Id, Author, Reward) values(15, N'周五', 3); 
insert Problem(Id, Author, Reward) values(16, N'吴五', 55); 
insert Problem(Id, Author, Reward) values(17, N'飞哥', 2); 
insert Problem(Id, Author, Reward) values(18, N'飞哥', 55); 
insert Problem(Id, Author, Reward) values(19, N'飞哥', 26); 
insert Problem(Id, Author, Reward) values(20, N'飞哥', 78); 
insert Problem(Id, Author, Reward) values(21, N'飞哥', 165); 
insert Problem(Id, Author, Reward) values(22, N'飞哥', 99); 
insert Problem(Id, Author, Reward) values(23, N'飞哥', 100); 
insert Problem(Id, Author, Reward) values(24, N'赵一', null); 
alter table Problem check constraint CK_Reward;

select Reward, * from Problem;
--查找出Author为“飞哥”的、Reward最多的3条求助
select top 3 Reward from Problem where Author = N'飞哥'
order by Reward DESC ; 

select top 3 Reward from Problem
order by Reward DESC ; 

--为啥超过100的Reward排不进去了？(varchar换成int类型就好了)
--针对varchar有解决办法，排序时转换一下类型

--所有求助，先按作者“分组”，然后在“分组”中按悬赏从大到小排序
select Author, Reward from Problem order by Author, Reward desc;


--查找并统计出每个作者的：求助数量、悬赏总金额和平均值
--Operand data type varchar is invalid for avg operator.

--alter table Problem drop constraint CK_Reward;
--ALTER TABLE [dbo].[Problem]
--ADD CONSTRAINT [CK_Reward] CHECK ([Reward] > (0));

alter table Problem alter column Reward int;
select Author, count(Reward) as count, sum(Reward) as sum,
AVG(Reward) as avg from Problem group by Author;

--找出平均悬赏值少于10的作者并按平均值从小到大排序
select Author, avg(Reward) as avg from Problem
group by Author having avg(Reward) < 10 order by avg(Reward);

--以Problem中的数据为基础，使用SELECT INTO，
--新建一个Author和Reward都没有NULL值的新表：
--NewProblem （把原Problem里Author或Reward为NULL值的数据删掉
--直接过滤了
select * from Problem;

--null的特殊性
select Author, Reward into NewProblem
from Problem where Author is not null and Reward is not null;

select * from NewProblem;

--使用使用insert select, 
--将problem中reward为null的行再次插入到newproblem中

insert NewProblem
select Author, Reward from Problem where Reward is null;
--必须列名一致，自增的除外（被插入的表后添加列名）
