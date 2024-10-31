-- SQL Project Data Cleaning



select *
from world_layoffs_data_cleaning.layoffs ;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null values or Blank values
-- 4. Remove any Columns (Irrelevant)

-- Create Table  

CREATE TABLE 
world_layoffs_data_cleaning.LAYOFFS_STAGING LIKE world_layoffs_data_cleaning.layoffs;


select *
from world_layoffs_data_cleaning.layoffs_staging ;

-- Insert the Data

INSERT world_layoffs_data_cleaning.layoffs_staging
SELECT *
FROM world_layoffs_data_cleaning.layoffs ;

-- We did all of This because we want the Raw data Available 

SELECT 
    ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off ,`date`) AS row_num
FROM 
    world_layoffs_data_cleaning.layoffs_staging;


with duplicate_cte as 
(
SELECT * ,
    ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off ,`date`,stage,country) AS row_num
FROM 
    world_layoffs_data_cleaning.layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

-- Better option for subqueries 


select *
from world_layoffs_data_cleaning.layoffs_staging
where company='oda' ;

-- They are very close to be duplicates but they aren't which means we need to be more specific


select *
from world_layoffs_data_cleaning.layoffs_staging
where company='Casper' ;


with duplicate_cte as 
(
SELECT * ,
    ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off ,`date`,stage,country) AS row_num
FROM 
    world_layoffs_data_cleaning.layoffs_staging
)
Delete
from duplicate_cte
where row_num > 1;

-- ------------------------------------------------------------------------------------------------------------------------


CREATE TABLE `world_layoffs_data_cleaning`.`layoffs_staging2`(
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from `world_layoffs_data_cleaning`.`layoffs_staging2`;



insert into `world_layoffs_data_cleaning`.`layoffs_staging2`
SELECT *,
 ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off ,`date`,stage,country) AS row_num
FROM 
    world_layoffs_data_cleaning.layoffs_staging;


SELECT * 
FROM `world_layoffs_data_cleaning`.`layoffs_staging2`
WHERE ROW_NUM > 1 ;

DELETE 
FROM `world_layoffs_data_cleaning`.`layoffs_staging2`
WHERE ROW_NUM > 1;

-- ------------------------------------------------------------------------------------------------------------------------


-- Standardizing Data 

select distinct(trim(company)) 
from `world_layoffs_data_cleaning`.`layoffs_staging2` ;

update `world_layoffs_data_cleaning`.`layoffs_staging2`
set company=trim(company) ;



update`world_layoffs_data_cleaning`.`layoffs_staging2` 
set industry = 'Crypto'
where industry like 'crypto%' ;



select distinct(country) , trim(Trailing '.' from country)
from `world_layoffs_data_cleaning`.`layoffs_staging2`;

update `world_layoffs_data_cleaning`.`layoffs_staging2` 
set country= trim(Trailing '.' from country)
where country like 'United States%' ;



select `date` 
from  `world_layoffs_data_cleaning`.`layoffs_staging2`;

Update  `world_layoffs_data_cleaning`.`layoffs_staging2`
set `date`=str_to_date(`date` , '%m/%d/%Y');

-- Change type of date from text to date

Alter table `world_layoffs_data_cleaning`.`layoffs_staging2`
modify column `date` Date ;


-- ---------------------------------------------------------------------------------------------------------------------------------

-- 3.Null values or Blank values

select *
from `world_layoffs_data_cleaning`.`layoffs_staging2` 
where total_laid_off is Null
and percentage_laid_off is null; 

select *
from `world_layoffs_data_cleaning`.`layoffs_staging2` 
where industry is null 
or industry='';

select *
from `world_layoffs_data_cleaning`.`layoffs_staging2`
where company='Airbnb';

update `world_layoffs_data_cleaning`.`layoffs_staging2`
set industry=null
where industry ='';


select t1.industry ,t2.industry
from `world_layoffs_data_cleaning`.`layoffs_staging2` as t1
join `world_layoffs_data_cleaning`.`layoffs_staging2` as t2
     on t1.company=t2.company
     and t1.location=t2.location
where (t1.industry is null or t1.industry='') 
and t2.industry is  not null ;     

update `world_layoffs_data_cleaning`.`layoffs_staging2` t1
join `world_layoffs_data_cleaning`.`layoffs_staging2` t2
   on t1.company=t2.company
set t1.industry=t2.industry
where (t1.industry is null or t1.industry='') 
and t2.industry is  not null ;     

-- -------------------------------------------------------------------------------------

-- 4. Remove any Columns (Irrelevant)

delete
from `world_layoffs_data_cleaning`.`layoffs_staging2` 
where total_laid_off is Null
and percentage_laid_off is null; 

alter table `world_layoffs_data_cleaning`.`layoffs_staging2`
Drop column row_num;




