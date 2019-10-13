USE [Email_Marketing_DW]
GO
/****** Object:  StoredProcedure [dbo].[GetDetails]    Script Date: 10/13/2019 1:41:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[GetDetails]
--Dimension columns
@CampaignType VARCHAR(max),
@EmailSourceType VARCHAR(max),
@EmailStatus VARCHAR(max),
@TimeCategory VARCHAR(max),
@EmailType VARCHAR(max),
@City VARCHAR(max),
@State VARCHAR(max),

--Selected Columns Input
@SelectedColumns VARCHAR(max) = '*',
@AggregateColumns VARCHAR(max) = ''


AS
BEGIN

DECLARE @SQLScript VARCHAR(max);


SET @SQLScript = 
'SELECT '+ @SelectedColumns+ ','+ @AggregateColumns+ ' 
FROM   (SELECT fe.factid, 
               ec.campaigntype, 
               eso.emailsourcetype, 
               est.[status], 
               ts.category, 
               et.emailtype, 
               g.city, 
               g.[state], 
               COUNT(fe.factid) AS FactID, 
               AVG(fe.subject_hotness_score) AS Subject_Hotness_Score, 
               SUM(fe.total_images) AS Total_Images, 
               SUM(fe.total_links) AS Total_Links, 
               SUM(fe.total_past_communications) AS Total_Past_Communications, 
               AVG(fe.word_count) AS Total_Word_Count
        FROM   factemail fe 
               LEFT JOIN dimemailcampaign ec 
                      ON fe.campaignid = ec.campaignid 
               LEFT JOIN dimemailsource eso 
                      ON fe.emailsourcetypeid = eso.emailsourcetypeid 
               LEFT JOIN dimemailstatus est 
                      ON fe.statusid = est.statusid 
               LEFT JOIN dimemailtimesentcategory ts 
                      ON fe.categoryid = ts.categoryid 
               LEFT JOIN dimemailtype et 
                      ON fe.emailtypeid = et.emailtypeid 
               LEFT JOIN dimgeography g 
                      ON fe.geographyid = g.geographyid 
        WHERE COALESCE(ec.CampaignType,'''') = COALESCE('''+@CampaignType+''', ec.CampaignType,'''') AND
			  COALESCE(eso.EmailSourceType,'''') = COALESCE('''+@EmailSourceType+''', eso.EmailSourceType,'''')	AND
			  COALESCE(est.[Status],'''') = COALESCE('''+@EmailStatus+''',est.[Status],'''') AND
			  COALESCE(ts.Category,'''') = COALESCE('''+@TimeCategory+''',ts.Category,'''') AND
			  COALESCE(et.EmailType,'''') = COALESCE('''+@EmailType+''',et.EmailType,'''') AND
			  COALESCE(g.City,'''') = COALESCE('''+@City+''',g.City,'''') AND 
              COALESCE(g.[State],'''') = COALESCE('+@State+',g.[State],'''')	 
		GROUP  BY fe.factid, 
                  ec.campaigntype, 
                  eso.emailsourcetype, 
                  est.[status], 
                  ts.category, 
                  et.emailtype, 
                  g.city, 
                  g.[state]) a 
GROUP  BY '+@SelectedColumns+';'

EXEC (@SQLScript)
END