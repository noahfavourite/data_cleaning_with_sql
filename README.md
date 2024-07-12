# data_cleaning_with_sql

Data cleaning is important before any exploratory analysis is carried out on a dataset. This is to ensure that the data is accaurate, complete and consistent.
It is also important to ensure that the data is more usable and accessible for analysis and data-driven decisions. 
The goal of this project is to clean the world layoff dataset to ensure consistency and ensure that poor alogrithm is not built when exploratory data analysis is been carried out on it.

### TASKS
- Identifying and removing duplicates
- Data standardization and formatting
- Handle null and blank values
- Remove any column or rows not needed

### PROCESS
1. Created staged table 1 and copy data from raw data into staged table 1
2. Created row number for each row, partitioning it by each column
3. Created staged table two to enable efficient dropping of duplicate column from staged table 1. This table will contain row number as a column
4. Identified and deleted duplicate rows
5. Standerdizing data
   - Trim
   - Words and spelling accuracy
   - Formatting data types
6. Handling nulls
   - Replaced blank spaces with nulls
   - Populated data where needed
7. Removed rows and columns not needed.
