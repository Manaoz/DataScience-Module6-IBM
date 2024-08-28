-- Exercise 3: Creating a Stored Procedure
/* 	Question 1
Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE 
that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer..
write a SQL statement to update the Leaders_Score field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified 
by in_School_ID to the value in the in_Leader_Score parameter*/
DELIMITER @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (
																				IN in_School_ID INT , 
                                                                                IN in_Leader_Score INT 
                                                                                )
BEGIN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Score = in_Leader_Score
		WHERE School_ID = in_School_ID;
END @
DELIMITER ;

/* Question 3
Inside your stored procedure, write a SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified 
by in_School_ID using the following information.*/
-- ------------------------------------------------------------
-- | Score Lower Limit | Score Upper Limit | Icon         |
-- |------------------|------------------|--------------|
-- | 80               | 99               | Very Strong  |
-- | 60               | 79               | Strong       |
-- | 40               | 59               | Average      |
-- | 20               | 39               | Weak         |
-- | 0                | 19               | Very Weak    |
-- ------------------------------------------------------------
DELIMITER @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (
																				IN in_School_ID INT , 
                                                                                IN in_Leader_Score INT 
                                                                                )
BEGIN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Score = in_Leader_Score
		WHERE School_ID = in_School_ID;
	
    -- IF CONDITION
    IF in_Leader_Score BETWEEN 0 AND 19 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Very Weak'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 20 AND 39 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Weak'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 40 AND 59 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Average'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 60 AND 79 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Strong'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 80 AND 99 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Very Strong'
        WHERE School_ID = in_School_ID;
	END IF;
END @
DELIMITER ;


-- Exercise 4: Using Transactions
/* 	Question 1
Update your stored procedure definition. 
Add a generic ELSE clause to the IF statement that rolls back the current work if the score did not fit any of the preceding categories.
Add a statement to commit the current unit of work at the end of the procedure.*/
DELIMITER @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (
																				IN in_School_ID INT , 
                                                                                IN in_Leader_Score INT 
                                                                                )
BEGIN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Score = in_Leader_Score
		WHERE School_ID = in_School_ID;
	
    -- IF CONDITION
    IF in_Leader_Score BETWEEN 0 AND 19 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Very Weak'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 20 AND 39 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Weak'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 40 AND 59 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Average'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 60 AND 79 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Strong'
        WHERE School_ID = in_School_ID;
    
    ELSEIF in_Leader_Score BETWEEN 80 AND 99 THEN
        UPDATE chicagopublicschools
        SET Leaders_Icon = 'Very Strong'
        WHERE School_ID = in_School_ID;
	
    ELSE
			ROLLBACK WORK;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Leader Score. Score must be between 0 and 99.';
	END IF;
END @
DELIMITER ;