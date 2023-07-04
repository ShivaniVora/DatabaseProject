USE travel_journal;

INSERT IGNORE INTO ACCOUNT
VALUES
    ("Cameron", "Loyet", "camloyet", "cameron@gmail.com", "password1234"),
	("Bob", "Bober", "bobby", "cameron2@gmail.com", "password1234"),
    ("Tom", "Itschner", "travel_lover123", "tom@gmail.com", "travelingisfun");

INSERT IGNORE INTO USER
VALUES
    ("camloyet", "2020-08-08", TRUE, FALSE),
    ("travel_lover123", "2019-07-10", TRUE, NULL);

INSERT IGNORE INTO ADMIN
VALUES 
    ("bobby", "2013-07-21");

INSERT IGNORE INTO LOCATION
VALUES (),(),(),(),(),();

INSERT IGNORE INTO CITY
VALUES 
    ("London", "United Kingdom", 1),
    ("Dublin", "Ireland", 2),
    ("Sydney", "Australia", 3)
;

INSERT IGNORE INTO SITE (SiteName, CityName, Country, LocationID)
VALUES 
    ("Buckingham Palace", "London", "United Kingdom", 4),
    ("Cliffs of Moher", "Dublin", "Ireland",  5),
    ("Sydney Opera House", "Sydney", "Australia", 6)
;

INSERT IGNORE INTO TRIP
VALUES 
    ("Trip to London!", "camloyet", "2023-06-21", "2023-06-23"),
    ("Vacation in Dublin", "travel_lover123", "2022-06-20", "2022-06-27")
;

INSERT IGNORE INTO JOURNAL_ENTRY(Username,EntryDate, LocationID, Note, Rating, PrivacyLevel)
VALUES 
    ("camloyet", "2023-07-01", 1, "Saw Buckingham Palace with friends today! Didn't see my favorite King Charles though :(",
    4, TRUE),
    ("travel_lover123", "2023-06-01", 2, "Loved me a good ole Irish pub!",
    5, NULL)
;

INSERT IGNORE INTO ENTRY_IN_TRIP
VALUES 
    ("camloyet", 1, "Trip to London!"),
    ("travel_lover123", 1, "Vacation in Dublin")
;

INSERT IGNORE INTO REASON
VALUES 
    ("Profanity"),
    ("Inappropriate Language"),
    ("Spreads misinformation")
;

INSERT IGNORE INTO USER_FLAGS(Username, EntryID)
VALUES 
    ("camloyet", 1)
;

INSERT IGNORE INTO FLAG_REASON
VALUES 
    (1, "Profanity")
;

INSERT IGNORE INTO CATEGORY
VALUES 
    ("Museum"),
    ("Restaurant"),
    ("Park");
   
INSERT IGNORE INTO SITE_CATEGORIES
VALUES
    (1, "Museum"),
    (1, "Park");