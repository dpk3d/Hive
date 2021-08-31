# We have table called Deepak given Below.
# Write a Query to find latest  record from the table
# Assume All the Data Types are in String
----------------------------------------
id    name    age  modifed
----------------------------------------
1     Deepak  10   2011-11-11 11:11:11
1     Deepak  11   2012-11-11 12:00:00
2     Moni    20   2012-12-10 10:11:12
2     Moni    20   2012-12-10 10:11:12
2     Moni    20   2012-12-12 10:11:12
2     Moni    20   2012-12-15 10:11:12
------------------------------------------

# Query Using row_number function.

SELECT d.id,d.name,d.age,d.modified
FROM (
    SELECT id,name,age,modified,
    ROW_NUMBER() OVER (
            PARTITION BY id ORDER BY unix_timestamp(modified,'yyyy-MM-dd hh:mm:ss') DESC
            ) AS rownum   
    FROM deepak
    ) d
WHERE d.rownum <= 1;

# Query Using max , where  we are creating a new column as lastModified based on timestamp.

select  id, name, age, max(modified) over (partition by id) last_modified from deepak where modified = last_modified;

# Query using Join.

select t1.* from test d1
join (
  select id, max(modifed) last_modified from deepak group by id
) sub
on d1.id = sub.id and d1.modifed = sub.last_modified
