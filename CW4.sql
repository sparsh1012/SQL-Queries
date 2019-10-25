-- 1. How many classes are held in room 3346?
-- TRANSLATION: select the count of classes from classes column where the room number is 3346
-- CLEAN UP: select the count of classes where room number is 3346
USE SchoolSchedulingExample;
SELECT 
    COUNT(*)
FROM
    Classes
WHERE
    ClassRoomID = 3346;

-- 2. Calculate the current average  raw score and handicap for each bowler.
-- TRANSLATION: concatenate bowler first name, bowler last name as 'Bowler Name' and select bowler name,bowler ID, average raw score,average
-- handicap score from bowlers table joined with bowler_scores table on bowlers table bowler ID equals bowler_score table bowler ID  and group it
-- by bowler first name
-- CLEAN UP: concatenate bowler first name, bowler last name as 'Bowler Name',select bowler name,bowler ID, average raw score,average
-- handicap score from bowlers table join bowler_scores table on bowlers.bowler ID=bowler_score.bowler ID  group by
-- bowlerfirstname
use bowlingleagueexample;
SELECT DISTINCT
    CONCAT(b.BowlerFirstName, ' ', b.BowlerLastName) AS 'Bowler Name',
    b.BowlerID,
    ROUND(AVG(bs.RawScore), 2) AS 'Average Raw Score',
    ROUND(AVG(bs.HandiCapScore), 2) AS 'Average HandiCap Score'
FROM
    bowlers b
        JOIN
    bowler_scores bs ON b.BowlerID = bs.BowlerID
GROUP BY b.BowlerFirstName
ORDER BY b.BowlerFirstName;


-- 3. List all meat ingredients and the count of recipes that include each one.
-- TRANSLATION: select ingredient ID,count of recipe ID from ingredients table left joined with recipe_ingredients table on ingredients
-- table ingredientID equals recipe_ingredients table ingredientID left joined with ingredient_classes table on ingredients table 
-- ingredientID equals ingredient_class table ingredientID where Ingredients Class table Ingredient class description contains the word 'meat'

-- CLEAN UP:select Ingredient ID,count(Recipe ID) from ingredients table left join recipe_ingredients table on ingredients.ingredientID=
-- recipe_ingredients.ingredientID left join ingredient_classes on ingredients.ingredientID=ingredient_class.ingredientID
-- where ingredient_class.IngredientClassDescription like 'meat'.
USE RecipesExample;

SELECT 
    I.IngredientName, COUNT(DISTINCT RI.RecipeID) RecipeCount
FROM
    Ingredients I
        JOIN
    Ingredient_Classes IC ON I.IngredientClassID = IC.IngredientClassID
        JOIN
    Recipe_Ingredients RI ON RI.IngredientID = I.IngredientID
WHERE
    IC.IngredientClassDescription = 'Meat'
GROUP BY I.IngredientName
ORDER BY 1 , 2;


-- 4. Show me the subject categories that have fewer than three full professors teaching that subject.
-- TRANSLATION: select CategoryDescription,count of staffID from faculty table joined with faculty_subjects table on faculty table
-- staffID equals faculty_subjects table StaffID joined with subjects table on faculty_subjects table SubjectID equals subjects table
-- SubjectID joined with Categories table on Subjects table CategoryID equals Categories table Category ID
-- where Faculty table Status column equals 'Full Time' and Faculty Title contains the word 'Professor' 
-- group by Category table CategoryDescription and having count of Faculty table StaffID less than 3 

-- CLEAN UP: select CategoryDescription,count(staffID) from faculty join faculty_subjects on faculty.StaffID=faculty_subjects.StaffID 
-- join Subjects on faculty_subjects.SubjectID=subjects.SubjectID join Categories on Subjects.CategoryID=Categories.Category ID
-- where Faculty.Status='Full Time' and Faculty.Title like %'Professor'% 
-- group by Category.CategoryDescription having count(Faculty.StaffID)<3 

USE SchoolSchedulingExample;

SELECT 
    S.SubjectCode, S.SubjectName, COUNT(F.StaffID) FacultyCount
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

-- 5. For what class of recipe do I have two or more recipes?
-- get recipes and classes they belong to
-- get count of recipe for each recipe class
-- retain those recipes classes that have recipe count higher than 1
use recipesexample;
SELECT 
    COUNT(R.RecipeID) AS RecipeCount, RC.RecipeClassDescription
FROM
    recipes R
        JOIN
    recipe_classes RC ON R.RecipeClassID = RC.RecipeClassID
GROUP BY R.RecipeClassID
HAVING RecipeCount >= 2;

