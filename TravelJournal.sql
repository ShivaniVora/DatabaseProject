CREATE TABLE ACCOUNT(
	FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Username VARCHAR(30) UNIQUE PRIMARY KEY NOT NULL,
    Email VARCHAR(40) UNIQUE NOT NULL,
    UserPassword VARCHAR(20) NOT NULL
);


CREATE TABLE USER(
	Username VARCHAR(30) NOT NULL PRIMARY KEY,
    MembershipDate DATE NOT NULL,
    IsPublic BOOLEAN NOT NULL,
    IsBanned BOOLEAN,
	FOREIGN KEY (Username) REFERENCES ACCOUNTS(Username)
);

CREATE TABLE ADMIN(
	Username VARCHAR(30) NOT NULL PRIMARY KEY,
    StartDate DATE NOT NULL,
    FOREIGN KEY (Username) REFERENCES ACCOUNT(Username)
);

CREATE TABLE LOCATION(
	LocationID INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE CITY(
	CityName VARCHAR(20),
    Country VARCHAR(20),
    LocationID INT NOT NULL,
    PRIMARY KEY (CityName, Country),
    FOREIGN KEY (LocaitonID) REFERENCES LOCATION(LocationID)
);

CREATE TABLE SITE(
	SiteName VARCHAR(30),
    CityName VARCHAR(20),
    Country VARCHAR(20),
    LocationID INT NOT NULL,
    PRIMARY KEY (SiteName,CityName, Country),
    FOREIGN KEY (LocaitonID) REFERENCES LOCATION(LocationID)
);

CREATE TABLE TRIP(
	TripName VARCHAR(30),
    Username VARCHAR(30),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    PRIMARY KEY (TripName, Username),
    FOREIGN KEY (Username) REFERENCES USER(Username),
    CHECK (StartDate <= EndDate)
);


CREATE TABLE JOURNAL_ENTRY(
	Username VARCHAR(30) NOT NULL,
    EntryDate DATE NOT NULL,
    LocationID INT NOT NULL,
    Note VARCHAR(250),
    Rating INT 
		CHECK (Rating >= 1 AND Rating <= 5),
	PrivacyLevel BOOLEAN,
    EntryID INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (Username) REFERENCES USER(Username),
    FOREIGN KEY (LocationID) REFERENCES LOCATION(LocationID),
    CHECK (Rating IS NOT NULL OR Note IS NOT NULL),
    UNIQUE (Username, EntryDate, LocationID)
);

-- add assertion to set default if privacy level is null 


CREATE TABLE ENTRY_IN_TRIP(
	Username VARCHAR(30),
    EntryID INT,
    TripName VARCHAR(30),
    PRIMARY KEY (Username, EntryID, TripName),
    FOREIGN KEY (TripName, Username) REFERENCES TRIP(TripName, Username),
    FOREIGN KEY (EntryID) REFERENCES JOURNAL_ENTRY(EntryID)
);

CREATE TABLE REASON(
    Reason VARCHAR(50),
    PRIMARY KEY(Reason)
);

CREATE TABLE USER_FLAGS(
    Reason VARCHAR(30),
    EntryID INT,
    FlagID INT,
    PRIMARY KEY(FlagID),
    FOREIGN KEY (EntryID) REFERENCES JOURNAL_ENTRY(EntryID)
    );

CREATE TABLE FLAG_REASON(
    FlagID INT,
    Reason VARCHAR(50),
    PRIMARY KEY(FlagID, Reason),
    FOREIGN KEY (Reason) REFERENCES REASON(Reason),
    FOREIGN KEY (FlagID) REFERENCES USER_FLAGS(FlagID)
);