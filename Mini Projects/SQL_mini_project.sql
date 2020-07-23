/*  SQL mini project.




/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */

/* Answer Q1: 
SELECT name
FROM facilities
WHERE membercost >= 1

/* Q2: How many facilities do not charge a fee to members? */

/* Answer Q2:
SELECT COUNT(*) AS  Number_of_facilities_Dontcharche
FROM facilities
WHERE membercost = 0

/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

/* Answer Q3:
SELECT facid, name, membercost, monthlymaintenance
FROM facilities
WHERE membercost > 0 AND membercost < monthlymaintenance * 0.20

/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */

/* Answer Q4:
SELECT *
FROM facilities
WHERE facid IN (1, 5)


/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

/* Answer Q5: 
SELECT name, monthlymaintenance,
CASE
     WHEN monthlymaintenance > 100 THEN 'expensive'
    WHEN monthlymaintenance < 100 THEN 'cheap'
END AS 'cheap_or_expensive'
FROM facilities

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

/* Answer Q6: 
SELECT firstname, surname, joindate
FROM members
WHERE joindate = (select max(joindate) FROM members)


/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

/* Answer Q7:
SELECT DISTINCT facilities.name AS court_name, CONCAT(members.firstname, members.surname) AS member_name
FROM members 
INNER JOIN bookings ON members.memid = bookings.memid
INNER JOIN facilities ON facilities.facid = bookings.memid
ORDER BY members.firstname, members.surname


/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

/* Answer Q8: 
SELECT facilities.name, CONCAT(members.firstname, members.surname) AS Memname, 
CASE
	WHEN members.memid = 0 THEN bookings.slots * facilities.guestcost
   	 ELSE bookings.slots * facilities.membercost
END AS cost
FROM members
INNER JOIN bookings ON members.memid = bookings.memid
INNER JOIN facilities ON facilities.facid = bookings.memid
WHERE bookings.starttime >= '2012-09-14' AND bookings.starttime < '2012-09-15'
AND ( (members.memid = 0 AND bookings.slots*facilities.guestcost >= 30)
  OR (members.memid !=  0 AND bookings.slots*facilities.membercost >= 30) )
ORDER BY cost DESC


/* Q9: This time, produce the same result as in Q8, but using a subquery. */

/* Answer Q9:
SELECT sub.*
FROM (
    SELECT *
      FROM Bookings
    WHERE b.slots f.membercost 2>30
    AND b.slots f.guestcost 2>30 
    ) sub
WHERE b.starttime LIKE '2012-09-14%




