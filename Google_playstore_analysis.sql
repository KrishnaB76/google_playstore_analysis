-- Identifying null values in the table
select *
from dbo.googleplaystore
where App is null
or Category is null
or Rating is null
or Reviews is null
or Size is null
or Installs is null
or Type is null
or Price is null
or Content_Rating is null
or Genres is null
or Last_Updated is null
or Current_Ver is null
or Android_Ver is null
-- Deleting the null values in the table
Delete 
from dbo.googleplaystore
where App is null
or Category is null
or Rating is null
or Reviews is null
or Size is null
or Installs is null
or Type is null
or Price is null
or Content_Rating is null
or Genres is null
or Last_Updated is null
or Current_Ver is null
or Android_Ver is null

--overview of data
select count(distinct App) as Total_apps, count(distinct Category) as Total_category
from dbo.googleplaystore

-- Exploring apps Category
select Category,count(distinct App) as total_apps
from dbo.googleplaystore
group by Category
order by total_apps DEsc

-- identifying top rated apps
select top 10
App,Category,Rating,Reviews
from dbo.googleplaystore
where Type = 'Free' and Rating <> 'Nan'
order by Rating desc 

-- Finding Apps with highest number of reviews 
select top 10
App,Category,Rating,Reviews
from dbo.googleplaystore
order by Reviews Desc

--Finding average rating by category
select Category,avg(try_cast(Rating as float)) as average_rating
from dbo.googleplaystore
group by Category
order by average_rating

--Top Categories by Number of Installs:
select Category,
sum(try_cast(replace(substring(Installs,1, Patindex('%[^0-9]%', Installs +' ')-1),',',' ') as int)) total_installs
from dbo.googleplaystore
group by Category
order by total_installs desc

--Average Sentiment Polarity by App Category:
select 
Category,
avg(try_cast(Sentiment_Polarity as float)) as avg_sentiment_polarity
from dbo.googleplaystore as g1
JOIN dbo.googleplaystore_user_reviews as g2
on g1.App = g2.App
group by Category
order by avg_sentiment_polarity DEsc

--Sentiment reviews by App Categoryselect 
Category,Sentiment,count(*) as total_sentiment
from dbo.googleplaystore as g1
JOIN dbo.googleplaystore_user_reviews as g2
on g1.App = g2.App
where Sentiment <> 'nan'
group by Category, Sentiment
order by total_sentiment DESC