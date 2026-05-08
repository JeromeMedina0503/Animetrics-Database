PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE AnimationStudio (
    StudioID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(255) NOT NULL,
    CONSTRAINT ck_studio UNIQUE (Name)
);
INSERT INTO AnimationStudio VALUES(1,'MAPPA');
INSERT INTO AnimationStudio VALUES(2,'Toei Animation');
INSERT INTO AnimationStudio VALUES(3,'David Production');
INSERT INTO AnimationStudio VALUES(4,'Madhouse');
INSERT INTO AnimationStudio VALUES(5,'Bones');
INSERT INTO AnimationStudio VALUES(6,'Production I.G');
INSERT INTO AnimationStudio VALUES(7,'Ufotable');
INSERT INTO AnimationStudio VALUES(8,'Wit Studio');
INSERT INTO AnimationStudio VALUES(9,'A-1 Pictures');
INSERT INTO AnimationStudio VALUES(10,'Pierrot');
CREATE TABLE Creator (
    CreatorID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(255) NOT NULL,
    Nationality VARCHAR(100)
);
INSERT INTO Creator VALUES(1,'Eiichiro Oda','Japan');
INSERT INTO Creator VALUES(2,'Masashi Kishimoto','Japan');
INSERT INTO Creator VALUES(3,'Tsugumi Ohba','Japan');
INSERT INTO Creator VALUES(4,'Hiromu Arakawa','Japan');
INSERT INTO Creator VALUES(5,'Haruichi Furudate','Japan');
INSERT INTO Creator VALUES(6,'Koyoharu Gotouge','Japan');
INSERT INTO Creator VALUES(7,'Hajime Isayama','Japan');
INSERT INTO Creator VALUES(8,'Chugong','South Korea');
INSERT INTO Creator VALUES(9,'Gege Akutami','Japan');
INSERT INTO Creator VALUES(10,'Atsushi Ohkubo','Japan');
CREATE TABLE Genre (
    GenreID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    CONSTRAINT ck_genre UNIQUE (Name)
);
INSERT INTO Genre VALUES(1,'Shounen','Targeted at teen males, high action');
INSERT INTO Genre VALUES(2,'Sports','Centered around athletic competition');
INSERT INTO Genre VALUES(3,'Dark Fantasy','Fantasy with horror or gloomy themes');
INSERT INTO Genre VALUES(4,'Mecha','Features giant robots');
INSERT INTO Genre VALUES(5,'Thriller','High tension and suspense');
INSERT INTO Genre VALUES(6,'Action','High-energy physical combat');
INSERT INTO Genre VALUES(7,'Adventure','Epic journeys and exploration');
INSERT INTO Genre VALUES(8,'Sci-Fi','Futuristic and technology themes');
INSERT INTO Genre VALUES(9,'Magic','Focuses on magical abilities');
INSERT INTO Genre VALUES(10,'Drama','Emotional and serious storytelling');
CREATE TABLE VoiceActor (
    ActorID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(255) NOT NULL,
    PrimaryLanguage VARCHAR(50) NOT NULL
);
INSERT INTO VoiceActor VALUES(1,'Mayumi Tanaka','Japanese');
INSERT INTO VoiceActor VALUES(2,'Junko Takeuchi','Japanese');
INSERT INTO VoiceActor VALUES(3,'Mamoru Miyano','Japanese');
INSERT INTO VoiceActor VALUES(4,'Romi Park','Japanese');
INSERT INTO VoiceActor VALUES(5,'Ayumu Murase','Japanese');
INSERT INTO VoiceActor VALUES(6,'Natsuki Hanae','Japanese');
INSERT INTO VoiceActor VALUES(7,'Christopher Sabat','English');
INSERT INTO VoiceActor VALUES(8,'Yuri Lowenthal','English');
INSERT INTO VoiceActor VALUES(9,'Bryce Papenbrook','English');
INSERT INTO VoiceActor VALUES(10,'Aleks Le','English');
CREATE TABLE Publisher (
    PublisherID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(255) NOT NULL,
    CONSTRAINT ck_publisher UNIQUE (Name)
);
INSERT INTO Publisher VALUES(1,'Shueisha');
INSERT INTO Publisher VALUES(2,'Kodansha');
INSERT INTO Publisher VALUES(3,'Square Enix');
INSERT INTO Publisher VALUES(4,'D&C Media');
INSERT INTO Publisher VALUES(5,'VIZ Media');
INSERT INTO Publisher VALUES(6,'Yen Press');
INSERT INTO Publisher VALUES(7,'Dark Horse Comics');
INSERT INTO Publisher VALUES(8,'Seven Seas Entertainment');
INSERT INTO Publisher VALUES(9,'Tokyopop');
INSERT INTO Publisher VALUES(10,'Vertical Inc');
CREATE TABLE Manga (
    MangaID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(255) NOT NULL,
    VolumeCount INTEGER,
    CompletionStatus VARCHAR(50),
    MyRating INTEGER,
    CreatorID INTEGER NOT NULL,
    PublisherID INTEGER NOT NULL,
    CONSTRAINT fk_manga_creator FOREIGN KEY (CreatorID) REFERENCES Creator (CreatorID),
    CONSTRAINT fk_manga_publisher FOREIGN KEY (PublisherID) REFERENCES Publisher (PublisherID),
    CONSTRAINT ck_manga_title UNIQUE (Title)
);
INSERT INTO Manga VALUES(1,'One Piece',114,'Ongoing',10,1,1);
INSERT INTO Manga VALUES(2,'Naruto',72,'Completed',9,2,5);
INSERT INTO Manga VALUES(3,'Death Note',12,'Completed',10,3,5);
INSERT INTO Manga VALUES(4,'Fullmetal Alchemist',27,'Completed',10,4,3);
INSERT INTO Manga VALUES(5,'Haikyuu!!',45,'Completed',7,5,1);
INSERT INTO Manga VALUES(6,'Demon Slayer',23,'Completed',9,6,5);
INSERT INTO Manga VALUES(7,'Attack on Titan',34,'Completed',10,7,2);
INSERT INTO Manga VALUES(8,'Solo Leveling',15,'Completed',NULL,8,6);
INSERT INTO Manga VALUES(9,'Jujutsu Kaisen',30,'Completed',9,9,1);
INSERT INTO Manga VALUES(10,'Fire Force',34,'Completed',NULL,10,2);
CREATE TABLE Anime (
    AnimeID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(255) NOT NULL,
    EpisodeCount INTEGER,
    ReleaseYear INTEGER,
    MyRating INTEGER,
    StudioID INTEGER NOT NULL,
    CreatorID INTEGER NOT NULL,
    MangaID INTEGER, 
    CONSTRAINT fk_anime_studio FOREIGN KEY (StudioID) REFERENCES AnimationStudio (StudioID),
    CONSTRAINT fk_anime_creator FOREIGN KEY (CreatorID) REFERENCES Creator (CreatorID),
    CONSTRAINT fk_anime_manga FOREIGN KEY (MangaID) REFERENCES Manga (MangaID),
    CONSTRAINT ck_anime_title_year UNIQUE (Title, ReleaseYear)
);
INSERT INTO Anime VALUES(1,'One Piece',1155,1999,10,2,1,1);
INSERT INTO Anime VALUES(2,'Naruto',220,2002,9,10,2,2);
INSERT INTO Anime VALUES(3,'Fire Force',73,2019,7,3,10,10);
INSERT INTO Anime VALUES(4,'Death Note',37,2006,9,4,3,3);
INSERT INTO Anime VALUES(5,'Fullmetal Alchemist: Brotherhood',64,2009,10,5,4,4);
INSERT INTO Anime VALUES(6,'Haikyuu!!',85,2014,9,6,5,5);
INSERT INTO Anime VALUES(7,'Demon Slayer',63,2019,8,7,6,6);
INSERT INTO Anime VALUES(8,'Attack on Titan',89,2013,10,8,7,7);
INSERT INTO Anime VALUES(9,'Solo Leveling',12,2024,9,9,8,8);
INSERT INTO Anime VALUES(10,'Jujutsu Kaisen',47,2020,9,1,9,9);
CREATE TABLE AnimeGenre (
    AnimeID INTEGER NOT NULL,
    GenreID INTEGER NOT NULL,
    PRIMARY KEY (AnimeID, GenreID),
    CONSTRAINT fk_ag_anime FOREIGN KEY (AnimeID) REFERENCES Anime (AnimeID),
    CONSTRAINT fk_ag_genre FOREIGN KEY (GenreID) REFERENCES Genre (GenreID)
);
INSERT INTO AnimeGenre VALUES(1,1);
INSERT INTO AnimeGenre VALUES(2,1);
INSERT INTO AnimeGenre VALUES(3,8);
INSERT INTO AnimeGenre VALUES(4,5);
INSERT INTO AnimeGenre VALUES(5,1);
INSERT INTO AnimeGenre VALUES(6,2);
INSERT INTO AnimeGenre VALUES(7,3);
INSERT INTO AnimeGenre VALUES(8,3);
INSERT INTO AnimeGenre VALUES(9,6);
INSERT INTO AnimeGenre VALUES(10,3);
CREATE TABLE MangaGenre (
    MangaID INTEGER NOT NULL,
    GenreID INTEGER NOT NULL,
    PRIMARY KEY (MangaID, GenreID),
    CONSTRAINT fk_mg_manga FOREIGN KEY (MangaID) REFERENCES Manga (MangaID),
    CONSTRAINT fk_mg_genre FOREIGN KEY (GenreID) REFERENCES Genre (GenreID)
);
INSERT INTO MangaGenre VALUES(1,7);
INSERT INTO MangaGenre VALUES(2,6);
INSERT INTO MangaGenre VALUES(3,5);
INSERT INTO MangaGenre VALUES(4,1);
INSERT INTO MangaGenre VALUES(5,2);
INSERT INTO MangaGenre VALUES(6,3);
INSERT INTO MangaGenre VALUES(7,3);
INSERT INTO MangaGenre VALUES(8,6);
INSERT INTO MangaGenre VALUES(9,3);
INSERT INTO MangaGenre VALUES(10,8);
CREATE TABLE AnimeVoiceActor (
    AnimeID INTEGER NOT NULL,
    ActorID INTEGER NOT NULL,
    PRIMARY KEY (AnimeID, ActorID),
    CONSTRAINT fk_ava_anime FOREIGN KEY (AnimeID) REFERENCES Anime (AnimeID),
    CONSTRAINT fk_ava_actor FOREIGN KEY (ActorID) REFERENCES VoiceActor (ActorID)
);
INSERT INTO AnimeVoiceActor VALUES(1,1);
INSERT INTO AnimeVoiceActor VALUES(2,2);
INSERT INTO AnimeVoiceActor VALUES(9,10);
INSERT INTO AnimeVoiceActor VALUES(4,3);
INSERT INTO AnimeVoiceActor VALUES(5,4);
INSERT INTO AnimeVoiceActor VALUES(6,5);
INSERT INTO AnimeVoiceActor VALUES(7,6);
INSERT INTO AnimeVoiceActor VALUES(1,7);
INSERT INTO AnimeVoiceActor VALUES(2,8);
INSERT INTO AnimeVoiceActor VALUES(8,9);
PRAGMA writable_schema=ON;
CREATE TABLE IF NOT EXISTS sqlite_sequence(name,seq);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('AnimationStudio',10);
INSERT INTO sqlite_sequence VALUES('Creator',10);
INSERT INTO sqlite_sequence VALUES('Genre',10);
INSERT INTO sqlite_sequence VALUES('VoiceActor',10);
INSERT INTO sqlite_sequence VALUES('Publisher',10);
INSERT INTO sqlite_sequence VALUES('Manga',10);
INSERT INTO sqlite_sequence VALUES('Anime',10);
PRAGMA writable_schema=OFF;
COMMIT;
