/* Query 7 - SQL is used to store a new trip definition. (Or reject it if the trip name is a
duplicate.) */
INSERT INTO TRIP (TripName, Username, StartDate, EndDate)
VALUES ('Summer in Barcelona', 'camloyet', '2023-05-12', '2023-07-29');

/* Query 8 - Table is automatically populated with all cities and their avg rating based on
all users ratings (as long as the rating is public). */
SELECT CITY.CityName, CITY.Country, AVG(JOURNAL_ENTRY.Rating)
FROM CITY, JOURNAL_ENTRY
WHERE JOURNAL_ENTRY.PrivacyLevel = TRUE
GROUP BY CITY.CityName, CITY.Country;

/* Query 9 - “Search for City” textbox filters down to just “Barcelona” for example if you
that is typed in and “Search” button is clicked (updating this window). */
SELECT CITY.CityName, CITY.Country, AVG(JOURNAL_ENTRY.Rating)
FROM CITY, JOURNAL_ENTRY
WHERE JOURNAL_ENTRY.PrivacyLevel = TRUE AND City.CityName = 'London'
GROUP BY CITY.CityName, CITY.Country;

/* Query 10 - “Reset” goes back to all cities being loaded. (Clears the search textbox
too.) SQL #8 and SQL #10 might be the same - you decide. */
SELECT CITY.CityName, CITY.Country, AVG(JOURNAL_ENTRY.Rating)
FROM CITY, JOURNAL_ENTRY
WHERE JOURNAL_ENTRY.PrivacyLevel = TRUE
GROUP BY CITY.CityName, CITY.Country;