/*
1.Define the variables
2.Create CTE that rounds the average views per video
3.Select the columns that are required for the analysis
4.Filter the results by the YouTube channels with the highest subscriber bases
5.Order by net_profit(from highest to lowest)
*/
--1
Declare @conversionRate Float = 0.02;	--The conversion rate at 2%
Declare @productCost Money = 5.0	;	--The product cost at $5
Declare @campaignCost Float = 50000.0;	--The campaign cost at $50000

--2
with ChannelData as(
	Select
		channel_name,
		total_subscribers,
		total_views,
		total_videos,
		round((cast(total_views as float)/nullif(total_videos,0)),-4) as rounded_avg_views_per_video
	from [youtube_db].[dbo].[views_uk_youtubers]
)
select top 3 
channel_name,
rounded_avg_views_per_video,
(rounded_avg_views_per_video* @conversionRate) as Potential_Product_Sales_Per_Video,
(rounded_avg_views_per_video* @conversionRate * @productCost) as Potential_Revenue_per_Video,
(rounded_avg_views_per_video* @conversionRate * @productCost)-@campaignCost as Net_Profit
from ChannelData 
order by total_subscribers desc, Net_Profit desc
