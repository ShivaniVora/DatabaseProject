-- #22: SQL query used to help auto-populate this screen,
-- and each Note in the list is clickable to take us to the Admin’s Review City Entry screen.

USE journal;

SELECT
	je.username,
    c.cityName, 
    je.Note,
    GROUP_CONCAT(fr.Reason),
    uf.USERNAME AS FLAGGER
FROM
    JOURNAL_ENTRY je
    JOIN USER_FLAGS uf ON je.EntryID = uf.EntryID
    JOIN FLAG_REASON fr ON uf.FlagID = fr.FlagID
    JOIN CITY c ON je.LocationID = c.LocationID
GROUP BY
    je.Username,
    c.CityName,
    je.Note,
    uf.Username;
    
-- #23: not a query

-- #24: populates the "Review Flagged Entry (admin)" 
SELECT
	c.cityName,
    je.EntryDate,
    je.Rating,
    je.Note
FROM
	JOURNAL_ENTRY je
    JOIN USER_FLAGS uf ON je.EntryID = uf.EntryID
    JOIN CITY c ON je.LocationID = c.LocationID
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





	
    
    
	
	