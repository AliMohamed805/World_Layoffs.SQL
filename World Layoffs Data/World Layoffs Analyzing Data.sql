-- Exploratory Data analysis

select *
from `world_layoffs_data_cleaning`.`layoffs_staging2`;

select max(total_laid_off) , max(percentage_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`;

-- the maximum number of people laid_off at once is 12000

select *
from `world_layoffs_data_cleaning`.`layoffs_staging2`
where percentage_laid_off = 1
order by total_laid_off desc;


select *
from `world_layoffs_data_cleaning`.`layoffs_staging2`
where percentage_laid_off = 1
order by funds_raised_millions desc;


select company , sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by company 
order by 2 desc;


select min(`date`), max(`date`)
from `world_layoffs_data_cleaning`.`layoffs_staging2` ;

-- These date was collected through 3 years


select industry , sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by industry 
order by 2 desc;

-- the most industy that people got laid_off from is consumption(Consumer Column)

select country , sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by country 
order by 2 desc;

-- United states got the largest number of laid_off 


select year(`date`) , sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by year(`date`) 
order by 2 desc;

-- 2022 got the biggest number of layoffs


select stage , sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by stage
order by 2 desc;


select company ,avg(percentage_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by company 
order by 2 desc;


select substring(`date`,1,7) as `MONTH`, sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
where substring(`date`,1,7) is not null
group by `MONTH`
order by 2; 



With Rolling_Total as 
(
select substring(`date`,1,7) as `MONTH`, sum(total_laid_off) as SOLO
from `world_layoffs_data_cleaning`.`layoffs_staging2`
where substring(`date`,1,7) is not null
group by `MONTH`
order by 2
)
select `MONTH`,SUM(SOLO) over(order by `Month`) as rolling_total,solo
FROM ROLLING_TOTAL ;


select company ,year(`date`) ,sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by company ,year(`date`)
order by 3 desc;




with Company_year(company,years,total_off) as
(

select company ,year(`date`) ,sum(total_laid_off)
from `world_layoffs_data_cleaning`.`layoffs_staging2`
group by company ,year(`date`)
order by 3 desc

),company_year_rank as
(
select *, dense_rank() over(partition by years order by total_off desc) as 	`rank`
from Company_year
where years is not null
)
select *
from company_year_rank
where `rank` <=5;


