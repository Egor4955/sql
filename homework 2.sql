CREATE TABLE IF NOT EXISTS genres(
	genres_id   VARCHAR(80) NOT NULL PRIMARY KEY, 
	genres_name VARCHAR(40) NOT NULL);

CREATE TABLE IF NOT EXISTS artists(
	artists_id   VARCHAR(80) NOT NULL PRIMARY KEY, 
	artists_name VARCHAR(80) NOT NULL);

CREATE TABLE IF NOT EXISTS artists_genres(
	artists_genres_id VARCHAR(80) NOT NULL PRIMARY KEY, 
	artists_id        varchar(80) NOT NULL REFERENCES artists(artists_id), 
	genres_id         varchar(80) NOT NULL REFERENCES genres(genres_id));

CREATE TABLE IF NOT EXISTS albums(
	albums_id       VARCHAR(80) NOT NULL PRIMARY KEY, 
	album_name      VARCHAR(80) NOT NULL, 
	year_of_release INT         NOT NULL);

CREATE TABLE IF NOT EXISTS artists_albums(
	artists_albums_id VARCHAR(80) NOT NULL PRIMARY KEY,
	artists_id        VARCHAR(80) NOT NULL REFERENCES artists(artists_id),
	albums_id         VARCHAR(80) NOT NULL REFERENCES albums(albums_id));

CREATE TABLE IF NOT EXISTS tracks(
	tracks_id  VARCHAR(80) NOT NULL PRIMARY KEY, 
	albums_id  varchar(80) NOT NULL REFERENCES albums(albums_id), 
	track_name VARCHAR(80) NOT NULL, 
	duration   integer     NOT NULL);

CREATE TABLE IF NOT EXISTS songster(
	songster_id     VARCHAR(80) NOT NULL PRIMARY KEY, 
	songster_name   VARCHAR(40) NOT NULL, 
	year_of_release INT NOT null);

CREATE TABLE IF NOT EXISTS songster_tracks(
	songster_tracks_id VARCHAR(80) PRIMARY KEY,
	tracks_id          VARCHAR(80) NOT NULL REFERENCES tracks(tracks_id),
	songster_id        VARCHAR(80) NOT NULL REFERENCES songster(songster_id));

--Задание 1 

INSERT INTO genres(genres_id, genres_name)
VALUES (1, 'hip hop'),
	   (2, 'rock'),
	   (3, 'rap');

INSERT INTO artists(artists_id, artists_name)
VALUES (1, 'Black And Peas'),
	   (2, 'Ap/Dp'),
	   (3, 'Aminem'),
	   (4, 'Lana Bel Rey');

INSERT INTO artists_genres(artists_genres_id, artists_id, genres_id)
VALUES (96, 1, 1),
	   (97, 2, 2),
	   (98, 3, 3),
	   (99, 4, 1);	  
	  
	  
INSERT INTO albums(albums_id, album_name, year_of_release)
VALUES (101, 'Monkey Business', 2018),
	   (102, 'Highway to Hell', 2019),
	   (103, 'The Aminem Show', 2020),
	   (104, 'Born to Die', 2021);

INSERT INTO artists_albums(artists_albums_id, artists_id, albums_id)
VALUES (10, 1, 101),
	   (20, 2, 102),
	   (30, 3, 103),
	   (40, 4, 104);

INSERT INTO tracks (tracks_id, albums_id, track_name, duration)
VALUES (1, 101, 'Pump It', 213),
	   (2, 101, 'Dont Phunk with My Heart', 239),
	   (3, 101, 'My Style', 268),
	   (4, 101, 'Dont Lie', 219),
	   (5, 101, 'My Humps', 326),
	   (6, 101, 'Like That', 274),
	   (7, 102, 'Highway to Hell', 209),
	   (8, 102, 'Girls Got Rhythm', 204),
	   (9, 102, 'Walk All Over You', 310),
	   (10, 102, 'Touch Too Much', 268),
	   (11, 102, 'Beating Around the Bush', 235),
	   (12, 102, 'Shot Down in Flames', 203),
	   (13, 103, 'White America', 324),
	   (14, 103, 'Business', 251),
	   (15, 103, 'Cleanin’ Out My Closet', 298),
	   (16, 103, 'Square Dance', 323),
	   (17, 103, 'Soldier', 226),
	   (18, 103, 'Say Goodbye Hollywood', 272),
	   (19, 104, 'Born to Die', 286),
	   (20, 104, 'Off to the Races', 300),
	   (21, 104, 'Blue Jeans', 210),
	   (22, 104, 'Video Games', 282),
	   (23, 104, 'Diet Mountain Dew', 223),
	   (24, 104, 'National Anthem', 231);

