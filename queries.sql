SELECT * FROM social_media;

-- Apps with their total numbers
SELECT App, COUNT(User_ID) AS total_numbers
FROM social_media
GROUP BY App
ORDER BY 2 DESC;

/*App Engagement Analysis
Total Engagement per App: Calculate the total number of likes, follows, and posts per app to measure engagement*/

SELECT App,
SUM(Posts_Per_Day) AS total_posts_perday,
SUM(Likes_Per_Day) AS total_likes_perday,
SUM(Follows_Per_Day) AS total_follows_perday
FROM social_media
GROUP BY App;

-- Average Engagement per App: Calculate the average number of likes, follows, and posts per app in a day
SELECT App,
AVG(Posts_Per_Day) AS avg_posts_perday,
AVG(Likes_Per_Day) AS avg_likes_perday,
AVG(Follows_Per_Day) AS avg_follows_perday
FROM social_media
GROUP BY App;

/*Total Engagement per App helps to understand the overall activity generated by users on each app. 
This is useful in identifying the apps that generate the most total interaction, irrespective of the number of users.*/

/*Average Engagement per App helps to understand user engagement behavior within each app. 
This metric shows how consistently users are engaging with the app on a day-to-day basis, which is useful for understanding user retention and app loyalty.*/


/*App Usage Insights
Most Popular Apps: Determine the most popular apps by looking at the total daily minutes per app.*/

SELECT App,
SUM(Daily_Minutes_Spent) AS total_dailyminutes
FROM social_media
GROUP BY App
ORDER BY total_dailyminutes DESC;

/*Average Usage Time per User per App: Calculate the average daily minutes spent by users on each app.*/
SELECT App,
AVG(Daily_Minutes_Spent) AS avg_dailyminutes
FROM social_media
GROUP BY App
ORDER BY avg_dailyminutes DESC;

/* Activity Correlations
This analysis will help understand if there's a relationship between the time spent on the app and engagement levels.*/

-- Time Spent vs. Likes Per Day: This could indicate that users who engage more with the app tend to receive more interactions (likes).
-- Time Spent vs. Posts Per Day: Does spending more time on the app correlate with creating more posts?
-- Time Spent vs. Follows Per Day: Does the amount of time spent on the app relate to how many new followers a user gains?
-- Posts Per Day vs. Likes Per Day: This shows if users who post more are more likely to get likes.
-- Likes Per Day vs. Follows Per Day: This measures if receiving more likes correlates with gaining more followers.

