--- Basics :P
--- 1

SELECT * FROM DATAFRAMENAME;

--- 2

SELECT column_x, column_y
FROM dataframename;

--- 3

SELECT column_x, column_y
FROM dataframename
WHERE clumn_z >= value;

--- 4 

SELECT COUNT(*)
FROM dataframename;

--- 5 

SELECT COUNT(column_x)
FROM dataframename
WHERE column_y = "value";

--- 6 

SELECT DISTINCT column_x
FROM dataframename;

--- 7 

SELECT COUNT(distinct column_x)
FROM dataframename
WHERE column_y = "value";

--- 8 

SELECT DISTINCT column_x
FROM dataframename
WHERE column_y = "value"
LIMIT number
OFFSET number;

--- 9

INSERT INTO dataframename(col1, col2, col3)
VALUES(x, y, z);

--- 10

UPDATE dataframename
SEL COL = "newvalue"
WHERE colx = "x";

--- 11

UPDATE dataframename
SET column_x = "newvalue"
WHERE column_y = "refvalue";

Ex:

UPDATE instructors
SET city = "Toronto"
WHERE firstname = "John";

--- 12

UPDATE datafrane
SET col_x = "newvalue", col_y, "newvalue"
WHERE col_y = z;

--- 13

DELETE FROM dataframename
WHERE col_x = value;
