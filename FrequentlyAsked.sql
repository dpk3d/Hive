1. Find Duplicates
----------------
select emp_id, count(1) from employee group by emp_id having count(1) > 1;

2. Delete Duplicates
-----------------------

select * from employee
with cte as (select * , row_number() over (partition by emp_id order by emp_id) as rank from employee) 
delete from cte where rank > 1;

3. Union and Union All difference
-------------------------------------
Union --> Will Remove all the Duplicates , give unique value
Union All --> Will have all the data , It's like merging 2 table : table 1 records + table 2 records., It will have duplicates

4.  What’s the difference? — RANK() vs.DENSE_RANK() vs.ROW_NUMBER()
-------------------------------------------------------------------

CREATE TABLE t AS
SELECT 'p' v FROM dual UNION ALL
SELECT 'p'   FROM dual UNION ALL
SELECT 'p'   FROM dual UNION ALL
SELECT 'q'   FROM dual UNION ALL
SELECT 'r'   FROM dual UNION ALL
SELECT 'r'   FROM dual UNION ALL
SELECT 's'   FROM dual UNION ALL
SELECT 't'   FROM dual;

SELECT
  v,
  ROW_NUMBER() OVER (ORDER BY v) row_number,
  RANK()       OVER (ORDER BY v) rank,
  DENSE_RANK() OVER (ORDER BY v) dense_rank
FROM t
ORDER BY v;
The above will yield:

+---+------------+------+------------+
| V | ROW_NUMBER | RANK | DENSE_RANK |
+---+------------+------+------------+
| p |          1 |    1 |          1 |
| p |          2 |    1 |          1 |
| p |          3 |    1 |          1 |
| q |          4 |    4 |          2 |
| r |          5 |    5 |          3 |
| r |          6 |    5 |          3 |
| s |          7 |    7 |          4 |
| t |          8 |    8 |          5 |
+---+------------+------+------------+



5. employee who are not present in department table.
-----------------------------------------------------
select * from employee where department_id not in (select department_id from department); --> Not Optimal Performance
select employee.*, department.department_id department.department_name from employee 
LEFT JOIN department on
employee.department_id = department.department_id
where department.department_name is null ;

6. Second Highest Salary on each department
--------------------------------------------

select * from (select employee.*, DENSE_RANK() over (partition by department_id order by salary desc )
as rn from employee) a 
where rn = 2;

7. Find all transaction done by Deepak
-----------------------------------------

select * from orders where upper(customer_name) = 'DEEPAK';

8. Self Join , employee manager query
-----------------------------------------
a. Find employee salary more than manager salary
------------------------------------------------
    select e.emp_id, e.emp_name, m.emp_name as manager, e.salary, m.salary as manager_salary
    from employee e
    inner join employee m on e.manager_id = m.emp_id
    where e.salary > m.salary;

9. Diffrent types of Joins
-------------------------------

10. update query to swap gender
-------------------------------------
select * from orders
update orders set customer_gender = case when customer_gender =  'MALE' then 'FEMALE'
                        when customer_gender = 'FEMALE' then 'MALE' end 

Medium Complex Query
------------------------
11. Write a query to find number of gold medals per swimmer for swimmer who won only gold medals
-------------------------------------------------------------------------------------------------
CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events;

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

select gold as player_name, count(1) as number_of_medals
from events
where gold not in (select silver from events Union all  select bronze from events)
group by gold;


-------------------------------------------------
12. Total number of people present in Office
-----------------------------------------------

with cte as (select emp_id , max(case when action = 'in' then time end) as login_time
                max(case when action = 'out' then time end) as logout_time
from office
group by emp_id)
select * from cte  where login_time  > logout_time or logout_time is null;


------------------------------------------------------------
13. Find employees whore salary and department both is same.
------------------------------------------------------------
with cte as salary_department (select department_id, salary from employee_salary group by department_id,salary
having count(1) >  1)
select * from employee_salary es  inner join  salary_department sd  on 
es.department_id = sd.department_id and es.salary =  sd.salary ;


with cte as salary_department (select department_id, salary from employee_salary group by department_id,salary
having count(1) >  1)
select * from employee_salary es  left join  salary_department sd  on 
es.department_id = sd.department_id and es.salary =  sd.salary 
where sd.department_id is null ;




