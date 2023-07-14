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


-- Q4 - return empty table if not admin/no user exists, a row with values otherwise
SELECT * FROM account WHERE username = @user_field AND IsUser = 1;


-- Q6
UPDATE account
SET FirstName = "Change me", LastName = "change me next", Email = "change me email", UserPassword = "Change me pwd", IsPublic = "0"
WHERE Username=@user_field;

SELECT * FROM account;

-- Q5
DELETE FROM account WHERE username = @user_field;
