--- Problem 1: Retrieve all employees whose adress is in Elgin,IL.

SELECT F_NAME , L_NAME
FROM EMPLOYEES
WHERE ADDRESS LIKE '%Elgin,IL%';

--- Problem 2: Retrieve all employees who were born during the 70s.

SELECT F_NAME , L_NAME
FROM EMPLOYEES
WHERE B_DATE LIKE '197%';

--- Problem 3: Retrieve all employees in department 5 whose salary is between 60000 and 70000.

SELECT *
FROM EMPLOYEES
WHERE (SALARY BETWEEN 60000 AND 70000) AND DEP_ID = 5;

--- Problem 4: Retrieve a list of employees ordered by department ID.

SELECT F_NAME , L_NAME , DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID;

--- Problem 5: Retrieve a list of employees ordered in descending order by department ID 
--- and within each department ordered alphabetically in descending order by last name.

SELECT F_NAME , L_NAME , DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

--- OPTIONAL PROBLEM: Use department name instead of department ID. 
--- Retrieve a list of employees ordered by department name, and within each department 
--- ordered alphabetically in descending order by last name.

SELECT D.DEP_NAME , E.F_NAME, E.L_NAME
FROM EMPLOYEES as E, DEPARTMENTS as D
WHERE E.DEP_ID = D.DEPT_ID_DEP
ORDER BY D.DEP_NAME, E.L_NAME DESC;

--- Problem 6: For each department ID retrieve the number of employees in the department.

SELECT DEP_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;

--- Problem 7: For each department retrieve the number of employees in the department, 
--- and the average employee salary in the department.

SELECT DEP_ID, AVG(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;

--- Problem 8: Label the computed columns in the result set of SQL problem 7
--- as NUM_EMPLOYEES and AVG_SALARY.

SELECT DEP_ID, AVG(SALARY) AS "AVG_SALARY", COUNT(*) AS "NUM_EMPLOYEES"
FROM EMPLOYEES
GROUP BY DEP_ID;

--- Problem 9: In SQL problem 8, order the result set by Average Salary.

SELECT DEP_ID, AVG(SALARY) AS "AVG_SALARY", COUNT(*) AS "NUM_EMPLOYEES"
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY "AVG_SALARY";

--- Problem 10: In SQL problem 9, limit the result to departments with fewer than 4 employees.

SELECT DEP_ID, AVG(SALARY) AS "AVG_SALARY", COUNT(*) AS "NUM_EMPLOYEES"
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING count(*) < 4
ORDER BY "AVG_SALARY";
