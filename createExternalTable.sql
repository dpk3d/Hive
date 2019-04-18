CREATE EXTERNAL TABLE employee (
  emp_id INT,
  emp_name STRING,
  emp_salary INT,
  dept_name STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/it_db/employee';

SELECT * FROM orders LIMIT 10;

SELECT count(1) FROM orders;