-------------
14. Fetch the employees who are having same salary from each department.

 SELECT S1.Emp_Id,S1.EmpName,S1.DeptName, S1.NetSal
From (Select E.*, D.DeptName,
                     Count(*) Over (Partition by D.DeptName,E.NetSal) as SalaryCnt
          From [dbo].[Tbl_EmpDetails] E
   Inner Join [dbo].[Tbl_Dept] D
   ON E.Dept_Id=D.DeptId
  ) S1
WHERE S1.SalaryCnt > 1
ORDER By S1.NetSal Desc


-------------------

15. Year, revenue,diff , Write the Query to get the difference current year revenue- minus previous year revenue
2022,5,5-4
2021,4,4-7
2020,7,7

SELECT year,
       revenue,
       LAG(revenue) OVER ( ORDER BY year ) AS Revenue_Previous_Year
       revenue - LAG(revenue) OVER ( ORDER BY year ) AS YOY_Difference
FROM   yearly_metrics
--------------------------

----------------------------------------------------------
16. There’s
Customer_hist table
Cid,created_dt, updated-dt
All 5 year’s data
Customer_delta table
Cid,created_dt, updated-dt
Only updated and newly added records
Fetch yesterday’s updated and newly added records using history and incremental table. Write a code by comparing 2 tables

We need to join the table on Cid

with cte as joined( select h.* from Customer_hist h inner join Customer_delta d on h.Cid = d.Cid)
Select  * from joined where updated-dt >= dateadd(day,datediff(day,1,GETDATE()),0) 
AND created_dt >= dateadd(day,datediff(day,0,GETDATE()),0)

---------------------------------------------------------------------------------------


17. Dept table
Dno, loc
10,hyd
Null,hyd
********
Emp table
Eno,dno
101,10
102,10
103,Null
Select * from dept Left join emp On d.dno=e.dno
Write the output of the above query
Null,hyd

CREATE TABLE P1 (dno varchar(5), loc varchar(5));
INSERT INTO P1 (dno,loc) VALUES ('10', 'BLR');
INSERT INTO P1 (dno,loc) VALUES ('null', 'BLR');

CREATE TABLE P2 (eno int, eid varchar(5));  
INSERT INTO P2 (eno,eid) VALUES ('101', '10');
INSERT INTO P2 (eno,eid) VALUES ('102', '10');
INSERT INTO P2 (eno,eid) VALUES ('103', 'null');
SELECT * FROM P1 Left JOIN P2 ON P1.dno = P2.eno;

Output
--------------------------------
dno loc eno eid
10  BLR NULL    NULL
null    BLR NULL    NULL
---------------------------------
--------------------------------------------------------
18. Write the below code in pyspark
Read data from employee table, department table Join them by dept no. Write them to new table which is partitioned by dept no and mode is overwrite .



# Imports
from pyspark.sql import SparkSession

# Create SparkSession
spark = SparkSession.builder
           .appName('SparkByExamples.com')
           .config("spark.jars", "mysql-connector-java-6.0.6.jar")
           .getOrCreate()
# Read from SQL Table
sampleDF = spark.read \
  .format("com.microsoft.sqlserver.jdbc.spark") \
  .option("url", "jdbc:sqlserver://{SERVER_ADDR};databaseName=emp;") \
  .option("dbtable", "select e.* from employee e inner join department d on e.id=d.id") \
  .option("user", "replace_user_name") \
  .option("password", "replace_password") \
  .load()

sampleDF.write \
  .format("com.microsoft.sqlserver.jdbc.spark") \
  .partitionBy("dept_no") \
  .mode("overwrite") \
  .option("url", "jdbc:sqlserver://{SERVER_ADDR};databaseName=emp;") \
  .option("dbtable", "employee") \
  .option("user", "replace_user_name") \
  .option("password", "replace_password") \
  .save()

19. Check all the dept numbers in department table present in emp table or not. Write the optimized way.

select * from employee where department_id not in (select department_id from department); --> Not Optimal Performance
--> Optimal Performance <--
select employee.*, department.department_no department.department_name from employee 
LEFT JOIN department on
employee.department_no = department.department_no;

20. Generate surrogate key unique/sequence number without using row and rank functions in my pyspark
We can use monotically_increasing_id 
