--作业：

--为求助添加一个发布时间（TPublishTime）
alter table Problem add TPublishTime date null;
select * from Problem;

--使用子查询：删除每个作者悬赏最低的求助
select * from Problem ot where Reward = (select Min(Reward) from Problem it 
where ot.Author = it.Author);

begin tran

alter table KeywordToProblem drop constraint FK_KeywordToProblem_Id; 

delete op 
--select * 
from Problem op where Reward = (select Min(Reward) 
from Problem ip 
where op.Author = ip.Author);

delete Problem  where Reward in(
select Reward from Problem op where Reward =( 
select Min(Reward) from Problem ip 
where op.Author = ip.Author));

rollback
--begin tran 没执行就删了。。。
alter table Problem
add constraint FK_Problem_Id Foreign Key(Id) 
references [User](Id)
on delete cascade on update set null;

alter table KeywordToProblem
add constraint FK_KeywordToProblem_Id Foreign Key(Id)
References Problem(Id);

--找到从未成为邀请人的用户
select * from [User];
select * from [User] where UserName not in
(select InviteBy from [User]);

--如果一篇求助的关键字大于3个，将它的悬赏值翻倍
--如果一篇求助的Id和关键字的ID2的一致，将它的悬赏值翻倍
select * from Problem;

begin tran

update Problem set Reward = Reward * 2 
where Id in (select Id2 from Keyword) --where Id2 = 2)

rollback

--查出所有发布一篇以上（不含一篇）文章的用户信息
alter table Article add Id3 int null;

select * from Article where Id3 in
(select Id3 from Article group by Id3
having count(Title) > 1);

--查找每个作者最近发布的一篇文章

select * from Problem op  where TPublishTime in 
(select max(TPublishTime) from Problem ip
where ip.Author = op.Author);



--查出每一篇求助的悬赏都大于25个帮帮币的作者

select DISTINCT Author from Problem opr where Author in (
select Author from Problem ipr group by Author
having MIN(Reward) > 25);


select * from Problem 




