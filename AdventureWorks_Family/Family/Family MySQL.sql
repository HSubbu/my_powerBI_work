drop database if exists family;
create database family;
use family;

# pivot
create table long6 (famid int, year int, faminc int);
insert into long6 (famid, year, faminc) values
    (1, 96, 40000),
    (1, 97, 40500),
    (1, 98, 41000),
    (2, 96, 45000),
    (2, 97, 45400),
    (2, 98, 45800),
    (3, 96, 75000),
    (3, 97, 76000),
    (3, 98, 77000);

select   famid,
	     max(case when year=96 then faminc else null end) faminc96,
         max(case when year=97 then faminc else null end) faminc97,
         max(case when year=98 then faminc else null end) faminc98
from   	 long6
group by famid;

# unpivot
create table wide1 (famid int, faminc96 int, faminc97 int, faminc98 int);
insert into wide1 (famid, faminc96, faminc97, faminc98) values
	(1, 40000, 40500, 41000),
	(2, 45000, 45400, 45800),
	(3, 75000, 76000, 77000);

select * from (
select	famid, '96', faminc96
from	wide1
union all
select	famid, '97', faminc97
from	wide1
union all
select	famid, '98', faminc98
from	wide1) x (famid, year, faminc);

select	t.famid, x.*
from	wide1 t
cross join lateral (
	select '96', faminc96
    union all
    select '97', faminc97
    union all
    select '98', faminc98
) x (year, faminc);