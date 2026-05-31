select *
from layoffs;

-- 1. create a sub table of raw table
-- 2. remove dublicates
-- 3. standardize the data
-- 4. handel null or blank values 
-- 5. remove any column or row

-- creating a sub table of our dataset(layoffs)

create table layoffs_copy
like layoffs;

insert layoffs_copy
select *
from layoffs;

select *
from layoffs_copy;

-- Step-1 : Remove Dublicates

select *,
	row_number() over (partition by company , location , industry , total_laid_off , 
    percentage_laid_off , `date` , stage , country , funds_raised_millions)
from layoffs_copy;


with dublicate_cte as 
(
select *,
	row_number() over (partition by company , location , industry , total_laid_off , 
    percentage_laid_off , `date` , stage , country , funds_raised_millions) as row_num
from layoffs_copy
)
select *
from dublicate_cte
where row_num >1;





CREATE TABLE `layoffs_copy2` (
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

select *
from layoffs_copy2
where row_num >1;

insert into layoffs_copy2
select *,
	row_number() over (partition by company , location , industry , total_laid_off , 
    percentage_laid_off , `date` , stage , country , funds_raised_millions)
from layoffs_copy;

delete
from layoffs_copy2
where row_num >1;

select *
from layoffs_copy2
where company = 'casper';


-- step2:  standardizing data

select distinct(company) 
from layoffs_copy2;

update layoffs_copy2 
set company = trim(company);


select *
from layoffs_copy2;


select *
from layoffs_copy2
where industry like 'crypto%';

update layoffs_copy2
set industry = 'crypto'
where industry like 'crypto%';


select distinct(country) , trim(trailing '.' from country)
from layoffs_copy2
where country like 'United States%';

update layoffs_copy2
set country = trim(trailing '.' from country)
where country like 'United States%';


select `date` 
from layoffs_copy2;

update layoffs_copy2
set `date` = str_to_date(`date` , '%m/%d/%Y');


alter table layoffs_copy2
modify column `date` date;



-- step 3 : handeling null and blank values

select *
from layoffs_copy2
where total_laid_off is null
and percentage_laid_off is null
and funds_raised_millions is null;


select *
from layoffs_copy2
where industry is null 
or industry = '';

-- populating the blank and null values which are populatable
 
-- perform self join to populate the row with dublicate values, so can be populated using those values
select *
from layoffs_copy2
where company = 'Airbnb';

update layoffs_copy2
set industry = null
where industry = '';

select t1.industry , t2.industry
from layoffs_copy2 t1
join layoffs_copy2 t2
on t1.company = t2.company
	and t1.location = t2.location
where t1.industry is null
and t2.industry is not null;

update layoffs_copy2 t1
join layoffs_copy2 t2
on t1.company = t2.company
	and t1.location = t2.location
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

-- removing unwanted or null rows that are of no use
select *
from layoffs_copy2
where total_laid_off is null
and percentage_laid_off is null;

delete 
from layoffs_copy2
where total_laid_off is null
and percentage_laid_off is null;

select * 
from layoffs_copy2;

-- droping unwanted column or row

alter table layoffs_copy2
drop column row_num;













