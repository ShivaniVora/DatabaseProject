USE travel_journal;

INSERT IGNORE INTO ACCOUNT
VALUES
    ("Cameron", "Loyet", "camloyet", "cameron@gmail.com", "password1234", True, "2020-08-08", FALSE, FALSE),
	("Bob", "Bober", "bobby", "bobBryan@gmail.com", "password456", False, "2013-07-21", NULL, NULL),
    ("Tom", "Itschner", "travel_lover123", "tom@gmail.com", "travelingisfun", True, "2019-07-10", TRUE, TRUE);


INSERT IGNORE INTO CITY
VALUES 
    ("London", "United Kingdom", 1),
    ("Dublin", "Ireland", 2),
    ("Sydney", "Australia", 5)
;

INSERT IGNORE INTO TRIP
VALUES 
    ("Trip to London!", "camloyet", "2023-06-21", "2023-06-23"),
    ("Vacation in Dublin", "travel_lover123", "2022-06-20", "2022-06-27")
;

INSERT IGNORE INTO JOURNAL_ENTRY(Username, EntryDate, Note, Rating, PrivacyLevel, CityName, Country)
VALUES 
    ("camloyet", "2023-07-01", "Saw Buckingham Palace with friends today! Didn't see my favorite King Charles though :(",
    4, TRUE, "London", "United Kingdom"),
    ("travel_lover123", "2023-06-01", "Loved me a good ole Irish pub!",
    NULL, NULL, "Dublin", "Ireland"),
    ("travel_lover123", "2023-06-03", "Shamrocks rock!",
    4, NULL, "Dublin", "Ireland"),
    ("camloyet", "2023-06-01", NULL,
    3, NULL, "Dublin", "Ireland")
;

INSERT IGNORE INTO ENTRY_IN_TRIP
VALUES 
    ("camloyet", 1, "Trip to London!"),
    ("travel_lover123", 1, "Vacation in Dublin")
;

INSERT IGNORE INTO REASON
VALUES 
    ("Harassment"),
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


-- SQL #11: this window is populated with all the (public) entries from all users about one given city.
-- Dummy data: city/JE location ID
SELECT EntryDate, Rating, Note
FROM JOURNAL_ENTRY
WHERE CityName = "Dublin" AND Country = "Ireland" AND PrivacyLevel = True;

-- SQL #12: This is populated by SQL about a single public city journal entry from any user.
-- Dummy data: from previous screen city/JE location ID, EntryID
SELECT CityName, EntryDate, Rating, Note
FROM (JOURNAL_ENTRY NATURAL JOIN CITY)
WHERE EntryID = 2;

-- SQL #13: Pressing “report” will flag the entry, save the info about who flagged the entry, and save each of the reasons
INSERT IGNORE INTO USER_FLAGS(Username, EntryID)
VALUES ("camloyet", 2);
INSERT IGNORE INTO FLAG_REASON
VALUES (2, "Harassment");

-- SQL #14: Public vs Private. The user can choose to click to change that if they want to
SELECT IsPublic
FROM ACCOUNT
WHERE Username = "camloyet";

-- SQL #15 to save the city journal entry and then return the user to the home screen

INSERT IGNORE INTO JOURNAL_ENTRY(Username,EntryDate, Note, Rating, PrivacyLevel, CityName, Country) 
VALUES ("camloyet", "2022-08-20", "Great visit!", 5, true, "Dublin", "Ireland");





