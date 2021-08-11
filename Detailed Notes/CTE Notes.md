# CTE

*This article was influenced by [u/stiffupperleg answer](https://old.reddit.com/r/SQL/comments/or59p3/how_do_i_develop_the_sql_way_of_thinking_as/h6o5tiv/) who knows SQL. Where I only pretend to SQL. And also this tutorial by [Alex the analysts](https://www.youtube.com/watch?v=K1WeoKxLZ5o)*

CTE stands for **C**ommon **T**able **E**xpression which used to simplify and to large extent efficienize your queries in SQL. The thing with SQL is that the more you tell SQL how to do things the more you are defeating the purpose of using SQL in the first place. Let SQL figure it's own way around the database and you just tell SQL what you need. And on the first step in this journey is to accept CTE to your heart.

As the [u/stiffupperleg](https://old.reddit.com/user/stiffupperleg) has said, 

> [By using CTE] The engine is going to try and generate the final select and process all the data through each section concurrently. To force sequential behavior you would use #tables

And unlike temp table which is created in a temp db, CTEs are created in memory so they are considerably more faster. It exists within the statement we write and once the query is finished the CTE vanishes. CTEs are more subqueries. It creates a temporary variable/place from which we can grab data.


```SQL
WITH CTE_Employee as (
  SELECT FirstName, LastName, Gender, Salary
  , COUNT(Gender), OVER (PARTITION BY Gender) as TotalGender
  , AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
  FROM EmployeeDemo emp
  JOIN EmpSalary sal
    ON emp.Id = sal.Id
  WHERE Salary > '45000'
)

SELECT * FROM CTE_Employee
```

CTE enables you to do the heavy lifting of the queries first and later allows you to easily access that data. Because CTEs are created in Memory they are not saved anywhere and cannot be accessed without running the CTE statement first. To access the CTE data you have to write the statement after you have written the CTE statement directly after.