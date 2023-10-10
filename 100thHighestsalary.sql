#Oracle
SELECT * FROM (

SELECT e.*, ROW_NUMBER() OVER (ORDER BY  salary DESC) rank

FROM Employee e )

WHERE rank = 100;

#MYSQL using  LIMIT

Select salary from employee ORDER BY salary DESC LIMIT 99,1 

select * from
(select Salary, rank() over (order by Salary desc) as r
from Employee) a
where r = 100;


