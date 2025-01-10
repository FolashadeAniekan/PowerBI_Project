# Social Media Engagement Analysis Dashboard

This repository contains a dashboard visualizing social media engagement metrics across multiple platforms, including Snapchat, TikTok, Instagram, Facebook, LinkedIn, Pinterest, and Twitter.

## Features
- **Daily Minutes Spent**: Comparison of highest and lowest daily time spent per app.
- **Activity Correlation**: Analyzes correlations between time spent, posts, likes, and follows.
- **Average Engagement**: Displays average posts, likes, and follows per app.
- **Engagement Levels**: Categorizes users into highly engaged, low engaged, or unclassified based on defined criteria.

## Data Source
The data used for this dashboard is fetched from a **MySQL database**. It was extracted and transformed for visualization using a dashboard tool (e.g., Power BI).

## Engagement Level Criteria
- **Highly Engaged**:
  - Daily minutes spent > 100
  - Posts per day > 10
  - Likes per day > 100
  - Follows per day > 10
- **Low Engaged**:
  - Daily minutes spent: 0–100
  - Posts per day: 0–10
  - Likes per day: 0–100
  - Follows per day: 0–10
- **Not in Any Category**:
  - Users who don’t fall into either of the above categories.
  - This could include users with outlier behaviors (e.g., very high posts but low likes).


## Tools Used
- **MySQL**: For data storage, analysis and querying.
- **Power BI**: For creating the dashboard.


## Visual Overview
The dashboard highlights:
- **Snapchat**: The highest daily minutes spent (40.02K).
- **TikTok**: The least daily minutes spent (32.91K).
- **Instagram**: The highest posts per day (1.586K).

