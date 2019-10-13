/*---------SQL Query to find Top 5 Cities with Highest Emails sent classified by Email Source Type---------------*/
SELECT City, [Email Source Type], COUNT([Total Emails Sent]) AS 'Total Emails Sent'
FROM   (SELECT es.emailsourcetype AS 'Email Source Type', 
               fe.total_past_communications AS 'Total Emails Sent', 
               g.city, 
               Dense_rank() 
                 OVER ( 
                   partition BY g.geographyid 
                   ORDER BY fe.total_past_communications DESC) AS 'Rank' 
        FROM   factemail fe 
               JOIN dimemailsource es 
                 ON fe.emailsourcetypeid = es.emailsourcetypeid 
               JOIN dimgeography g 
                 ON fe.geographyid = g.geographyid) temp 
WHERE  rank < 6
GROUP BY City, [Email Source Type]
ORDER BY [Total Emails Sent] DESC;

/*----- Script to Create a function to find Nth City with highest registered emails------------*/
CREATE FUNCTION getNthUniqueEmails(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        SELECT TOP 1 City
        FROM
        (
            SELECT COUNT(fe.GeographyID) AS 'Unique Emails', dg.City, DENSE_RANK() OVER (ORDER BY COUNT(fe.GeographyID) DESC) AS 'Rank'
            FROM FactEmail fe
			JOIN DimGeography dg ON fe.GeographyID = dg.GeographyID
			GROUP BY fe.GeographyID, dg.City

        ) temp
        WHERE temp.Rank IN (@N)
    );
END

/*-------- SQL Query to find Customer Email IDs with unknown locations---------*/
SELECT Email_ID AS 'Customer Email'
FROM FactEmail
LEFT JOIN DimGeography ON FactEmail.GeographyID = DimGeography.GeographyID
WHERE FactEmail.GeographyID IS NULL;