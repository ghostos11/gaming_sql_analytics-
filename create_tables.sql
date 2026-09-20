CREATE TABLE TEAMS (  
    team_id int NOT NULL PRIMARY KEY ,
    name VARCHAR(255),
    country VARCHAR(200) ,
    founded_year DATE,
    total_earnings INT
) ;



-- ============================================================
-- Sample data: teams
-- ============================================================

INSERT INTO teams (team_id, name, country, founded_year, total_earnings)
VALUES
    (1,  'FaZe Clan',        'US', '2010-05-30', 25000000.00),
    (2,  'G2 Esports',       'DE', '2014-02-24', 22000000.00),
    (3,  'Team Liquid',      'NL', '2000-01-01', 48000000.00),
    (4,  'Cloud9',           'US', '2013-01-01', 21000000.00),
    (5,  'T1',               'KR', '2004-01-01', 25000000.00),
    (6,  'Fnatic',           'GB', '2004-07-23', 20000000.00),
    (7,  'Natus Vincere',    'UA', '2009-12-17', 20000000.00),
    (8,  'OG',               'EU', '2015-10-31', 38000000.00),
    (9,  'Sentinels',        'US', '2018-01-01',  5000000.00),
    (10, 'LOUD',             'BR', '2019-01-01',  4000000.00),
    (11, 'Gen.G',            'KR', '2017-01-01', 12000000.00),
    (12, 'Vitality',         'FR', '2013-08-01', 15000000.00);




                #      pro_players table    #



CREATE TABLE pro_players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT,
    gamertag VARCHAR(50) NOT NULL UNIQUE,
    real_name VARCHAR(100),
    role VARCHAR(50),
    country VARCHAR(50),

    FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO pro_players
(player_id, team_id, gamertag, real_name, role, country)
VALUES
(1, 1, 'Nova', 'Alex Carter', 'Duelist', 'US'),
(2, 1, 'Vex', 'Daniel Brooks', 'Controller', 'US'),
(3, 2, 'Frost', 'Lukas Weber', 'Duelist', 'DE'),
(4, 2, 'Kiro', 'Jonas Klein', 'Initiator', 'DE'),
(5, 3, 'Shadow', 'Ethan Wilson', 'Controller', 'CA'),
(6, 3, 'Raze', 'Noah Martin', 'Duelist', 'CA'),
(7, 4, 'Ace', 'Ryan Mitchell', 'Duelist', 'US'),
(8, 4, 'Ghost', 'Kevin Moore', 'Sentinel', 'US'),
(9, 5, 'Zen', 'Min-Jun Park', 'Duelist', 'KR'),
(10, 5, 'Pulse', 'Ji-Hoon Kim', 'Initiator', 'KR'),
(11, 6, 'Blade', 'Oliver Smith', 'Duelist', 'GB'),
(12, 6, 'Nox', 'Harry Evans', 'Controller', 'GB'),
(13, 7, 'Storm', 'Andriy Kovalenko', 'Duelist', 'UA'),
(14, 7, 'Flash', 'Maksym Bondar', 'Initiator', 'UA'),
(15, 8, 'Orbit', 'Lucas Silva', 'Duelist', 'BR'),
(16, 8, 'Venom', 'Gabriel Costa', 'Controller', 'BR'),
(17, 9, 'Titan', 'Michael Johnson', 'Duelist', 'US'),
(18, 9, 'Echo', 'Chris Adams', 'Sentinel', 'US'),
(19, 10, 'Wolf', 'Pedro Santos', 'Duelist', 'BR'),
(20, 10, 'Blaze', 'Rafael Lima', 'Initiator', 'BR'),
(21, 11, 'Reaper', 'Kim Min-Soo', 'Duelist', 'KR'),
(22, 11, 'Arrow', 'Lee Joon-Ho', 'Sentinel', 'KR'),
(23, 12, 'King', 'Antoine Dubois', 'Duelist', 'FR'),
(24, 12, 'Drift', 'Lucas Bernard', 'Controller', 'FR');



              #      tournaments      # 


CREATE TABLE tournaments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    game_title VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    prize_pool DECIMAL(15,2),
    start_date DATE NOT NULL,
    end_date DATE,

    CHECK (prize_pool >= 0),
    CHECK (end_date IS NULL OR end_date >= start_date)
);



INSERT INTO tournaments
(tournament_id, title, game_title, location, prize_pool, start_date, end_date)
VALUES
(1, 'Global Masters 2025', 'Valorant', 'Los Angeles', 1000000.00, '2025-02-10', '2025-02-25'),
(2, 'World Esports Cup 2025', 'CS2', 'Berlin', 750000.00, '2025-04-05', '2025-04-20'),
(3, 'Summer Clash 2025', 'Valorant', 'Seoul', 500000.00, '2025-06-01', '2025-06-15'),
(4, 'Champions Invitational', 'Valorant', 'Tokyo', 1500000.00, '2025-08-10', '2025-08-30'),
(5, 'European Masters', 'CS2', 'Paris', 400000.00, '2025-09-05', '2025-09-18'),
(6, 'World Gaming Finals', 'Valorant', 'Shanghai', 2000000.00, '2025-11-01', '2025-11-20');




CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    team_a_id INT NOT NULL,
    team_b_id INT NOT NULL,
    winner_team_id INT,
    played_at DATETIME,
    score_a INT DEFAULT 0,
    score_b INT DEFAULT 0,

    FOREIGN KEY (tournament_id)
        REFERENCES tournaments(tournament_id)
        ON DELETE CASCADE,

    FOREIGN KEY (team_a_id)
        REFERENCES teams(team_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (team_b_id)
        REFERENCES teams(team_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (winner_team_id)
        REFERENCES teams(team_id)
        ON DELETE SET NULL,

    CHECK (team_a_id <> team_b_id),
    CHECK (score_a >= 0),
    CHECK (score_b >= 0)
);


INSERT INTO matches
(matche_id, tournament_id, team_a_id, team_b_id, winner_team_id, played_at, score_a, score_b)
VALUES
(1, 1, 1, 4, 1, '2025-02-12 18:00:00', 2, 0),
(2, 1, 9, 10, 9, '2025-02-14 19:00:00', 2, 1),
(3, 1, 1, 9, 1, '2025-02-20 20:00:00', 2, 1),

(4, 2, 3, 7, 3, '2025-04-08 17:00:00', 16, 10),
(5, 2, 2, 12, 2, '2025-04-10 17:00:00', 16, 12),
(6, 2, 3, 2, 3, '2025-04-18 19:00:00', 16, 9),

(7, 3, 5, 11, 5, '2025-06-03 15:00:00', 2, 1),
(8, 3, 9, 5, 5, '2025-06-10 16:00:00', 0, 2),

(9, 4, 1, 5, NULL, '2025-08-15 18:00:00', 0, 0),
(10, 4, 4, 9, 4, '2025-08-16 18:00:00', 2, 0),

(11, 5, 7, 12, 7, '2025-09-07 17:00:00', 16, 8),
(12, 5, 3, 7, 3, '2025-09-16 19:00:00', 16, 14),

(13, 6, 1, 10, NULL, '2025-11-05 20:00:00', 0, 0),
(14, 6, 5, 8, NULL, '2025-11-06 20:00:00', 0, 0);






CREATE TABLE rosters (
    player_id INT NOT NULL,
    team_id INT NOT NULL,
    joined_at DATE NOT NULL,
    left_at DATE,

    PRIMARY KEY (player_id, team_id, joined_at),

    FOREIGN KEY (player_id)
        REFERENCES pro_players(player_id)
        ON DELETE CASCADE,

    FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON DELETE CASCADE,

    CHECK (left_at IS NULL OR left_at >= joined_at)
);


INSERT INTO rosters
(player_id, team_id, joined_at, left_at)
VALUES
(1, 1, '2024-01-10', NULL),
(2, 1, '2024-03-15', NULL),

(3, 2, '2024-02-01', NULL),
(4, 2, '2024-05-20', NULL),

(5, 3, '2023-08-10', '2025-01-15'),
(5, 4, '2025-01-20', NULL),

(6, 3, '2024-01-05', NULL),

(7, 4, '2024-06-10', NULL),
(8, 4, '2024-07-01', NULL),

(9, 5, '2023-09-15', NULL),
(10, 5, '2024-02-20', NULL),

(11, 6, '2024-01-10', NULL),
(12, 6, '2024-04-15', NULL),

(13, 7, '2024-05-01', NULL),
(14, 7, '2024-06-15', NULL),

(15, 8, '2024-01-20', NULL),
(16, 8, '2024-03-10', NULL),

(17, 9, '2023-11-01', NULL),
(18, 9, '2024-01-05', NULL),

(19, 10, '2024-02-01', NULL),
(20, 10, '2024-03-15', NULL),

(21, 11, '2024-01-10', NULL),
(22, 11, '2024-05-05', NULL),

(23, 12, '2024-02-20', NULL),
(24, 12, '2024-04-01', NULL);





CREATE TABLE sponsors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sponsor_name VARCHAR(100) NOT NULL UNIQUE,
    industry VARCHAR(100)
);



INSERT INTO sponsors
(sponsor_id, sponsor_name, industry)
VALUES
(1, 'HyperTech', 'Technology'),
(2, 'GameFuel', 'Energy Drinks'),
(3, 'Nexon Gear', 'Gaming Hardware'),
(4, 'Volt Electronics', 'Electronics'),
(5, 'CloudNet', 'Cloud Computing'),
(6, 'SpeedLink', 'Internet Services'),
(7, 'Prime Energy', 'Energy Drinks'),
(8, 'Core Systems', 'Technology');




CREATE TABLE team_sponsors (
    team_id INT NOT NULL,
    sponsor_id INT NOT NULL,
    deal_value DECIMAL(15,2),
    signed_at DATE NOT NULL,

    PRIMARY KEY (team_id, sponsor_id, signed_at),

    FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON DELETE CASCADE,

    FOREIGN KEY (sponsor_id)
        REFERENCES sponsors(sponsor_id)
        ON DELETE CASCADE,

    CHECK (deal_value >= 0)
);




INSERT INTO team_sponsors
(team_id, sponsor_id, deal_value, signed_at)
VALUES
(1, 1, 500000.00, '2025-01-10'),
(1, 3, 300000.00, '2025-02-01'),

(2, 2, 250000.00, '2025-01-15'),
(2, 5, 400000.00, '2025-03-01'),

(3, 4, 350000.00, '2024-12-10'),
(3, 6, 200000.00, '2025-01-20'),

(4, 1, 450000.00, '2025-02-15'),
(4, 7, 275000.00, '2025-03-10'),

(5, 3, 500000.00, '2025-01-05'),
(5, 8, 350000.00, '2025-02-20'),

(6, 2, 200000.00, '2025-02-10'),
(7, 5, 300000.00, '2025-03-15'),

(8, 6, 180000.00, '2025-04-01'),
(9, 1, 600000.00, '2025-01-25'),

(10, 7, 250000.00, '2025-02-05'),
(11, 4, 320000.00, '2025-03-20'),

(12, 3, 275000.00, '2025-04-15');



select * 
from gaming_analytics_project.team_sponsors