SELECT 
    'Time Spent vs Posts Per Day' AS correlation_pair,
    ROUND(
        (COUNT(*) * SUM(Daily_Minutes_Spent * Posts_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Posts_Per_Day)) /
        SQRT(
            (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
            (COUNT(*) * SUM(Posts_Per_Day * Posts_Per_Day) - SUM(Posts_Per_Day) * SUM(Posts_Per_Day))
        ), 2
    ) AS correlation_value,
    CASE
        WHEN (COUNT(*) * SUM(Daily_Minutes_Spent * Posts_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Posts_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
                 (COUNT(*) * SUM(Posts_Per_Day * Posts_Per_Day) - SUM(Posts_Per_Day) * SUM(Posts_Per_Day))
             ) > 0 THEN 'Positive'
        WHEN (COUNT(*) * SUM(Daily_Minutes_Spent * Posts_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Posts_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
                 (COUNT(*) * SUM(Posts_Per_Day * Posts_Per_Day) - SUM(Posts_Per_Day) * SUM(Posts_Per_Day))
             ) < 0 THEN 'Negative'
        ELSE 'Neutral'
    END AS correlation_direction

FROM social_media

UNION ALL

SELECT 
    'Time Spent vs Likes Per Day',
    ROUND(
        (COUNT(*) * SUM(Daily_Minutes_Spent * Likes_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Likes_Per_Day)) /
        SQRT(
            (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
            (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day))
        ), 2
    ),
    CASE
        WHEN (COUNT(*) * SUM(Daily_Minutes_Spent * Likes_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Likes_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
                 (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day))
             ) > 0 THEN 'Positive'
        WHEN (COUNT(*) * SUM(Daily_Minutes_Spent * Likes_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Likes_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
                 (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day))
             ) < 0 THEN 'Negative'
        ELSE 'Neutral'
    END

FROM social_media

UNION ALL

SELECT 
    'Time Spent vs Follows Per Day',
    ROUND(
        (COUNT(*) * SUM(Daily_Minutes_Spent * Follows_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Follows_Per_Day)) /
        SQRT(
            (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
            (COUNT(*) * SUM(Follows_Per_Day * Follows_Per_Day) - SUM(Follows_Per_Day) * SUM(Follows_Per_Day))
        ), 2
    ),
    CASE
        WHEN (COUNT(*) * SUM(Daily_Minutes_Spent * Follows_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Follows_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
                 (COUNT(*) * SUM(Follows_Per_Day * Follows_Per_Day) - SUM(Follows_Per_Day) * SUM(Follows_Per_Day))
             ) > 0 THEN 'Positive'
        WHEN (COUNT(*) * SUM(Daily_Minutes_Spent * Follows_Per_Day) - SUM(Daily_Minutes_Spent) * SUM(Follows_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Daily_Minutes_Spent * Daily_Minutes_Spent) - SUM(Daily_Minutes_Spent) * SUM(Daily_Minutes_Spent)) *
                 (COUNT(*) * SUM(Follows_Per_Day * Follows_Per_Day) - SUM(Follows_Per_Day) * SUM(Follows_Per_Day))
             ) < 0 THEN 'Negative'
        ELSE 'Neutral'
    END

FROM social_media

UNION ALL

SELECT 
    'Posts Per Day vs Likes Per Day',
    ROUND(
        (COUNT(*) * SUM(Posts_Per_Day * Likes_Per_Day) - SUM(Posts_Per_Day) * SUM(Likes_Per_Day)) /
        SQRT(
            (COUNT(*) * SUM(Posts_Per_Day * Posts_Per_Day) - SUM(Posts_Per_Day) * SUM(Posts_Per_Day)) *
            (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day))
        ), 2
    ),
    CASE
        WHEN (COUNT(*) * SUM(Posts_Per_Day * Likes_Per_Day) - SUM(Posts_Per_Day) * SUM(Likes_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Posts_Per_Day * Posts_Per_Day) - SUM(Posts_Per_Day) * SUM(Posts_Per_Day)) *
                 (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day))
             ) > 0 THEN 'Positive'
        WHEN (COUNT(*) * SUM(Posts_Per_Day * Likes_Per_Day) - SUM(Posts_Per_Day) * SUM(Likes_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Posts_Per_Day * Posts_Per_Day) - SUM(Posts_Per_Day) * SUM(Posts_Per_Day)) *
                 (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day))
             ) < 0 THEN 'Negative'
        ELSE 'Neutral'
    END

FROM social_media

UNION ALL

SELECT 
    'Likes Per Day vs Follows Per Day',
    ROUND(
        (COUNT(*) * SUM(Likes_Per_Day * Follows_Per_Day) - SUM(Likes_Per_Day) * SUM(Follows_Per_Day)) /
        SQRT(
            (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day)) *
            (COUNT(*) * SUM(Follows_Per_Day * Follows_Per_Day) - SUM(Follows_Per_Day) * SUM(Follows_Per_Day))
        ), 2
    ),
    CASE
        WHEN (COUNT(*) * SUM(Likes_Per_Day * Follows_Per_Day) - SUM(Likes_Per_Day) * SUM(Follows_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day)) *
                 (COUNT(*) * SUM(Follows_Per_Day * Follows_Per_Day) - SUM(Follows_Per_Day) * SUM(Follows_Per_Day))
             ) > 0 THEN 'Positive'
        WHEN (COUNT(*) * SUM(Likes_Per_Day * Follows_Per_Day) - SUM(Likes_Per_Day) * SUM(Follows_Per_Day)) /
             SQRT(
                 (COUNT(*) * SUM(Likes_Per_Day * Likes_Per_Day) - SUM(Likes_Per_Day) * SUM(Likes_Per_Day)) *
                 (COUNT(*) * SUM(Follows_Per_Day * Follows_Per_Day) - SUM(Follows_Per_Day) * SUM(Follows_Per_Day))
             ) < 0 THEN 'Negative'
        ELSE 'Neutral'
    END

FROM social_media;

