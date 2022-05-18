--- Query A1: Enter a function that calculates the total cost of all animal rescues in the PETRESCUE table.

SELECT SUM(COST)
FROM PETRESCUE;

--- Query A2: Enter a function that displays the total cost of all animal rescues in the PETRESCUE table in a column called SUM_OF_COST.

SELECT SUM(COST) AS TOTAL_COST
FROM PETRESCUE;

--- Query A3: Enter a function that displays the maximum quantity of animals rescued.

SELECT MAX(QUANTITY)
FROM PETRESCUE;

--- Query A4: Enter a function that displays the average cost of animals rescued.

SELECT AVG(COST)
FROM PETRESCUE;

--- Query A5: Enter a function that displays the average cost of rescuing a dog.

SELECT AVG(COST/QUANTITY)
FROM PETRESCUE
WHERE ANIMAL = 'Dog';

--- Query B1: Enter a function that displays the rounded cost of each rescue.

SELECT ROUND(COST)
FROM PETRESCUE;

--- Query B2: Enter a function that displays the length of each animal name.

SELECT LENGTH(ANIMAL)
FROM PETRESCUE;

--- Query B3: Enter a function that displays the animal name in each rescue in uppercase.

SELECT UCASE(ANIMAL)
FROM PETRESCUE;

--- Query B4: Enter a function that displays the animal name in each rescue in uppercase without duplications.

SELECT DISTINCT(LCASE(ANIMAL))
FROM PETRESCUE;

--- Query B5: Enter a query that displays all the columns from the PETRESCUE table, where the animal(s) rescued are cats. Use cat in lower case in the query.

SELECT *
FROM PETRESCUE
WHERE LCASE(ANIMAL) = 'cat';

--- Query C1: Enter a function that displays the day of the month when cats have been rescued.

SELECT DAY(RESCUEDATE)
FROM PETRESCUE
WHERE ANIMAL = 'Cat';

--- Query C2: Enter a function that displays the number of rescues on the 5th month.

SELECT SUM(QUANTITY)
FROM PETRESCUE
WHERE MONTH(RESCUEDATE) = 5;

--- Query C3: Enter a function that displays the number of rescues on the 14th day of the month.

SELECT SUM(QUANTITY)
FROM PETRESCUE
WHERE DAY(RESCUEDATE) = 14;

--- Query C4: Animals rescued should see the vet within three days of arrivals. Enter a function that displays the third day from each rescue.

SELECT (RESCUEDATE + 3)
FROM PETRESCUE;

--- Query C5: Enter a function that displays the length of time the animals have been rescued; the difference between today’s date and the rescue date.

SELECT (CURRENT_DATE - RESCUEDATE)
FROM PETRESCUE;
