DROP TABLE IF EXISTS spotify;

CREATE TABLE spotify(
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


SELECT * FROM spotify;


--EDA

SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify;

SELECT COUNT(DISTINCT album) FROM spotify;

SELECT duration_min FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT MIN(duration_min) FROM spotify;


SELECT * FROM spotify
WHERE duration_min = 0


DELETE FROM spotify
WHERE duration_min = 0;


SELECT * FROM spotify
WHERE duration_min = 0;

SELECT COUNT(*) FROM spotify;

SELECT DISTINCT channel FROM spotify;


SELECT DISTINCT most_played_on FROM spotify;


/*
-- Easy level 

Q.1 Retrieve the nanes of all tracks that have more than 1 billion streams.
Q.2 List all albums along with their repective artiest.
Q.3 Get the total number of comments for traks where 'licensed = True'.
Q.4 Find all tracks that belong to the album type 'single'.4
Q.5 Count the total number of tracks bu each artist.

*/


-- Q.1 Retrieve the names of all traks that have more than 1 billion streams.

SELECT * FROM spotify
WHERE stream > 1000000000


-- Q.2 List all albums along with their repective artiest.

SELECT 
	DISTINCT album, artist
	FROM spotify
	ORDER BY 1


SELECT 
	 DISTINCT album
	 FROM spotify
	 ORDER BY 1


-- Q.3 Get the total number of comments for tracks where licensed = True.

SELECT DISTINCT licensed FROM spotify;

SELECT * FROM spotify
WHERE licensed = 'true'


SELECT 
	SUM(comments) AS total_comments
FROM spotify
WHERE licensed = 'true'


-- Q.4 Find all traks that belong to the album type single.

SELECT * FROM spotify
WHERE album_type = 'single'


-- Q.5 Count the total number of tracks by each artist.

SELECT 
	artist,
	COUNT(*) AS total_no_songs
FROM spotify
GROUP BY artist
ORDER BY 2

/*

-------------------------------------
-- Medium Level Question
------------------------------------

Q.1 Calculate the average danceability tracks in each album.
Q.2 Find the 5 top tracks with the highest energy values.
Q.3 List all tracks along with their views and likes where official-video = True.
Q.4 For each album, calculate the total views of all associated tracks.
Q.5 Retrieve the track names that have been streamed on Spotify on Spotify more than YouTube.

*/


-- Q.6 Calculate the average danceability of tracks in each album.

SELECT 
	album,
	avg(danceability) AS avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC


-- Q.7 Find the top 5 tracks with the highest energy values.

SELECT
	track,
	MAX(energy)
FROM spotify
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 5

-- Q.8 List all traks along with their views and likes where official_video = True.

SELECT 
	track,
	SUM(views) AS total_views,
	SUM(likes) AS total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Q.9 For each album, calculate the total views of all associated tracks.

SELECT 
	album,
	track,
	SUM(views)
FROM spotify
GROUP BY 1, 2
ORDER BY 3 DESC


-- Q.10 Retrieve the track names that have been streamed on Spotify more than Youtube.

SELECT * FROM
(SELECT
		track,
		-- most_played_on
		COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END), 0) AS streamed_on_youtube,
		COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END), 0) AS streamed_on_spotify
FROM spotify
GROUP BY 1
) AS t1
WHERE 
	streamed_on_spotify > streamed_on_youtube
	AND
	streamed_on_youtube <> 0

------------------------------------
---   Advance level
------------------------------------

-- Q.11 Find the top 3 most-viewed tracks for each artist using windows functions.
-- Q.12 Write a qurey to find tracks where the liveness score is above the average.
-- Q.13 Use a WITH  clause to calculate the difference between the highest and lowest bvalues fo tracks in each album.
-- Q.14 Findt tracks where the energy-to-liveness ratio is greater than 1.2.
-- Q.15 Calculate the cumulative sum of likes for tracks ordered by the number of views, using windows functions.




-- Q.11 Find the top 3 most-viewed tracks for each artist using widows functions.

-- Each artists and total view for eahc track
-- Track with highest view for each artist (we need top)
-- Dense rank
-- cte and filder rank <=3.

WITH ranking_artist
AS
(SELECT
		artist,
		track,
		SUM(views) AS total_view,
		DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC
)
SELECT * FROM ranking_artist
WHERE rank <=3
		
		
-- Q.12 Write a query to find tracks where the liveness score is above the average.

SELECT * FROM spotify
WHERE 
liveness > 0.19

---------------------------------------------------------------
SELECT AVG(liveness) FROM spotify -- 0.19

---------------------------------------------------------------

SELECT * FROM spotify
WHERE 
liveness > (SELECT AVG(liveness) FROM spotify)
---------------------------------------------------------------

SELECT 
	track,
	artist,
	liveness
FROM spotify
WHERE 
liveness > (SELECT AVG(liveness) FROM spotify)

----------------------------------------------------------------

		
-- Q.13 Use a WITH to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH cte
AS
(SELECT 
	album,
	MAX(energy) AS highest_energy,
	MIN(energy) AS lowest_energy
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energy AS energy_diff
FROM cte
ORDER BY 2 DESC


----------------------------------------------------------------------

--- Query Optimization

EXPLAIN ANALYZE
SELECT 
	artist,
	track,
	views
FROM spotify
WHERE artist = 'Gorillaz'
		AND
		most_played_on = 'Youtube'
ORDER BY stream DESC LIMIT 25


CREATE INDEX artist_index ON spotify (artist);









