-- scripts/01_extract_or_load.sql
-- Purpose: Store the processed Spotify dataset in SQL for reproducibility (optional)
-- Works for MySQL (adjust for Postgres if needed)

CREATE DATABASE IF NOT EXISTS spotify_analytics;
USE spotify_analytics;

DROP TABLE IF EXISTS tracks;

CREATE TABLE tracks (
  track_name           VARCHAR(300),
  artist_name          VARCHAR(200),
  album_name           VARCHAR(300),
  album_type           VARCHAR(50),
  release_date         DATE,
  release_year         INT,
  release_month_num    INT,
  release_month        VARCHAR(10),
  release_year_month   VARCHAR(10),
  duration_ms          BIGINT,
  duration_minutes     DECIMAL(6,2),
  popularity           DECIMAL(6,2),
  explicit             BOOLEAN
);

-- Load cleaned CSV exported by Python:
-- Put spotify_clean.csv somewhere your SQL server can read.
-- Example path used by MySQL:
-- LOAD DATA INFILE '/path/to/spotify_clean.csv'
-- (You may need: SET GLOBAL local_infile = 1; and use LOAD DATA LOCAL INFILE)

-- LOAD DATA LOCAL INFILE '/path/to/spotify_clean.csv'
-- INTO TABLE tracks
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 LINES;

-- Validation checks
SELECT COUNT(*) AS total_rows FROM tracks;
SELECT COUNT(DISTINCT artist_name) AS distinct_artists FROM tracks;
SELECT AVG(popularity) AS avg_popularity FROM tracks;
SELECT AVG(duration_minutes) AS avg_duration_min FROM tracks;

-- Explicit vs Non-explicit
SELECT explicit, COUNT(*) AS cnt
FROM tracks
GROUP BY explicit;
