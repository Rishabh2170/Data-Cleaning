# 🧹 Data Cleaning in SQL | World Layoffs Dataset

A data cleaning project using MySQL to transform a raw, messy world layoffs dataset into clean, structured data ready for analysis.

---

## 📌 Project Overview

Raw data is rarely ready for analysis. In this project, I took a real-world dataset of global company layoffs and systematically cleaned it using SQL in MySQL Workbench — handling duplicates, null values, inconsistent formatting, and incorrect data types to produce a reliable, analysis-ready table.

---

## 📁 Repository Structure

```
Data-Cleaning/
│
└── Data Cleaning/
    ├── layoffs.csv                        # Raw dataset (original, uncleaned)
    └── Data Cleaning Project.sql          # SQL script with all cleaning steps
```

---

## 📊 Dataset

**World Layoffs Dataset** — contains records of mass layoffs across global tech and non-tech companies including company name, industry, country, total laid off, percentage laid off, date, funding stage, and funds raised.

---

## 🛠️ Data Cleaning Steps Performed

**1. Create a Staging Table**
- Created a copy of the raw table (`layoffs_staging`) to preserve the original data and work safely on a duplicate

**2. Remove Duplicates**
- Used `ROW_NUMBER()` with `PARTITION BY` window function to identify duplicate rows
- Created a second staging table (`layoffs_staging2`) with a `row_num` column
- Deleted all rows where `row_num > 1`

**3. Standardize the Data**
- Used `TRIM()` to remove leading/trailing whitespace from text columns like `company`
- Standardized the `industry` column — fixed variations like `Crypto`, `Crypto Currency`, `CryptoCurrency` → all unified to `Crypto`
- Cleaned up the `country` column — removed trailing periods (e.g. `United States.` → `United States`)
- Converted the `date` column from `TEXT` format to proper `DATE` format using `STR_TO_DATE()` and `ALTER TABLE`

**4. Handle NULL & Blank Values**
- Converted blank strings in the `industry` column to `NULL`
- Used a self `JOIN` on the same table to populate `NULL` industry values using matching company records that had the data
- Deleted rows where both `total_laid_off` and `percentage_laid_off` were `NULL` as they provided no analytical value

**5. Remove Unnecessary Columns**
- Dropped the `row_num` helper column after it had served its purpose using `ALTER TABLE ... DROP COLUMN`

---

## 🧰 Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL | Database management and query execution |
| MySQL Workbench | SQL development environment |
| SQL | Core language for all cleaning operations |

---

## 💡 Key SQL Concepts Used

- `ROW_NUMBER()` with `PARTITION BY` — for duplicate detection
- CTEs (`WITH` clause) — for temporary result sets
- `STR_TO_DATE()` — for date format conversion
- `ALTER TABLE` — for modifying column data types and dropping columns
- Self `JOIN` — for populating NULL values from matching rows
- `TRIM()`, `LIKE`, `UPDATE`, `DELETE` — for standardization and cleaning

---

## 🚀 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/Rishabh2170/Data-Cleaning.git
   ```

2. **Open MySQL Workbench** and create a new schema/database

3. **Import the raw dataset**
   - Import `layoffs.csv` into a table called `layoffs`

4. **Run the SQL script**
   - Open `Data Cleaning Project.sql` and execute it step by step

---

## 💡 Key Takeaways

- Never work directly on raw data — always create a staging table first
- Window functions like `ROW_NUMBER()` are powerful for finding duplicates without a unique ID
- Standardizing text and date formats early prevents issues during analysis
- Self joins are an effective way to fill in missing values using existing data in the same table

---

## 👤 Author

**Rishabh**  
GitHub: [@Rishabh2170](https://github.com/Rishabh2170)
