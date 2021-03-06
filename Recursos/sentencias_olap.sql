--Rollup
SELECT
    CASE 
        WHEN CALENDARYEAR IS NULL THEN 'TOTAL'
        ELSE CAST(CALENDARYEAR AS VARCHAR)
    END AS CALENDARYEAR,
    CASE
        WHEN CALENDARYEAR IS NULL THEN 'TOTAL'
        WHEN MONTHNUMBEROFYEAR IS NULL THEN 'TOTAL ANUAL'
        ELSE CAST(MONTHNUMBEROFYEAR AS VARCHAR)
    END AS MONTHNUMBEROFYEAR,
    
    SUM(SALESAMOUNT) AS TOTAL_SALES_AMOUNT
FROM FACTINTERNETSALES F JOIN DIMDATE D 
ON F.ORDERDATEKEY = D.DATEKEY
WHERE D.CALENDARYEAR IN (2006,2007)
GROUP BY ROLLUP(D.CALENDARYEAR,D.MONTHNUMBEROFYEAR)
ORDER BY D.CALENDARYEAR,D.MONTHNUMBEROFYEAR


--DillDown
SELECT
    CASE 
        WHEN CALENDARYEAR IS NULL THEN 'TOTAL'
        ELSE CAST(CALENDARYEAR AS VARCHAR)
    END AS CALENDARYEAR,
    CASE
        WHEN CALENDARYEAR IS NULL THEN 'TOTAL'
        WHEN MONTHNUMBEROFYEAR IS NULL THEN 'TOTAL ANUAL'
        ELSE CAST(MONTHNUMBEROFYEAR AS VARCHAR)
    END AS MONTHNUMBEROFYEAR,
    SUM(TAXAMT) AS TOTAL_TAX_AMOUNT
FROM FACTINTERNETSALES F JOIN DIMDATE D 
ON F.ORDERDATEKEY = D.DATEKEY
WHERE CALENDARYEAR IN(2006, 2007) 
GROUP BY ROLLUP(D.CALENDARYEAR, D.MONTHNUMBEROFYEAR)
ORDER BY D.CALENDARYEAR DESC, D.MONTHNUMBEROFYEAR DESC


--Dice
SELECT
    D.ENGLISHDAYNAMEOFWEEK,
    SUM(F.SALESAMOUNT) AS TOTAL_SALES_AMOUNT
FROM 
    FACTINTERNETSALES F
    JOIN DIMDATE D ON F.ORDERDATEKEY=D.DATEKEY
    JOIN DIMSALESTERRITORY T ON F.SALESTERRITORYKEY=T.SALESTERRITORYKEY
WHERE
    T.SALESTERRITORYCOUNTRY='United States' AND
    D.CALENDARYEAR=2006
GROUP BY
    T.SALESTERRITORYCOUNTRY,
    D.DAYNUMBEROFWEEK,
    D.ENGLISHDAYNAMEOFWEEK
ORDER BY D.DAYNUMBEROFWEEK