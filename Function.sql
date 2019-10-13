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