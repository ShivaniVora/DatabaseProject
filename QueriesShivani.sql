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