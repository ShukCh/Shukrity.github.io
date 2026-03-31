/*
Data Cleaning Steps :
1.Select only the necessary columns
2.Extract the YT channel names
3.Rename the columns
*/
CREATE VIEW 
views_uk_youtubers AS
SELECT
    SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) - 1) AS channel_name,  -- Extract name before '@'
    total_subscribers,
    total_views,
    total_videos
FROM [youtube_db].[dbo].[top_uk_youtubers];

SELECT TOP (1000) [channel_name]
      ,[total_subscribers]
      ,[total_views]
      ,[total_videos]
  FROM [youtube_db].[dbo].[views_uk_youtubers];
