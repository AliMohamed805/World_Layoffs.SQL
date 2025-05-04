# 🌍 World Layoffs Data Analysis Project  
*Uncovering global workforce trends through data-driven insights*  

## 📌 Project Overview  
This end-to-end data analysis project transforms raw layoffs data into actionable insights about global workforce reductions. By cleaning and analyzing patterns across industries, countries, and time periods, we reveal:  
- Which sectors were most impacted  
- Geographic distribution of layoffs  
- Temporal trends (2020-2023)  
- Relationship between funding and workforce reductions  

## 🗃️ Dataset  
**File:** `layoffs.csv`  

| Column | Type | Description |
|--------|------|-------------|
| company | text | Company name |
| location | text | City/region |
| industry | text | Sector classification |
| total_laid_off | int | Employees affected |
| percentage_laid_off | decimal | Workforce % affected |
| date | text | Layoff date |
| stage | text | Funding round |
| country | text | Country name |
| funds_raised_millions | int | Total funding |

## 🔧 Technical Implementation  
### 🧹 Data Cleaning  
**Script:** `World_Layoffs_Data_Cleaning.sql`  
- Deduplication  
- Standardization  
- Null handling  

### 🔍 Data Analysis  
**Script:** `World_Layoffs_Analyzing_Data.sql`  
Key analyses:  
- Temporal trends  
- Sector analysis  
- Geographic patterns  

## 🚀 Key Findings  
- **Peak Single Layoff:** 12,000 employees  
- **Worst Affected Sector:** Consumer (28% of total)  
- **Top Country:** United States  
- **Critical Year:** 2022 (58% increase from 2021)  
