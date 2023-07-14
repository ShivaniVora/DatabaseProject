USE journal;

SET @user_field := "bobby";
SET @pass := "password456";
SET @firstname := "test";
SET @lastname := "lasttest";
SET @email := "test email2";
SET @isUser := 1;
SET @membershipStartDate := '2020-01-01';
SET @isPublic := 1;
SET @isBanned := 0;

-- Q1 - return 0 if admin, 1 if user, empty table if user Does Not Exist
SELECT IsUser FROM account WHERE username = @user_field AND UserPassword = @pass;

-- Q2 - throws error if account fails
INSERT INTO account VALUES
	(@firstname, @lastname, @user_field,@email,@pass,@isUser,@membershipStartDate,@isPublic,@isBanned);

-- Q3 NOT A QUERY


-- Q5
DELETE FROM account WHERE username = @user_field;

-- Q4 - return empty table if not admin/no user exists, a row with values otherwise
SELECT * FROM account WHERE username = @user_field AND IsUser = 1;


-- Q6
UPDATE account
SET FirstName = "Change me", LastName = "change me next", Email = "change me email", UserPassword = "Change me pwd", IsPublic = "0"
WHERE Username=@user_field;

SELECT * FROM account;



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
INSERT INTO USER_FLAGS(Username, EntryID)
VALUES ("camloyet", 2);
INSERT IGNORE INTO FLAG_REASON
VALUES (2, "Harassment");

-- SQL #14: Public vs Private. The user can choose to click to change that if they want to
SELECT IsPublic
FROM ACCOUNT
WHERE Username = "camloyet";

-- SQL #15 to save the city journal entry and then return the user to the home screen

INSERT INTO JOURNAL_ENTRY(Username,EntryDate, Note, Rating, PrivacyLevel, CityName, Country) 
VALUES ("camloyet", "2022-08-20", "Great visit!", 5, true, "Dublin", "Ireland");


-- SQL #16: query populates this screen with the user’s trip names. Clicking a trip name takes the user to the “My Trip Report” screen.
-- "user" is the username of the currently logged in user, has to be passed from previous screens
SELECT TripName
FROM TRIP
WHERE Username = "user";

-- SQL #17: query populates this screen with the user’s trip names. Clicking a trip name takes the user to the “My Trip Report” screen.
-- "user" is the username of the currently logged in user, has to be passed from previous screens
-- "trip" is the trip name of the trip that the user clicked on, has to be passed from previous screens
SELECT EntryDate, CityName, Country, Rating, Note
FROM JOURNAL_ENTRY NATURAL JOIN CITY
WHERE Username = "user" AND EntryDate BETWEEN (SELECT StartDate
												FROM TRIP
												WHERE TripName = "trip" AND Username = "user")
                                                AND
                                                (SELECT EndDate
												FROM TRIP
												WHERE TripName = "trip" AND Username = "user");

-- SQL #18: “Or show all of my entries” shows all of this user’s journal entries. (public and private
-- alike whether or not they are part of any trip range of dates)
-- "user" is the username of the currently logged in user, has to be passed from previous screens
SELECT EntryDate, CityName, Country, Rating, Note
FROM JOURNAL_ENTRY NATURAL JOIN CITY
WHERE Username = "user";

-- SQL #19: Clicking on “City” reorders the info alphabetically by city name (A-Z)
-- alike whether or not they are part of any trip range of dates)
-- "user" is the username of the currently logged in user, has to be passed from previous screens
-- "trip" is the trip name of the trip that the user clicked on, has to be passed from previous screens
SELECT EntryDate, CityName, Country, Rating, Note
FROM JOURNAL_ENTRY NATURAL JOIN CITY
WHERE Username = "user"
ORDER BY CityName ASC;

SELECT EntryDate, CityName, Country, Rating, Note
FROM JOURNAL_ENTRY NATURAL JOIN CITY
WHERE Username = "user" AND EntryDate BETWEEN (SELECT StartDate
												FROM TRIP
												WHERE TripName = "trip" AND Username = "user")
                                                AND
                                                (SELECT EndDate
												FROM TRIP
												WHERE TripName = "trip" AND Username = "user")
ORDER BY CityName ASC;

-- We get here from My Trip Report having clicked on a Note in the list.
-- SQL #20: populates this screen.
-- entryId comes from the past screen based on which note the user clicks on and which entry that is from
SELECT EntryDate, CityName, Rating, Note
FROM JOURNAL_ENTRY NATURAL JOIN CITY
WHERE EntryID = 1;

-- BUT, “delete” deletes this city entry via SQL #21.
-- entryId comes from the past screen based on which note the user clicks on and which entry that is from
DELETE FROM JOURNAL_ENTRY
WHERE EntryID = 1;

-- #22: SQL query used to help auto-populate this screen,
-- and each Note in the list is clickable to take us to the Admin’s Review City Entry screen.

USE journal;

SELECT
	je.username,
    je.cityName, 
    je.Note,
    GROUP_CONCAT(fr.Reason),
    uf.USERNAME AS FLAGGER
FROM
    JOURNAL_ENTRY je
    JOIN USER_FLAGS uf ON je.EntryID = uf.EntryID
    JOIN FLAG_REASON fr ON uf.FlagID = fr.FlagID
GROUP BY
    je.Username,
    je.CityName,
    je.Note,
    uf.Username;
    
-- #23: not a query

-- #24: populates the "Review Flagged Entry (admin)" 
SELECT
	je.cityName,
    je.EntryDate,
    je.Rating,
    je.Note
FROM
	JOURNAL_ENTRY je
    JOIN USER_FLAGS uf ON je.EntryID = uf.EntryID
WHERE
    uf.FlagID IS NOT NULL;
    
-- #25: "Clear Flag" button that clears the flag from the entry
UPDATE USER_FLAGS
SET FlagID = null 
WHERE EntryID = 1;

-- #26: "Delete entry" button which deletes this one entry
DELETE FROM JOURNAL_ENTRY
WHERE EntryID = 1;

-- #27: "Ban User" marks the user as banned, and all of their entries are deleted.
-- mark the user as banned
UPDATE USER
SET IsBanned = TRUE
WHERE username = "camloyet";

-- delete all entries of the banned user
DELETE FROM JOURNAL_ENTRY
WHERE Username = "camloyet";





