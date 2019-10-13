# Email_Marketing_Datawarehouse
This repository showcases my work for developing a Datawarehouse for Email Marketing.

Learnings:
1. Complex SQL Queries
2. SSIS Packages
3. Reusable SQL Queries

Inspiration:
I recently interviewed with a famous E-commerce company for Analyst position in Email marketing domain. This piqued my interest for email marketing and the technicalities that go behind it.

Procedure:
1. I retrieved the dataset from Kaggle.com which was split in train & test sets. Link: https://www.kaggle.com/loveall/email-campaign-management-for-sme
2. The data dictionary was not available for this dataset so I have attached a data dictionary created by me with all the assumpations made based on the data.
3. Developed a physical and logical data model in Toad Data Modeler documenting 6 Dimensions and 1 Fact table.
4. Performed forward engineering to generate DDL script for the datawarehouse
5. Created SSIS packages to load data from CSV to SQL Server DW. Performed data manipulation like adjusting datatypes, creating conditional columns etc.
6. Wrote SQL Scripts from basic to advanced functions like JOINS, Subqueries for Data retrival
7. Created a function to get City based on number of registered users
8. Created a reusable master stored procedure to retrieve aggregated data reducing scripting of queries again and again.

Further Scope:
1. Error Handling in Stored Procedures. Implementing ErrInfo and error catching to make procedure more business user friendly.
2. Implementing factors like Open Rate, Click Through Rate etc. (This wasn't done because of limited data available.)
3. Performance Improvements: Developing specialized stored procedures for each features as they increase and linking them to the master stored procedure.
4. Implementing Full Text Search Indexing: This will help us better identify achor keywords and improve datawarehousing processing ability considerably.

Demo Files:
1. Data Dictionary - Contains data definitions, assumptions
2. Datawarehouse Generaion SQL File
3. Function SQL File
4. Stored Procedure SQL File
5. Sample Stored Procedure Execution Scripts
6. Sample basic to advanced SQL queries
7. Snapshots of SP execution with results
