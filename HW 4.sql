-- 1. “List customers with no bookings.”
-- TRANSLATION: select Customer Name from
-- customers table left outer joined with engagements table on CustomerID
-- where engagements table EngagementNumber is null

-- CLEAN UP: select concat (customers.CustFirstName,' ',customers.CustLastName) as 'Customer Name' from
-- customers left outer join engagements on customers.CustomerID= engagements.CustomerID
-- where engagements.EngagementNumber is null

use entertainmentagencyexample;
select concat (c.CustFirstName,' ',c.CustLastName) as 'Customer Name'
from  customers c left outer join engagements e on c.CustomerID=e.CustomerID
where e.EngagementNumber is null;

-- (4) “List customers who have booked entertainers who play country or country rock.”

-- TRANSLATION
-- SELECT DISTINCT Customer Name FROM Customers table INNER JOINED with Engagements ON CustomerID
-- WHERE CustomerID is IN (SELECT CustomerID
-- FROM Engagements table INNER JOINED with Entertainers table ON EntertainerID
--  INNER JOINED with Entertainer_Styles table ON EntertainerID
--  INNER JOINED with Musical_Styles table ON StyleID
--  WHERE StyleName is either country or country rock)

-- CLEAN UP
-- SELECT DISTINCT CONCAT(C.CustFirstName, ' ', C.CustLastName) AS 'Customer Name'
-- FROM Customers C INNER JOIN Engagements E ON C.CustomerID = E.CustomerID
-- WHERE C.CustomerID IN (SELECT E.CustomerID
-- FROM Engagements E INNER JOIN Entertainers Ent ON E.EntertainerID = Ent.EntertainerID
--  INNER JOIN Entertainer_Styles EntStyles ON E.EntertainerID = EntStyles.EntertainerID
--  INNER JOIN Musical_Styles MS ON EntStyles.StyleID = MS.StyleID
--  WHERE StyleName REGEXP '^country|country rock')

USE EntertainmentAgencyExample;
SELECT DISTINCT CONCAT(C.CustFirstName, ' ', C.CustLastName) AS 'Customer Name'
FROM Customers C INNER JOIN Engagements E ON C.CustomerID = E.CustomerID
WHERE C.CustomerID IN (SELECT E.CustomerID
FROM Engagements E INNER JOIN Entertainers Ent ON E.EntertainerID = Ent.EntertainerID
 INNER JOIN Entertainer_Styles EntStyles ON E.EntertainerID = EntStyles.EntertainerID
 INNER JOIN Musical_Styles MS ON EntStyles.StyleID = MS.StyleID
 WHERE StyleName REGEXP '^country|country rock');
 
 -- (5) Display students enrolled in a class on Tuesday

-- TRANSLATION
-- SELECT DISTINCT Student Name
-- FROM Students table INNER JOINED with Student_Schedules table ON StudentID
-- WHERE ClassID IN (SELECT ClassID
-- FROM Classes table WHERE TuesdaySchedule equals 1)

-- CLEAN UP
-- SELECT DISTINCT CONCAT(S.StudFirstName, " ", S.StudLastName) AS 'Student Name'
-- FROM Students S INNER JOIN Student_Schedules SS ON S.StudentID = SS.StudentID
-- WHERE ClassID IN (SELECT ClassID
-- FROM Classes WHERE TuesdaySchedule = 1)
 
 USE SchoolSchedulingExample;
 SELECT DISTINCT CONCAT(S.StudFirstName, " ", S.StudLastName) AS 'Student Name'
 FROM Students S INNER JOIN Student_Schedules SS ON S.StudentID = SS.StudentID
 WHERE ClassID IN (SELECT ClassID
 FROM Classes WHERE TuesdaySchedule = 1 /* AND ClassStatus = 1*/ );
 
-- (6) “List the ingredients that are used in some recipe where the measurement amount in the recipe is not the default measurement amount.”

-- TRANSLATION
-- SELECT IngredientName, MeasureAmountID, RecipeTitle AND MeasureAmountID
-- FROM Ingredients table INNER JOINED with Recipe_Ingredients table ON IngredientID
-- INNER JOINED with Recipes table ON RecipeID
-- WHERE Recipe_Ingredient's MeasureAmountID is not same as Ingrediuent's MeasureAmountID
-- ORDER BY 1, 3

-- CLEAN UP
-- SELECT I.IngredientName, I.MeasureAmountID, R.RecipeTitle, RI.MeasureAmountID
-- FROM Ingredients I INNER JOIN Recipe_Ingredients RI ON I.IngredientID = RI.IngredientID
-- INNER JOIN Recipes R ON RI.RecipeID = R.RecipeID
-- WHERE I.MeasureAmountID <> RI.MeasureAmountID
-- ORDER BY 1, 3

USE RecipesExample;
SELECT I.IngredientName, I.MeasureAmountID, R.RecipeTitle, RI.MeasureAmountID
FROM Ingredients I INNER JOIN Recipe_Ingredients RI ON I.IngredientID = RI.IngredientID
INNER JOIN Recipes R ON RI.RecipeID = R.RecipeID
WHERE I.MeasureAmountID <> RI.MeasureAmountID
ORDER BY 1, 3;


-- (7) “List all vendors and the count of products sold by each.” (use a subquery)

-- TRANSLATION
-- SELECT VendName,
--  (SELECT Count(ProductNumber) FROM product_vendors table WHERE product_vendors's VendorID equals Vendor's V.VendorID)
-- FROM Vendors table
-- ORDER BY VendName

