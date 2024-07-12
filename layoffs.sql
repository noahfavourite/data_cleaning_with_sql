select *
from noah1.layoffs;

create table noah1.layoffs_1
like noah1.layoffs;

insert noah1.layoffs_1
select *
from  noah1.layoffs;

-- Identifying and removing duplicates --
with temp as 
	(select *,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from  noah1.layoffs_1)
	select *
    from temp 
    where row_num > '1';

use noah1;
create table `layoffs_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into noah1.layoffs_2
select *,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from noah1.layoffs_1;

DELETE 
from noah1.layoffs_2
where row_num > '1';

select *
from noah1.layoffs_2;

-- Data standardization and formatting --
select *
from noah1.layoffs_2;

select company, trim(company)
from noah1.layoffs_2;

update noah1.layoffs_2
set company = trim(company);

select distinct industry
from noah1.layoffs_2
order by 1;

select *
from noah1.layoffs_2
where industry like '%Crypto%';

update layoffs_2
set industry = 'Crypto'
where industry LIKE '%Crypto%';

select distinct country
from layoffs_2
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_2
order by 1;

update layoffs_2
set country =  trim(trailing '.' from country);

select date,
str_to_date(date, '%m/%d/%Y')
from layoffs_2;

update layoffs_2
set date = str_to_date(date, '%m/%d/%Y');

alter table layoffs_2
modify column date date;

-- Handling null and blank values --
select *
from layoffs_2
where industry is null 
or industry = '' ;

update layoffs_2
set industry = null
where industry = '';

select temp1.industry, temp2.industry
from layoffs_2 as temp1 
join layoffs_2 as temp2
on temp1.company = temp2.company
where temp1.industry is not null
and temp2.industry is null;

update layoffs_2 temp1
join layoffs_2 as temp2
on temp1.company = temp2.company
set temp2.industry = temp1.industry
where temp1.industry is not null
and temp2.industry is null;

-- Removing rows and colums not needed --
delete 
from layoffs_2 
where total_laid_off is null
and percentage_laid_off is null;

alter table layoffs_2 
drop column row_num;

select *
from layoffs_2 


