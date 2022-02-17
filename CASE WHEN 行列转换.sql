select * from Tscore;

select 
name,
MAX(case [Subject] when N'C#' then score else 0 end) as N'C#',
MAX(case [Subject] when N'SQL' then score else 0 end) as N'SQL',
MAX(case [Subject] when N'JavaScript' then score else 0 end) as N'JavaScript'
from TSCORE
group by Name;