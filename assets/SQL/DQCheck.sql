/* 
Data Quality checks:
1.Total distinct records should be 100 in this case
2.Should have 4 columns(column count test)
3.[total_subscribers],[total_views],[total_videos] must be numerical; [channel_name] should be string
4.Check for duplicate channel_name

Hence Data Types:
[channel_name]=Varchar
[total_subscribers]=Integer
[total_views]=Integer
[total_videos]=Integer
*/
--1
SELECT 
    'Total Records'    AS record_type, COUNT(*) AS Total_records 
FROM [youtube_db].[dbo].[views_uk_youtubers]
UNION ALL
SELECT 
    'Distinct Records' AS record_type, COUNT(*) AS Total_records 
FROM (
    SELECT DISTINCT * 
    FROM [youtube_db].[dbo].[views_uk_youtubers]
) AS distinct_records;
--2
SELECT
    COUNT(*) AS column_count
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'views_uk_youtubers'
    AND TABLE_SCHEMA = 'dbo';  
--3
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'views_uk_youtubers'
    AND TABLE_SCHEMA = 'dbo'; 
--4
SELECT 
    channel_name,
    COUNT(channel_name) AS duplicate_count
FROM [youtube_db].[dbo].[views_uk_youtubers]
GROUP BY channel_name
HAVING COUNT(channel_name) > 1;