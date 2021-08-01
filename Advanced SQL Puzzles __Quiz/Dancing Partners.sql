-- Provide a list of dance partners from a list based on opposite geneders
-- There is a mismatch as one individual will be left out without a partner.

-- Database

CREATE TABLE students (
  `ID` INT,
  `Gender` VARCHAR(1)
);

INSERT INTO students
  (`ID`, `Gender`)
VALUES
  ('1001', 'M'),
  ('2002', 'M'),
  ('3003', 'M'),
  ('4004', 'M'),
  ('5005', 'M'),
  ('6006', 'F'),
  ('7007', 'F'),
  ('8008', 'F'),
  ('9009', 'F');

-- Query

-- Attmept 1
-- Create two tables from the original table based on the genders

-- Creating the views based on geneder

CREATE VIEW male_dancer AS
  SELECT ID, Gender
  FROM students
  WHERE Gender='M';
  
CREATE VIEW female_dancer AS
  SELECT ID, Gender
  FROM students
  WHERE Gender='F';


-- Discovered an error with the following statement
SELECT male_dancer.ID, female_dancer.ID
from male_dancer, female_dancer;
-- Because of the irregular size of the rows in the views
-- I get the LCF numbers of rows from the rows of each of the views
-- LCF 20 from 5 and 4

-- UNION selects on single column of data
SELECT male_dancer.ID
from male_dancer
UNION
SELECT female_dancer.ID
from female_dancer;
-- Where I plan to have two columns side by side

-- A revaluation of plan
-- I cannot JOIN the tables without ON (From what I know)
-- So I need to provide a column to join on.
CREATE VIEW male_dancer AS
  SELECT ID, Gender,
  ROW_NUMBER() OVER(ORDER BY ID) AS EXTRA_COL 
  FROM students
  WHERE Gender='M';
  
CREATE VIEW female_dancer AS
  SELECT ID, Gender,
  ROW_NUMBER() OVER(ORDER BY ID) AS EXTRA_COL 
  FROM students
  WHERE Gender='F';

-- And from what I learned MySQL doesn't have "FULL OUTTER JOIN"
-- But LEFT JOIN works!

SELECT male_dancer.ID as Male_Dancer, female_dancer.ID as Female_Dancer
from male_dancer
LEFT JOIN
female_dancer
ON male_dancer.EXTRA_COL= female_dancer.EXTRA_COL

--- FULL QUERY

CREATE VIEW male_dancer AS
  SELECT ID, Gender,
  ROW_NUMBER() OVER(ORDER BY ID) AS EXTRA_COL 
  FROM students
  WHERE Gender='M';
  
CREATE VIEW female_dancer AS
  SELECT ID, Gender,
  ROW_NUMBER() OVER(ORDER BY ID) AS EXTRA_COL 
  FROM students
  WHERE Gender='F';

SELECT male_dancer.ID as Male_Dancer, female_dancer.ID as Female_Dancer
from male_dancer
LEFT JOIN
female_dancer
ON male_dancer.EXTRA_COL= female_dancer.EXTRA_COL
