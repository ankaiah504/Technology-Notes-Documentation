CAS:

Ref: https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-case/
SELECT 
  title, 
  length, 
  CASE WHEN length > 0 
  AND length <= 50 THEN 'Short' WHEN length > 50 
  AND length <= 120 THEN 'Medium' WHEN length > 120 THEN 'Long' END duration 
FROM 
  film 
ORDER BY 
  title;
  
  2) Using CASE with an aggregate function example
  
  If the rental rate is 0.99, the film is economic.
If the rental rate is 1.99, the film is mass.
If the rental rate is 4.99, the film is premium.

SELECT 
  SUM (
    CASE WHEN rental_rate = 0.99 THEN 1 ELSE 0 END
  ) AS "Economy", 
  SUM (
    CASE WHEN rental_rate = 2.99 THEN 1 ELSE 0 END
  ) AS "Mass", 
  SUM (
    CASE WHEN rental_rate = 4.99 THEN 1 ELSE 0 END
  ) AS "Premium" 
FROM 
  film;
  
  1) Simple PostgreSQL CASE expression example
SELECT title,
       rating,
       CASE rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
       END rating_description
FROM film
ORDER BY title;


2) Using simple PostgreSQL CASE expression with aggregate function example


SELECT 
  SUM(CASE rating WHEN 'G' THEN 1 ELSE 0 END) "General Audiences", 
  SUM(
    CASE rating WHEN 'PG' THEN 1 ELSE 0 END
  ) "Parental Guidance Suggested", 
  SUM(
    CASE rating WHEN 'PG-13' THEN 1 ELSE 0 END
  ) "Parents Strongly Cautioned", 
  SUM(CASE rating WHEN 'R' THEN 1 ELSE 0 END) "Restricted", 
  SUM(
    CASE rating WHEN 'NC-17' THEN 1 ELSE 0 END
  ) "Adults Only" 
FROM 
  film;
  
  COALESCE:
  ======================
  
  SELECT 
  product, 
  (
    price - COALESCE(discount, 0)
  ) AS net_price 
FROM 
  items;
  
  
  SELECT 
  product, 
  (
    price - CASE WHEN discount IS NULL THEN 0 ELSE discount END
  ) AS net_price 
FROM 
  items;
  
  
  
  NULLIF:
  
  ================
  
  NULLIF(argument_1,argument_2);
  
  NULLIF function returns a null value if argument_1 equals to argument_2, otherwise, it returns argument_1
  
  SELECT NULLIF (1, 1); 
  
  It returns null because the two arguments are equal.
  
  SELECT NULLIF (1, 0); -- return 1
  
  SELECT NULLIF ('A', 'B');   return ABS
  
  
  
  CAST:
  CAST() function and operator to convert a value of one type to another.
  
   cast operator (::)
   
   Sytax:
   CAST(<code>value</code> AS target_type );
   
   
   SELECT 
  CAST ('100' AS INTEGER);---------VALIDATE
  
  SELECT 
  CAST ('10C' AS INTEGER);[Err] ERROR:  invalid input syntax for integer: "10C"
LINE 2:  CAST ('10C' AS INTEGER);


Cast a string to a date example

SELECT
   CAST ('2015-01-01' AS DATE),
   CAST ('01-OCT-2015' AS DATE);
   
   3) Cast a string to a double example
   
   SELECT
	CAST ('10.2' AS DOUBLE);
	
	[Err] ERROR:  type "double" does not exist
LINE 2:  CAST ('10.2' AS DOUBLE)

SELECT
   CAST ('10.2' AS DOUBLE PRECISION);
   
   Cast a string to a boolean example
   
   
   SELECT 
   CAST('true' AS BOOLEAN),
   CAST('false' as BOOLEAN),
   CAST('T' as BOOLEAN),
   CAST('F' as BOOLEAN);
   
   
   5) Cast a string to a timestamp example

SELECT '2019-06-15 14:30:20'::timestamp;

6) Cast a string to an interval example


SELECT 
  '15 minute' :: interval, 
  '2 hour' :: interval, 
  '1 day' :: interval, 
  '2 week' :: interval, 
  '3 month' :: interval;
  
  
  7) Cast a timestamp to a date example
  
  SELECT CAST('2024-02-01 12:34:56' AS DATE);
  8) Cast an interval to text
 
  
  SELECT CAST('30 days' AS TEXT);

Home » PostgreSQL Tutorial » PostgreSQL CAST: Convert a value of One Type to Another

PostgreSQL CAST: Convert a value of One Type to Another
Summary: in this tutorial, you will learn how to use PostgreSQL CAST() function and operator to convert a value of one type to another.

Introduction to PostgreSQL CAST() function and cast operator (::)
There are many cases in which you want to convert a value of one type into another. PostgreSQL offers the CAST() function and cast operator (::) to do this.

