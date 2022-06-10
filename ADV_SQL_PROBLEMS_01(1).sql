--- Problem 1: List the case number, type of crime and community area for 
--- all crimes in community area number 18.

SELECT CCD.CASE_NUMBER, CCD.PRIMARY_TYPE, CCD.COMMUNITY_AREA_NUMBER
FROM CHICAGO_CRIME_DATA CCD INNER JOIN CHICAGO_SOCIOECONOMIC_DATA CSD
ON CCD.COMMUNITY_AREA_NUMBER = CSD.CA
WHERE CCD.COMMUNITY_AREA_NUMBER = 18;

--- Problem 2: List all crimes that took place at a school. Include case number, 
--- crime type and community name.

SELECT CCD.CASE_NUMBER, CCD.PRIMARY_TYPE, CCD.LOCATION_DESCRIPTION, CSD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME_DATA CCD LEFT JOIN CHICAGO_SOCIOECONOMIC_DATA CSD
ON CCD.COMMUNITY_AREA_NUMBER = CSD.CA
WHERE CCD.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

--- Problem 3: For the communities of Oakland, Armour Square, Edgewater and CHICAGO list the 
--- associated community_area_numbers and the case_numbers.

SELECT CSD.COMMUNITY_AREA_NAME, CSD.CA, CCD.CASE_NUMBER
FROM CHICAGO_CRIME_DATA CCD full JOIN CHICAGO_SOCIOECONOMIC_DATA CSD
ON CCD.COMMUNITY_AREA_NUMBER = CSD.CA
WHERE CSD.COMMUNITY_AREA_NAME IN ('Oakland', 'Armour Square', 'Edgewater', 'Edgewater', 'CHICAGO');


--- E1 Question 1: Write and execute a SQL query to list the school names, community names 
--- and average attendance for communities with a hardship index of 98.

SELECT CPS.NAME_OF_SCHOOL, CPS.COMMUNITY_AREA_NAME, CPS.AVERAGE_STUDENT_ATTENDANCE, 
CD.HARDSHIP_INDEX
FROM CHICAGO_PUBLIC_SCHOOLS CPS LEFT JOIN CENSUS_DATA CD
ON CPS.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE CD.HARDSHIP_INDEX = 98;

--- E1 Question 2: Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.

SELECT CCD.CASE_NUMBER, CCD.PRIMARY_TYPE, CCD.LOCATION_DESCRIPTION, CD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME_DATA CCD LEFT JOIN CENSUS_DATA CD
ON CCD.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE CCD.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

--- E2 Question 1: Creating a View.
--- Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.

CREATE OR REPLACE VIEW SCHOOLVIEW (School_Name, Safety_Rating, Family_Rating, Environment_Rating, Instruction_Rating, Leaders_Rating, Teachers_Rating)
AS SELECT NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, Environment_Icon, Instruction_Icon, Leaders_Icon, Teachers_Icon
FROM CHICAGO_PUBLIC_SCHOOLS;
SELECT * FROM SCHOOLVIEW;

SELECT SCHOOL_NAME, LEADERS_RATING
FROM SCHOOLVIEW;

--- E3 Question 1: Write the structure of a query to create or replace a stored procedure 
--- called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a 
--- in_Leader_Score parameter as an integer. Don't forget to use the #SET TERMINATOR 
--- statement to use the @ for the CREATE statement terminator.

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE ( 
    IN School_ID INTEGER, IN Leader_Score INTEGER )     

LANGUAGE SQL                                               
MODIFIES SQL DATA                                          

BEGIN 
       
END
@                                                           

--- E3 Question 2: Inside your stored procedure, write a SQL statement to update the 
--- Leaders_Score field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified 
--- by in_School_ID to the value in the in_Leader_Score parameter.Inside your stored 
--- procedure, write a SQL statement to update the Leaders_Score field 
--- in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID 
--- to the value in the in_Leader_Score parameter.

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE ( 
    IN in_School_ID INTEGER, IN in_Leader_Score INTEGER )     
    
LANGUAGE SQL                                                
MODIFIES SQL DATA                                           

BEGIN 
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = IN_LEADERS_SCORE
	WHERE SCHOOL_ID = IN_SCHOOL_ID;
	
END
@ 

--- E3 Question 3: Inside your stored procedure, write a SQL IF statement to update 
--- the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified 
--- by in_School_ID using the following information.

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE ( 
    IN in_School_ID INTEGER, IN in_Leader_Score INTEGER )     
  
