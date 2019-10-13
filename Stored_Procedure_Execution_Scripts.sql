/*Execution of stored procedure 
looking for Sum of past communications 
and Average of Subject Hotness Score 
in State of California*/

USE [Email_Marketing_DW]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GetDetails]
		@CampaignType   = NULL,
		@EmailSourceType   = NULL,
		@EmailStatus   = NULL,
		@TimeCategory   = NULL,
		@EmailType   = NULL,
		@City   = NULL,
		@State   = 'CA',
		@SelectedColumns   = '[state]',
		@AggregateColumns   = 'SUM(Total_Past_Communications) AS Total_Past_Communications, AVG(Subject_Hotness_Score) AS Subject_Hotness_Score'

SELECT	'Return Value' = @return_value

GO
--==================================================================================================================================================================================

/*Execution of stored procedure 
looking for Avg of word count in email 
and Number of emails opened 
in during morning commute*/
USE [Email_Marketing_DW]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GetDetails]
		@CampaignType   = NULL,
		@EmailSourceType   = NULL,
		@EmailStatus   = NULL,
		@TimeCategory   = 'Morning Commute',
		@EmailType   = NULL,
		@City   = NULL,
		@State   = NULL,
		@SelectedColumns   = 'category',
		@AggregateColumns   =  'AVG(Total_Word_count) AS Total_Word_Count, COUNT(Fact_ID) AS Emails_Opened'

SELECT	'Return Value' = @return_value

GO
--==================================================================================================================================================================================
/*Execution of stored procedure 
looking for Avg of word count in email 
and Number of emails opened
and Sum of total links in all emails 
in during "Tax Return" Campaign Type and "Youtube as Email Source Type" */
USE [Email_Marketing_DW]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GetDetails]
		@CampaignType   = 'Tax Return',
		@EmailSourceType   = 'Youtube',
		@EmailStatus   = NULL,
		@TimeCategory   = NULL,
		@EmailType   = NULL,
		@City   = NULL,
		@State   = NULL,
		@SelectedColumns   = 'CampaignType, EmailSourceType',
		@AggregateColumns   =  'AVG(Total_Word_count) AS Total_Word_Count, COUNT(Fact_ID) AS Emails_Opened, SUM(total_links) AS Total_Links'

SELECT	'Return Value' = @return_value

GO
