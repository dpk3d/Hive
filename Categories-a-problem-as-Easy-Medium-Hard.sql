You have given two table.
tasks has id and name of the problem to solve.
 Table 1 : tasks
 
-------------
id  | name
-------------
101 | Distance
123 | Equilizer
142 | Median
300 | Tricolor
-----------------

reports has the candidateName with their scores anlong with unique id which is not null.

 Table 2 : reports
 
-------------------------------------------------
 id 	| task_id	| candidateName		| marks
-------------------------------------------------
11		| 101		| Moni Singh      | 100 
21		| 123		| Preetam Verma		| 34 
32		| 300		| Veerendra Royal	| 50 
22		| 101		| Deepak Singh 		| 45 
42		| 142		| Kapil Sharma 		| 37 
52		| 101		| Manav Sehgal 		| 3 
72		| 300		| Abhishek Bang		| 0
------------------------------------------------

If Student average scores for particular task is less than 20% then tag the problem as Hard.
If Student average scores for particular task is greater than 20% and less than 60% then tag the problem as Medium.
If Student average scores for particular task is greater than 60%then tag the problem as Easy.

Expectation : Write a query which result which task is easy, medium and hard based on student marks and should be in increasing order of task_id
  Output Should be like ..
  
---------------------------------------------
 task_id	| task_name		| difficultyLevel
---------------------------------------------
101			| Distance		| Easy
123			| Equilizer		| Medium
142			| Median		  | Hard
300			| Tricolor		| Medium
---------------------------------------------


SELECT t.id AS task_id,
	t.name AS task_name,
CASE
WHEN avg(r.marks) > 60 THEN 'Easy'
WHEN avg(r.marks) <= 60 and avg(r.marks) > 20 THEN 'Medium'
WHEN avg(r.marks) > 20 THEN 'Hard'
END difficultyLevel
from tasks t 
left join reports r 
on t.id = r.task_id
where r.id is not null
group by t.id, t.name
order by task_id;

 

 
 
