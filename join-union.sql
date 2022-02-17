--联表查出求助的标题和作者用户名
select Title, [UserName] FROM Problem p full join [User] u
on p.Id = u.Id;

--查找并删除从未发布过求助的用户
begin tran
delete [User]
FROM Problem p right join [User] u on p.Id = u.Id
where p.Title is null;
rollback

--用一句SELECT显示出用户和他的邀请人用户名
alter table [User] add InviteBy nvarchar(20) null;

--select u1.UserName, u2.UserName, u1.InviteBy, u2.InviteBy
--FROM [User] u1 join [User] u2
--on u1.UserName = u2.UserName;

--InviteBy相同会全排列，但UserName有不同，全排列就会出现不相等
select u1.UserName, u2.UserName, u1.InviteBy, u2.InviteBy
FROM [User] u1 join [User] u2
on u1.InviteBy = u2.InviteBy
where u1.UserName <> u2.UserName;




--17bang的关键字有“一级”“二级”和其他“普通（三）级”的区别：
--请在表Keyword中添加一个字段，记录这种关系
alter table Keyword add relation int;

--然后用一个SELECT语句查出所有普通关键字的上一级、
--以及上上一级的关键字名称，比如：
 
select K3.[Name] 关键字, K2.[Name] 上一级, K1.[Name] 上上一级
from Keyword K1 right join Keyword K2
on K1.Id2 = K2.relation
right join Keyword K3 on K2.Id2 = K3.relation;



select K1.[Name] 关键字, K2.[Name] 上一级, K3.[Name] 上上一级
from Keyword K1 left join Keyword K2
on K1.Id2 = K2.relation
left join Keyword K3 on K2.Id2 = K3.relation;


--17bang中除了求助（Problem3），还有意见建议（Suggest）和文章
--（Article），他们都包含Title、Content、PublishTime
--和Author四个字段，但是：

--建议和文章没有悬赏（Reward）
--建议多一个类型：Kind NVARCHAR(20)）
--文章多一个分类：Category INT）

--请按上述描述建表。

create table Problem3(
	Title nvarchar(50) null,
	Content ntext null,
	PublishTime date null,
	Author nvarchar(20),
	Reward int null
);
alter table Problem3 add Id int null;

create table Suggest(
	Title nvarchar(50) null,
	Content ntext null,
	PublishTime date null,
	Author nvarchar(20),
	Kind NVARCHAR(20)
);

create table Article(
	Title nvarchar(50) null,
	Content ntext null,
	PublishTime date null,
	Author nvarchar(20),
	Category INT
);

--然后，用一个SQL语句显示某用户发表的求助、
--建议和文章的Title、Content，并按PublishTime降序排列

select PublishTime, Author, Title, Reward, N'类型' from Problem3
where Id = 3 union
select PublishTime, Author, Title, 0, Kind from Suggest
union
select PublishTime, Author, Title, 0, N'类型' from Article
order by PublishTime desc;

 