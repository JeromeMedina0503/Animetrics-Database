-- ==============================================================================
-- Animetrics Database: Analytical Queries & Data Manipulation
-- ==============================================================================

-- 1. Identify the Highest-Rated Animation Studio
-- Aggregates average ratings across all properties produced by each studio to find top performers.
SELECT 
    Studio.StudioName, 
    ROUND(AVG(Anime.Rating), 2) AS AverageStudioRating,
    COUNT(Anime.AnimeID) AS TotalPropertiesProduced
FROM 
    Anime
JOIN 
    Studio ON Anime.StudioID = Studio.StudioID
GROUP BY 
    Studio.StudioName
ORDER BY 
    AverageStudioRating DESC
LIMIT 5;

-- 2. Compare Average Ratings: Anime vs. Manga
-- Calculates and compares the global average ratings between the two primary media types.
SELECT 
    'Anime' AS MediaType, 
    ROUND(AVG(Rating), 2) AS GlobalAverageRating 
FROM 
    Anime
UNION
SELECT 
    'Manga' AS MediaType, 
    ROUND(AVG(Rating), 2) AS GlobalAverageRating 
FROM 
    Manga;

-- 3. Filter Series by Creator and Release Decade
-- Retrieves properties created by specific authors within a targeted time frame (e.g., 1990s).
SELECT 
    PropertyTitle, 
    CreatorName, 
    ReleaseYear, 
    Genre
FROM 
    Properties
WHERE 
    ReleaseYear BETWEEN 1990 AND 1999
    AND CreatorName = 'Akira Toriyama'
ORDER BY 
    ReleaseYear ASC;

-- 4. Cross-Reference Properties with High Volume Counts
-- Finds expansive manga series with over 50 volumes and cross-references their anime adaptation status.
SELECT 
    Manga.Title, 
    Manga.VolumeCount, 
    Manga.Rating
FROM 
    Manga
WHERE 
    Manga.VolumeCount > 50
ORDER BY 
    Manga.VolumeCount DESC;
