-- What will be the result of inner join
-- Table 1      Table 2
  1                1
  1                1
  2                1
  3                2
  4                2
                   3
                   5

CREATE TABLE P1 (ID int);
INSERT INTO P1 (ID) VALUES ('1');
INSERT INTO P1 (ID) VALUES ('1');
INSERT INTO P1 (ID) VALUES ('2');
INSERT INTO P1 (ID) VALUES ('3');
INSERT INTO P1 (ID) VALUES ('4');

CREATE TABLE P2 (ID int);  
INSERT INTO P2 (ID) VALUES ('1');
INSERT INTO P2 (ID) VALUES ('1');
INSERT INTO P2 (ID) VALUES ('1');
INSERT INTO P2 (ID) VALUES ('2');
INSERT INTO P2 (ID) VALUES ('2');
INSERT INTO P2 (ID) VALUES ('3');
INSERT INTO P2 (ID) VALUES ('5');

SELECT * FROM (P1 INNER JOIN P2 ON P1.ID = P2.ID);
-- Output :

ID	ID
1	1
1	1
1	1
1	1
1	1
1	1
2	2
2	2
3	3

-----------------
LEFT JOIN
-------------------

SELECT * FROM (P1 left JOIN P2 ON P1.ID = P2.ID);
------------
 -- Result of Left Join on above 2 tables
-- Output:

ID	ID
1	1
1	1
1	1
1	1
1	1
1	1
1	1
1	1
2	2
2	2
3	3
4	NULL

--------------
RIGTH JOIN 
-------------
  SELECT * FROM (P1 right JOIN P2 ON P1.ID = P2.ID);
-- Result of Right Join 
-- Output:
ID	ID
1	1
1	1
1	1
1	1
1	1
1	1
2	2
2	2
3	3
NULL	5

-----------
CROSS JOIN
------------
SELECT * FROM (P1 cross JOIN P2 ON P1.ID = P2.ID);
-- Result of cross join similar to inner join
--Output:

ID	ID
1	1
1	1
1	1
1	1
1	1
1	1
2	2
2	2
3	3
