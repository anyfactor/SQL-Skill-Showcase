-- Identify Workflow that began but did not end.

CREATE TABLE employees
(
Workflow LONGTEXT,
StepNumber INTEGER,
CompletionDate TEXT
);
INSERT INTO employees VALUES
('Alpha',1,'7/2/2018'),
('Alpha',2,'7/2/2018'),
('Alpha',3,'7/1/2018'),
('Bravo',1,'6/25/2018'),
('Bravo',2,NULL),
('Bravo',3,'6/27/2018'),
('Charlie',1,NULL),
('Charlie',2,'7/1/2018');

-- Simple solution

SELECT Workflow FROM employees
WHERE CompletionDate IS NULL

-- Solution with count
SELECT Workflow
FROM employees
GROUP BY Workflow
HAVING count(StepNumber) <> count(CompletionDate)