-- CLEAN UP
-- SELECT V.VendName,
--  (SELECT count(pv.ProductNumber) as 'Total Product Count' FROM product_vendors PV WHERE PV.VendorID = V.VendorID)
-- FROM Vendors V
-- ORDER BY 1

USE salesordersexample;
SELECT V.VendName,
 (SELECT count(pv.ProductNumber) as 'Total Product Count' FROM product_vendors PV WHERE PV.VendorID = V.VendorID)
FROM Vendors V
ORDER BY 1;

-- (8) List each staff member and the count of classes each is scheduled to teach.

-- TRANSLATION
-- SELECT Staff Name, StaffID, COUNT(fc.ClassID)
-- FROM staff table RIGHT OUTER JOINED with faculty_classes table ON s.StaffID equals fc.StaffID
-- GROUP BY staff table StaffID ORDER BY Staff Name

-- CLEAN UP
-- SELECT CONCAT(s.StfFirstName, ' ', s.StfLastName) AS 'Staff Name',
-- s.StaffID, COUNT(fc.ClassID) AS 'Total Classes'
-- FROM staff s RIGHT OUTER JOIN faculty_classes fc ON s.StaffID = fc.StaffID
-- GROUP BY s.StaffID ORDER BY 1

use schoolschedulingexample;
SELECT 
    CONCAT(s.StfFirstName, ' ', s.StfLastName) AS 'Staff Name',
    s.StaffID,
    COUNT(fc.ClassID) AS 'Total Classes'
FROM
    staff s
        RIGHT OUTER JOIN
    faculty_classes fc ON s.StaffID = fc.StaffID
GROUP BY s.StaffID
ORDER BY 1;

 -- (9) “Show me the subject categories that have fewer than three full professors teaching that subject.”
 
 -- TRANSLATION
 -- SELECT SubjectCode, SubjectName, COUNT(F.StaffID)
 -- FROM faculty table JOINED with faculty_subjects table ON StaffID
 -- JOINED with subjects ON SubjectID table
 -- WHERE Title equals 'Professor' AND Status equals 'Full Time'
 -- GROUPED BY SubjectCode AND SubjectName
 -- HAVING count of Faculty less than three

 -- CLEAN UP
 -- SELECT S.SubjectCode, S.SubjectName, COUNT(F.StaffID) as FacultyCount
 -- FROM faculty F JOIN faculty_subjects FS ON F.StaffID = FS.StaffID
 -- JOIN subjects S ON FS.SubjectID = S.SubjectID
 -- WHERE F.Title = 'Professor' AND F.Status = 'Full Time'
 -- GROUP BY S.SubjectCode ,S.SubjectName
 -- HAVING FacultyCount < 3

USE SchoolSchedulingExample;
SELECT 
    S.SubjectCode, S.SubjectName, COUNT(F.StaffID) as FacultyCount
FROM
    faculty F
        JOIN
    faculty_subjects FS ON F.StaffID = FS.StaffID
        JOIN
    subjects S ON FS.SubjectID = S.SubjectID
WHERE
    F.Title = 'Professor'
        AND F.Status = 'Full Time'
GROUP BY S.SubjectCode , S.SubjectName
HAVING FacultyCount < 3;

-- (10) List the last name and first name of every bowler whose average raw score is greater than or equal to 
-- the overall average score.

-- TRANSLATION
-- select Bowler Name, Bowler's Average Rawscore from
-- bowlers table joined with bowler_scores table on BowlerID 
-- grouped by BowlerID
-- having Bowler's Average Rawscore greater than or equal to (select Total Average RawScore from bowler_scores table)
-- ORDER BY bowlers table Bowler name

-- CLEAN UP
-- select concat(b.BowlerLastName,' ',b.BowlerFirstName) as 'Bowler Name',round(avg(bs.Rawscore),2) as avgrawscore from
-- bowlers b join bowler_scores bs on b.BowlerID=bs.BowlerID group by b.BowlerID
-- having avgrawscore>=(select avg(RawScore) from bowler_scores)
-- ORDER BY 1

use bowlingleagueexample;
select concat(b.BowlerLastName,' ',b.BowlerFirstName) as 'Bowler Name',round(avg(bs.Rawscore),2) as avgrawscore from
bowlers b join bowler_scores bs on b.BowlerID=bs.BowlerID group by b.BowlerID
having avgrawscore>=(select avg(RawScore) from bowler_scores)
ORDER BY 1;

-- (11) For what class of recipe do I have two or more recipes?

-- TRANSLATION
-- SELECT COUNT(R.RecipeID), RecipeClassDescription
-- FROM recipes table JOINED with recipe_classes table ON RecipeClassID
-- GROUPED BY RecipeClassID HAVING RecipeCount greater than or equal to 2

-- CLEAN UP
-- SELECT COUNT(R.RecipeID) AS RecipeCount, RC.RecipeClassDescription
-- FROM recipes R JOIN recipe_classes RC ON R.RecipeClassID = RC.RecipeClassID
-- GROUP BY R.RecipeClassID HAVING RecipeCount >= 2

use recipesexample;
SELECT 
    COUNT(R.RecipeID) AS RecipeCount, RC.RecipeClassDescription
FROM
    recipes R
        JOIN
    recipe_classes RC ON R.RecipeClassID = RC.RecipeClassID
GROUP BY R.RecipeClassID
HAVING RecipeCount >= 2;