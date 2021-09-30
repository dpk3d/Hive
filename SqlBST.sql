-- Problem statement 
-- https://www.hackerrank.com/challenges/the-company/problem
SELECT N, CASE
WHEN P IS NULL THEN 'Root'
WHEN N in (SELECT DISTINCT P FROM BST) THEN 'Inner'
ELSE 'Leaf' END 
FROM BST ORDER BY N;
