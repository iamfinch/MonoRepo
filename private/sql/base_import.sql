-- SET TO UTF8
ALTER DATABASE my_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CREATE THE TABLES
CREATE TABLE Users (
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    username VARCHAR(64) NOT NULL UNIQUE,
    email VARCHAR(64) NOT NULL,
    password VARCHAR(256) DEFAULT NULL,
    first_password VARCHAR(256) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Security_Questions (
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    question VARCHAR(64) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE User_Security_Question(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INTEGER unsigned NOT NULL,
    security_question_id INTEGER unsigned NOT NULL,
    answer VARCHAR(64) NOT NULL,
    deleted BOOLEAN NOT NULL DEFAULT 0,
    deleted_date DATETIME DEFAULT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id)
    	REFERENCES Users(id)
    	ON DELETE CASCADE,
    FOREIGN KEY(security_question_id)
    	REFERENCES Security_Questions(id)
		ON DELETE CASCADE
);

CREATE TABLE Roles(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE User_Roles(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    role_id INTEGER unsigned NOT NULL,
    user_id INTEGER unsigned NOT NULL,
    deleted BOOLEAN NOT NULL DEFAULT 0,
    deleted_date DATETIME DEFAULT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(role_id)
    	REFERENCES Roles(id),
	FOREIGN KEY(user_id)
		REFERENCES Users(id)
);

CREATE TABLE Game_Types(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Conditions(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Card_Sets(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    game_type_id INTEGER unsigned NOT NULL,
    name VARCHAR(64) NOT NULL,
    deleted BOOLEAN DEFAULT 0,
    PRIMARY KEY(id),
    FOREIGN KEY(game_type_id)
    	REFERENCES Game_Types(id)
    	ON DELETE CASCADE
);

CREATE TABLE Card_Types(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    game_type_id INTEGER unsigned NOT NULL,
    name VARCHAR(64) NOT NULL,
    deleted BOOLEAN DEFAULT 0,
    PRIMARY KEY(id),
    FOREIGN KEY(game_type_id)
    	REFERENCES Game_Types(id)
    	ON DELETE CASCADE
);

CREATE TABLE Official_Cards(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    card_set_id INTEGER unsigned NOT NULL,
    card_type_id INTEGER unsigned NOT NULL,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(256) NOT NULL DEFAULT "",
    PRIMARY KEY(id),
    FOREIGN KEY(card_set_id)
    	REFERENCES Card_Sets(id)
    	ON DELETE CASCADE,
	FOREIGN KEY(card_type_id)
		REFERENCES Card_Types(id)
		ON DELETE CASCADE
);

CREATE TABLE User_Cards(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INTEGER unsigned NOT NULL,
    official_card_id INTEGER unsigned NOT NULL,
    condition_id INTEGER unsigned NOT NULL,
    misprINTEGER BOOLEAN DEFAULT 0,
    deleted BOOLEAN DEFAULT 0,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id)
    	REFERENCES Users(id)
    	ON DELETE CASCADE,
    FOREIGN KEY(official_card_id)
    	REFERENCES Official_Cards(id)
    	ON DELETE CASCADE,
	FOREIGN KEY(condition_id)
    	REFERENCES Conditions(id)
    	ON DELETE CASCADE
);

CREATE TABLE Decks(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INTEGER unsigned NOT NULL,
    name VARCHAR(64) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id)
    	REFERENCES Users(id)
    	ON DELETE CASCADE
);

CREATE TABLE Deck_Cards(
    id INTEGER unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INTEGER unsigned NOT NULL,
    user_card_id INTEGER unsigned NOT NULL,
    official_card_id INTEGER unsigned NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id)
    	REFERENCES Users(id)
    	ON DELETE CASCADE,
	FOREIGN KEY(user_card_id)
    	REFERENCES User_Cards(id)
    	ON DELETE CASCADE,
	FOREIGN KEY(official_card_id)
    	REFERENCES Official_Cards(id)
    	ON DELETE CASCADE
);

--INSERT THE VALUES INTO THE TABLES

INSERT INTO Roles (name)
VALUES ('admin'), ('user');

INSERT INTO Security_Questions (question)
VALUES ("What was your father's middle name?"), 
    ("What was your mother's maiden name?"),
    ("What was your first pet's name?"),
    ("Where were you born?"),
    ("What high school did you attend?");

INSERT INTO Game_Types (name)
VALUES ("Magic: The Gathering"), ("Pokemon"), ("Yu-gi-oh");

INSERT INTO Conditions (name)
VALUES ("Mint"), ("Near Mint"), ("Lightly Played"), ("Moderately Played,"), ("Heavily Played"), ("Damaged");

INSERT INTO Users (first_name, last_name, username, first_password, email)
VALUES ("Austin", "Finch", "BrainDead", "QualitativeNeeds21!", "iamfinch47@gmail.com"),
("Jake", "Ryan", "", "", "");