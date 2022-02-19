--观察并模拟17bang项目中的：
--用户资料，新建用户资料（Profile）表，和User形成1:1关联（有无约束？）。用SQL语句演示：

--通过Id查找获得某注册用户及其用户资料
--删除某个Id的注册用户
select * from [User];
--update [User] set Id = (NEWID()) where UserName = '17bang';
--update [User] set Id = (NEWID()) where UserName = 'Admin';
--update [User] set Id = (NEWID()) where UserName = 'Admin-1';
--update [User] set Id = (NEWID()) where UserName = 'SuperAdmin';


drop table Profile;
create table Profile(
	Id varchar(50) not null,
	Avatar varchar(50) null,
	Sex   nvarchar(8)  null,
	Birthday date  null,
	[Keyword] nvarchar(12) null,
	SelfIntroduction ntext null
) 
alter table [User] alter column Id varchar(50) not  null;
alter table [User] add constraint PK_User_Id Primary Key(Id);

select * from [User];
select * from Profile order by Id;

insert Profile(Id) select Id from [User] order by Id;

alter table [Profile]
add constraint FK_Profile_User_Id Foreign Key(Id) references
[User](Id);
ON DELETE CASCADE ON UPDATE SET NULL;


--新建一个填写了用户资料的注册用户
UPDATE Profile SET Sex = N'男', Avatar = 78, Birthday = '2000/1/1',
Keyword = N'冲', SelfIntroduction = N'懒惰+懦弱'
where Id = '1';








--帮帮点说明：新建Credit表，可以记录用户的每一次积分获得过程，即：某个用户，在某个时间，因为某某原因，获得若干积分
--发布求助，在Problem和User之间建立1:n关联（含约束）。用SQL语句演示：
--某用户发布一篇求助，
--将该求助的作者改成另外一个用户
--删除该用户
--求助列表：新建Keyword表，和Problem形成n:n关联（含约束）。用SQL语句演示：
--查询获得：每个求助使用了多少关键字，每个关键字被多少求助使用
--发布了一个使用了若干个关键字的求助
--该求助不再使用某个关键字
--删除该求助
--删除某关键字