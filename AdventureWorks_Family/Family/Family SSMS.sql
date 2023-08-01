-- Pivot 
drop database if exists family;
create database family;
use family;

-- pivot
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

select *
from (select famid, year, faminc from long6) src
pivot (sum(faminc) for year in ([96], [97], [98])) pvt;

-- unpivot
create table wide1 (famid int, faminc96 int, faminc97 int, faminc98 int);
insert into wide1 (famid, faminc96, faminc97, faminc98) values
	(1, 40000, 40500, 41000),
	(2, 45000, 45400, 45800),
	(3, 75000, 76000, 77000);

select faminc, year, faminc
from (select famid, faminc96, faminc97, faminc98 from wide1) src
unpivot (faminc for year in (faminc96, faminc97, faminc98)) unpvt;