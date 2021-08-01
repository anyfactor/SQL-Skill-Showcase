-- The goal is to see how level down an employee is from the president
-- Managers 1 level down, Engineer 2 level down.

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE Employees
(
EmployeeID INTEGER,
ManagerID INTEGER,
JobTitle TEXT,
Salary INTEGER
);

INSERT INTO Employees VALUES
(1001,NULL,'President',185000),
(2002,1001,'Director',120000),
(3003,1001,'Office Manager',97000),
(4004,2002,'Engineer',110000),
(5005,2002,'Engineer',142000),
(6006,2002,'Engineer',160000);

-- Manager ID is shows exactly what we need
-- 1001 > 1 level down, 2002 > 2 level Down
-- I can divide that value with 1001
-- Have ifnull convert the presidents value to 0
-- And use FLOOR to convert the float number to integer

SELECT *, FLOOR(IFNULL(ManagerID/1001, 0)) as Depth FROM Employees