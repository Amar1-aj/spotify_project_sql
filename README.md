🎵 Spotify Music Analysis with SQL

[Click Here to get Dataset](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)

![Spotify Logo](https://github.com/Amar1-aj/spotify_project_sql/blob/main/spotify_logo.jpg)

## 🧠 Overview
This project is an end-to-end Exploratory Data Analysis (EDA) and analytical reporting exercise using a structured Spotify music dataset. It is designed to enhance your SQL skills from basic to advanced, using real-world music metadata and performance indicators like streams, views, likes, and more.

You will:

Understand the structure and distribution of Spotify music data.

Solve real-life analytical questions.

Use aggregate, window, and conditional functions.

Apply query optimization techniques using indexes and EXPLAIN ANALYZE.

## 🗂️ Project Structure
```sql
📁 Spotify_SQL_Analysis/
├── spotify.sql            -- Full SQL script (table, data cleaning, all queries)
├── README.md              -- Project documentation
├── screenshots/           -- Optional: Add visual snapshots of pgAdmin/Workbench
└── dataset/               -- Optional: Include CSV or SQL dump
```

## ✅ Project Steps
1. 📦 Table Creation

```sql
   CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    engery_liveness FLOAT,
    most_played_on VARCHAR(50)
);
```

2. 🔍 Exploratory Data Analysis (EDA)
Performed EDA using SQL to:

Count total records

Identify missing values (duration = 0)

Explore unique values (artists, albums, channels)

Clean invalid entries (e.g., delete where duration = 0)

Get max/min track duration


## 🧪 Practice Questions
🔹 Easy Level

| Question # | Query Description                                |
| ---------- | ------------------------------------------------ |
| Q1         | Retrieve tracks with more than 1 billion streams |
| Q2         | List all albums with their respective artists    |
| Q3         | Get total comments for licensed tracks           |
| Q4         | Find tracks from `album_type = 'single'`         |
| Q5         | Count number of tracks by each artist            |

🔸 Medium Level

| Question # | Query Description                                       |
| ---------- | ------------------------------------------------------- |
| Q6         | Average danceability of tracks in each album            |
| Q7         | Top 5 tracks with highest energy                        |
| Q8         | Tracks with views & likes where `official_video = TRUE` |
| Q9         | Total views for each album                              |
| Q10        | Tracks streamed more on Spotify than YouTube            |


🔺 Advanced Level

| Question # | Query Description                                                          |
| ---------- | -------------------------------------------------------------------------- |
| Q11        | Top 3 most-viewed tracks per artist (using `DENSE_RANK()` window function) |
| Q12        | Tracks with liveness above the average                                     |
| Q13        | Energy difference per album (using `WITH` CTE)                             |
| Q14        | Tracks where energy-to-liveness ratio > 1.2                                |
| Q15        | Cumulative likes for tracks ordered by views (using `SUM() OVER()`)        |

## 🚀 Query Optimization Techniques
🎯 Problem:
Query on artist + most_played_on + stream filtering was taking time:

```sql
SELECT artist, track, views
FROM spotify
WHERE artist = 'Gorillaz'
  AND most_played_on = 'Youtube'
ORDER BY stream DESC
LIMIT 25;
```

## 🔍 Solution:
1. EXPLAIN ANALYZE to understand cost:

```sql
EXPLAIN ANALYZE SELECT ...;
```

2. Create Index:
   
```sql
CREATE INDEX artist_index ON spotify (artist);
```
3. Optional compound index for even faster filtering:

```sql
CREATE INDEX combo_index ON spotify (artist, most_played_on, stream DESC);
```


## 📚 Learning Outcomes
Mastered SQL concepts: GROUP BY, HAVING, JOIN, WINDOW FUNCTIONS, CTEs, CASE WHEN, INDEXING

Performed real-world analytics on music data

Understood performance tuning in PostgreSQL


📬 Contact
If you liked the project or want to connect, reach out on LinkedIn or open an issue on GitHub.
