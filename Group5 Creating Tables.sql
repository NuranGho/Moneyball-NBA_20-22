-- Creating Tables with SQL

CREATE TABLE Arena (
ArenaID NUMBER NOT NULL,
Arena_name VARCHAR(100),
CONSTRAINT pk_arena PRIMARY KEY(ArenaID)
)

CREATE TABLE season (
     seasonID    NUMBER NOT NULL,
     year    VARCHAR(10)  NOT NULL,
CONSTRAINT pk_seasonID PRIMARY KEY (seasonID) )


CREATE TABLE TypeOfStats (
	statsID NUMBER NOT NULL,
	statsType VARCHAR (100),
CONSTRAINT pk_statsID PRIMARY KEY (statsID)
)

CREATE TABLE Match (
	Match_number NUMBER NOT NULL,
	seasonID NUMBER NOT NULL,
	Opponent_team VARCHAR(100),
	Win_loss VARCHAR(10),
Knicks_score NUMBER NOT NULL,
	Opp_score NUMBER NOT NULL,
	ArenaID NUMBER NOT NULL,
	dateOfgame DATE,
CONSTRAINT pk_Match PRIMARY KEY (Match_number),
CONSTRAINT fk_Match FOREIGN KEY (seasonID) REFERENCES season(seasonID),
CONSTRAINT fk_Match2 FOREIGN KEY (ArenaID) REFERENCES Arena(ArenaID)
)

CREATE TABLE Team (
Team_number NUMBER NOT NULL,
Team_name VARCHAR (100),
CONSTRAINT pk_Team PRIMARY KEY(Team_number)
)

CREATE TABLE Player (
PlayerID NUMBER NOT NULL,
Player_number NUMBER,
Team_number NUMBER,
First_name VARCHAR(50),
Last_name VARCHAR(50),
Position VARCHAR(30),
CONSTRAINT pk_Player PRIMARY KEY(PlayerID),
CONSTRAINT fk_Player FOREIGN KEY(Team_number) REFERENCES Team(Team_number)
)

CREATE TABLE MatchStats(
	Match_number NUMBER NOT NULL,
	PlayerID NUMBER,
StatsValue NUMBER,
StatsID NUMBER,
CONSTRAINT pk_MatchStats PRIMARY KEY (Match_number, PlayerID),
CONSTRAINT fk_MatchStats FOREIGN KEY (Match_number) REFERENCES Match (Match_number),
CONSTRAINT fk_MatchStats2 FOREIGN KEY (PlayerID) REFERENCES Player (PlayerID)
CONSTRAINT fk_MatchStats3 FOREIGN KEY (StatsID) REFERENCES TypeOfStats (StatsID)
)

CREATE TABLE MatchRoster (
	Match_number NUMBER NOT NULL,
PlayerID NUMBER NOT NULL,
CONSTRAINT pk_matchRoster PRIMARY KEY (Match_number, PlayerID),
CONSTRAINT fk_matchRoster FOREIGN KEY (Match_number) REFERENCES Match (Match_number),
CONSTRAINT fk_matchRoster2 FOREIGN KEY (PlayerID) REFERENCES Player (PlayerID)