PostgreSQL CAST() function
Here’s the basic syntax of the type CAST() function:

CAST(<code>value</code> AS target_type );
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, provide a value that you want to convert. It can be a constant, a table column, or an expression.
Then, specify the target data type to which you want to convert the value.
The CAST() returns a value after it has been cast to the specified target data type. If the CAST() function cannot cast the value to a target type, it’ll raise an error. The error message will depend on the nature of the conversion failure.

PostgreSQL cast operator (::)
Besides the type CAST() function, you can use the following cast operator (::) to convert a value of one type into another:

value::target_type
Code language: SQL (Structured Query Language) (sql)
In this syntax:

value is a value that you want to convert.
target_type specifies the target type that you want to cast the value to.
The cast operator :: returns a value after casting the value to the target_type or raise an error if the cast fails.

Notice that the cast operator (::) is PostgreSQL-specific and does not conform to the SQL standard

PostgreSQL CAST() function and cast operator (::) examples
Let’s take some examples of using the CAST operator to convert a value of one type to another.

1) Cast a string to an integer example
The following statement uses the CAST() operator to convert a string to an integer:

SELECT 
  CAST ('100' AS INTEGER);
Code language: SQL (Structured Query Language) (sql)
Output:

 int4
------
  100
(1 row)
If the expression cannot be converted to the target type, PostgreSQL will raise an error. For example:

SELECT 
  CAST ('10C' AS INTEGER);
Code language: SQL (Structured Query Language) (sql)
[Err] ERROR:  invalid input syntax for integer: "10C"
LINE 2:  CAST ('10C' AS INTEGER);
Code language: PHP (php)
2) Cast a string to a date example
This example uses the CAST() function to convert a string to a date:

SELECT
   CAST ('2015-01-01' AS DATE),
   CAST ('01-OCT-2015' AS DATE);
Code language: SQL (Structured Query Language) (sql)
Output:

    date    |    date
------------+------------
 2015-01-01 | 2015-10-01
(1 row)
In this example, we converted 2015-01-01 literal string into January 1st 2015 and 01-OCT-2015 to October 1st 2015.

3) Cast a string to a double example
The following example uses the CAST() function to convert a string '10.2' into a double:

SELECT
	CAST ('10.2' AS DOUBLE);
Code language: SQL (Structured Query Language) (sql)
Whoops, we got the following error message:

[Err] ERROR:  type "double" does not exist
LINE 2:  CAST ('10.2' AS DOUBLE)
Code language: PHP (php)
To fix this, you need to use DOUBLE PRECISION instead of DOUBLE as follows:

SELECT
   CAST ('10.2' AS DOUBLE PRECISION);
Code language: SQL (Structured Query Language) (sql)
Output:

 float8
--------
   10.2
(1 row)
Code language: CSS (css)
4) Cast a string to a boolean example
This example uses the CAST() to convert the string ‘true’, ‘T’ to true and ‘false’, ‘F’ to false:

SELECT 
   CAST('true' AS BOOLEAN),
   CAST('false' as BOOLEAN),
   CAST('T' as BOOLEAN),
   CAST('F' as BOOLEAN);
Code language: SQL (Structured Query Language) (sql)
Output:

 bool | bool | bool | bool
------+------+------+------
 t    | f    | t    | f
(1 row)
5) Cast a string to a timestamp example
This example uses the cast operator (::) to convert a string to a timestamp:

SELECT '2019-06-15 14:30:20'::timestamp;
Code language: SQL (Structured Query Language) (sql)
Output:

      timestamp
---------------------
 2019-06-15 14:30:20
(1 row)
Code language: CSS (css)
6) Cast a string to an interval example
This example uses the cast operator to convert a string to an interval:

SELECT 
  '15 minute' :: interval, 
  '2 hour' :: interval, 
  '1 day' :: interval, 
  '2 week' :: interval, 
  '3 month' :: interval;
Code language: SQL (Structured Query Language) (sql)
Output:

 interval | interval | interval | interval | interval
----------+----------+----------+----------+----------
 00:15:00 | 02:00:00 | 1 day    | 14 days  | 3 mons
(1 row)
7) Cast a timestamp to a date example
The following example uses the CAST() to convert a timestamp to a date:

SELECT CAST('2024-02-01 12:34:56' AS DATE);
Code language: SQL (Structured Query Language) (sql)
Output:

    date
------------
 2024-02-01
(1 row)
8) Cast an interval to text
The following example uses CAST() function to convert an interval to text:

SELECT CAST('30 days' AS TEXT);
Code language: SQL (Structured Query Language) (sql)
Output:

  text
---------
 30 days
(1 row)


10) Cast a JSON to a JSONB


