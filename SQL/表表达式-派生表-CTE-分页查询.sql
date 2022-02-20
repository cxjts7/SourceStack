--分别使用派生表和CTE，查询求助表（表中只有一列整体的发布时间，没有年月的列），以获得：

--一起帮每月各发布了求助多少篇
--select * from 
--(select PublishDateTime,
--year(PublishDateTime) as year,
--month(PublishDateTime) as month,
--count(Title) as count
--from Problem
--group by PublishDateTime) spr
--where spr.count > 0;

select PublishDateTime,
year(PublishDateTime) as year,
month(PublishDateTime) as month,
count(Title) as count from Problem
group by PublishDateTime

--每月发布的求助中，悬赏最多的3篇
select * from(
	select *,
		row_number() over(
			partition by year(PublishDateTime),
			month(PublishDateTime)
			order by Reward desc) pdt
		from Problem) npr
where npr.pdt <= 3;


--每个作者，每月发布的，悬赏最多的3篇
select * from(
	select *,
		row_number() over(
			partition by year(PublishDateTime),
			month(PublishDateTime),author
			order by Reward desc) po
		from Problem) pl
where pl.po <= 3;

go 
with pu
as(
	select *,
		row_number() over(
			partition by year(PublishDateTime),
			month(PublishDateTime),author
			order by Reward desc) po
		from Problem)
select * from pu where pu.po <= 3;
	

--分别按发布时间和悬赏数量进行分页查询的结果
select * from(
	select *,
		row_number() over
		(order by Reward) po from Problem)pl
where pl.po between 4 and 6;
--PublishDateTime

with pu
as(
	select *,
		row_number() over
		(order by Reward) po from Problem)
select * from pu where pu.po between 4 and 6;

