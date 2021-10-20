-- Write a query to print the name of the students who scored an even number of marks
-- The Names should be listed in upper case alphabatecally ascending.
-- This was asked in VISA for DEVELOPER via hackerrank.

-- Schema
-- NAME STRING 
-- MARKS INTEGER

select upper(e.name), e.marks from (select name , marks, case
when mod(marks,2) = 0 then "even" else "odd"
end as type from exam) e where e.type = "even" order by e.name;