/* 1.Time Spent vs Posts Per Day (Negative Correlation)
Interpretation: A negative correlation here means that as the time spent on the app increases, the number of posts per day tends to decrease. 
This might seem counterintuitive, but there could be several reasons for this:
Content Consumption vs. Content Creation: Users who spend more time on the app might be consuming content 
(e.g., scrolling, watching videos, or interacting with others) rather than creating content. 
In other words, longer time on the app could be spent viewing others' posts, liking or commenting, rather than posting themselves.
Time Spent in Different Activities: Some users might engage in long periods of passive activities (such as browsing or watching content) 
without engaging in active tasks like posting.

2. Time Spent vs Likes Per Day (Positive Correlation)
Interpretation: A positive correlation suggests that users who spend more time on the app tend to receive more likes on their posts. 
This makes sense, as users who are active on the app, engage with others, and post more frequently are likely to attract more interaction and likes. 
So, time spent might correlate with increased visibility, engagement, and likes.

3. Time Spent vs Follows Per Day (Positive Correlation)
Interpretation: A positive correlation here indicates that users who spend more time on the app also gain more followers. 
This is reasonable because active users, especially those engaging with content, liking, commenting, and posting, 
are more likely to be noticed and followed by others. Additionally, they might follow others more frequently, increasing their own follower count.

4. Posts Per Day vs Likes Per Day (Positive Correlation)
Interpretation: A positive correlation means that users who post more tend to receive more likes. 
This makes sense, as the more posts a user creates, the more opportunities they have for receiving likes. 
Frequent posting increases the chances of visibility and engagement with their audience.

5. Likes Per Day vs Follows Per Day (Negative Correlation)
Interpretation: A negative correlation here suggests that users who receive more likes on their posts tend to gain fewer followers. 
There could be a few explanations for this:
Engagement vs Growth: Some users might be receiving likes on their posts but not actively gaining new followers. 
They could have a stable follower base and might not be as focused on growing their following.
Content Strategy: It's possible that users receiving likes are more focused on creating content that appeals to their existing audience 
rather than attracting new followers. Users with more likes might have a loyal following that doesn't grow at the same rate*/

/*Comparative Analysis
App Usage Comparison: Compare total engagement (likes, follows, posts) across different apps to identify which app has the most active users.
Average Engagement by App: Compare the average daily activity across apps. This will show if users are more active on some apps versus others.*/


SELECT 
    User_ID,
    App,
    Daily_Minutes_Spent,
    Posts_Per_Day,
    Likes_Per_Day,
    Follows_Per_Day,
    CASE 
        WHEN Daily_Minutes_Spent > 100 AND Posts_Per_Day > 10 AND Likes_Per_Day > 100 AND Follows_Per_Day > 10 THEN 'Highly Engaged'
        WHEN Daily_Minutes_Spent BETWEEN 0 AND 100 AND Posts_Per_Day BETWEEN 0 AND 10  AND Likes_Per_Day BETWEEN 0 AND 100 AND Follows_Per_Day BETWEEN 0 AND 10 THEN 'Low Engaged'
        ELSE 'Not in any category'
    END AS engagement_level
FROM social_media;

/*This SQL query analyzes user engagement by categorizing users into three groups based on their activity:

1. Highly Engaged Users
These users are extremely active on the platform.
They spend over 100 minutes per day on the app.
They post more than 10 times per day.
They like over 100 posts per day.
They follow more than 10 accounts per day.
Interpretation:
These users are power users of the platform. They actively engage with content, create posts, and interact with others frequently. They are likely key contributors to the platform's activity and are valuable for monetization efforts or influencer programs.

2. Low Engaged Users
These users have minimal interaction with the platform.
They spend between 0 and 100 minutes per day on the app.
They post 0 to 10 times per day.
They like 0 to 100 posts per day.
They follow 0 to 10 accounts per day.
Interpretation:
These users are relatively inactive. They may log in occasionally but do not engage deeply. They could be casual users, new users, or users losing interest in the platform. They represent an opportunity for re-engagement strategies, such as targeted notifications or promotions.

3. Users Not in Any Category
These users do not fit into either of the above categories.
For example, they may spend very little time on the app, or their activity levels might not align with the defined thresholds.
Interpretation:
This group could include:
Users with unusual activity patterns.
Users with incomplete or missing data.
Outliers whose behavior doesn't follow typical engagement trends.
This group might require further analysis to understand their behavior better, and it may include bots or inactive accounts.*/
