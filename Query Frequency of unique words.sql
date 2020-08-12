/****** looking for frequency of words in a column of varchars  ******/

/**
A string to breakdown word frequency in a column. 
Uses a cte and string_split to break each word out into a unique row so that we can do a simple group by and count :)

This does require compatibility level 130 of SQL server(atleast 2016 i think)
***/



create table #randomwords(
	example varchar(400)
)

insert into #randomwords values 
('ravvle ravvle ravvle'),
('cheese cucumber ravvle'),
('more words'),
('this does not matter'),
('ravvle various words');

  with cte as (
   select example as example FROM #randomwords
  )
  select value as 'Unique_Words', count(1) as 'count' from cte
  cross apply string_split(example, ' ')
    where value != ''
  group by value
  order by count(1) desc

  drop table #randomwords