LANGUAGE SQL                                                
MODIFIES SQL DATA                                           

BEGIN 
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = in_Leader_Score
	WHERE SCHOOL_ID = in_School_ID;
	
	IF in_Leader_Score >=80 AND in_Leader_Score <=99 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Very strong'
		WHERE SCHOOL_ID = in_School_ID;
	
	ELSEIF in_Leader_Score >=60 AND in_Leader_Score <=79 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Strong'
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >=40 AND in_Leader_Score <=59 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Average'
		WHERE SCHOOL_ID = in_School_ID;	

	ELSEIF in_Leader_Score >=20 AND in_Leader_Score <=39 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Weak'
		WHERE SCHOOL_ID = in_School_ID;	

	ELSEIF in_Leader_Score >=0 AND in_Leader_Score <=19 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Very Weak'
		WHERE SCHOOL_ID = in_School_ID;	
	
	END IF;
	
END
@ 


DROP PROCEDURE UPDATE_LEADERS_SCORE;

--- E3 Question 4: Run your code to create the stored procedure.
--- Write a query to call the stored procedure, passing a valid school ID and a 
--- leader score of 50, to check that the procedure works as expected.

CALL UPDATE_LEADERS_SCORE(400018, 50);
SELECT SCHOOL_ID, NAME_OF_SCHOOL, LEADERS_ICON
FROM CHICAGO_PUBLIC_SCHOOLS
WHERE SCHOOL_ID = 400018;

--- E4 Question 1: Update your stored procedure definition. Add a generic ELSE clause 
--- to the IF statement that rolls back the current work if the score did not fit 
--- any of the preceding categories.

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE ( 
    IN in_School_ID INTEGER, IN in_Leader_Score INTEGER )     
  
LANGUAGE SQL                                                
MODIFIES SQL DATA                                           

BEGIN 
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = in_Leader_Score
	WHERE SCHOOL_ID = in_School_ID;
	
	IF in_Leader_Score >=80 AND in_Leader_Score <=99 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Very strong'
		WHERE SCHOOL_ID = in_School_ID;
	
	ELSEIF in_Leader_Score >=60 AND in_Leader_Score <=79 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Strong'
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >=40 AND in_Leader_Score <=59 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Average'
		WHERE SCHOOL_ID = in_School_ID;	

	ELSEIF in_Leader_Score >=20 AND in_Leader_Score <=39 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Weak'
		WHERE SCHOOL_ID = in_School_ID;	

	ELSEIF in_Leader_Score >=0 AND in_Leader_Score <=19 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Very Weak'
		WHERE SCHOOL_ID = in_School_ID;	
	
	ELSE ROLLBACK WORK;
	
	END IF;
	
END
@ 

--- E4 Question 2: Update your stored procedure definition again. 
--- Add a statement to commit the current unit of work at the end of the procedure.

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE ( 
    IN in_School_ID INTEGER, IN in_Leader_Score INTEGER )     
  
LANGUAGE SQL                                                
MODIFIES SQL DATA                                           

BEGIN 
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = in_Leader_Score
	WHERE SCHOOL_ID = in_School_ID;
	
	IF in_Leader_Score >=80 AND in_Leader_Score <=99 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Very strong'
		WHERE SCHOOL_ID = in_School_ID;
	
	ELSEIF in_Leader_Score >=60 AND in_Leader_Score <=79 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Strong'
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >=40 AND in_Leader_Score <=59 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Average'
		WHERE SCHOOL_ID = in_School_ID;	

	ELSEIF in_Leader_Score >=20 AND in_Leader_Score <=39 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Weak'
		WHERE SCHOOL_ID = in_School_ID;	

	ELSEIF in_Leader_Score >=0 AND in_Leader_Score <=19 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET LEADERS_ICON = 'Very Weak'
		WHERE SCHOOL_ID = in_School_ID;	
	
	ELSE ROLLBACK WORK;
	
	END IF;
	
COMMIT WORK;
	
END
@ 

CALL UPDATE_LEADERS_SCORE(400018, 38);
SELECT SCHOOL_ID, NAME_OF_SCHOOL, LEADERS_ICON
FROM CHICAGO_PUBLIC_SCHOOLS
WHERE SCHOOL_ID = 400018;

CALL UPDATE_LEADERS_SCORE(400018, 101);
SELECT SCHOOL_ID, NAME_OF_SCHOOL, LEADERS_ICON
FROM CHICAGO_PUBLIC_SCHOOLS
WHERE SCHOOL_ID = 400018;