-- Дополнил треками 	  
INSERT INTO albums(albums_id, album_name, year_of_release)
VALUES (105, 'Test test', 2018);

INSERT INTO tracks (tracks_id, albums_id, track_name, duration)	   
VALUES (25, 105, 'myself', 150),
	   (26, 105, 'by myself' , 150),
	   (27, 105, 'bemy SELF', 150),
	   (28, 105, 'myself BY',150), 
	   (29, 105, 'by myself BY', 150),
	   (30, 105, 'beemy', 150),
	   (31, 105, 'premyne', 150); 
	  
	   
INSERT INTO songster(songster_id, songster_name, year_of_release)
VALUES (501, 'Black And Peas + Aminem', 2019),
	   (502, 'Ap/Dp + Lana Bel Rey', 2020),
	   (503, 'Black And Peas + Lana Bel Rey', 2020),
	   (504, 'Ap/Dp + Aminem', 2021);

INSERT INTO songster_tracks(songster_tracks_id, tracks_id, songster_id)
VALUES (55, 2,  501),
	   (56, 12, 502),
	   (57, 1,  503),
	   (58, 14, 504);


-- Задание 2 
	  
SELECT track_name, duration 
FROM tracks
WHERE duration = (SELECT Max(duration) FROM tracks);

--Исправил опечатку 
SELECT track_name, duration 
FROM tracks
WHERE duration >= 210;

SELECT songster_name, year_of_release 
FROM songster
WHERE year_of_release >= 2018 AND year_of_release <= 2020;

SELECT artists_name 
FROM artists
WHERE artists_name NOT LIKE '% %';

--Изменил проверку 
SELECT track_name 
FROM tracks
WHERE track_name ILIKE 'my %'
OR track_name ILIKE '% my'
OR track_name ILIKE '% my %'
OR track_name ILIKE 'my';

-- Задание 3 

--Количество исполнителей в каждом жанре.
SELECT g.genres_name, count(a.artists_name)
FROM genres g
LEFT JOIN artists_genres ag on g.genres_id = ag.genres_id
LEFT JOIN artists a ON ag.artists_id = a.artists_id
GROUP BY g.genres_name
ORDER BY count(a.artists_id) DESC;


--Количество треков, вошедших в альбомы 2019–2020 годов.

SELECT count(t.tracks_id)
FROM tracks t
FULL JOIN albums a ON t.albums_id = a.albums_id
WHERE a.year_of_release >=2019 AND a.year_of_release <=2020;


--Средняя продолжительность треков по каждому альбому.

SELECT album_name, AVG(t.duration)
FROM albums a
LEFT JOIN tracks t ON t.albums_id = a.albums_id
GROUP BY a.album_name
ORDER BY AVG(t.duration)

--Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT DISTINCT a.artists_name
FROM artists a
WHERE a.artists_name NOT IN (
    SELECT DISTINCT artists_name
    FROM artists
    LEFT JOIN artists_albums aa ON artists.artists_id = aa.artists_id
    LEFT JOIN albums ON albums.albums_id = aa.albums_id
    WHERE albums.year_of_release = 2020)

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT s.songster_name
FROM songster s
LEFT JOIN songster_tracks st ON s.songster_id = st.songster_id
LEFT JOIN tracks t ON t.tracks_id = st.tracks_id
LEFT JOIN albums a ON a.albums_id = t.albums_id
LEFT JOIN artists_albums aa ON  aa.albums_id = a.albums_id
LEFT JOIN artists ar ON ar.artists_id = aa.artists_id
WHERE ar.artists_name LIKE 'Black And Peas'
ORDER BY s.songster_name;
































	   
	   











