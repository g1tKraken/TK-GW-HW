-- Using CRUD: Seek, Create, Update, and Destroy
-- In this activity, you will be utilizing CRUD operations (Create, Read, Update, Destroy)
-- on the provided data.

-- Instructions

-- Create a new database named GlobalFirePower in pgAdmin.
-- Create a table by copying the code provided in schema.sql into a new query window in pgAdmin. Import the data from GlobalFirePower.csv using the Import/Export tool.

-- Find the rows that have a ReservePersonnel of 0 and remove these rows from the dataset.

DELETE FROM firepower
WHERE ReservePersonnel = 0

-- Every country in the world at least deserves one FighterAircraft—it only seems fair.
-- Let's add one to each nation that has none.
UPDATE firepower
SET fighteraircraft = 1
WHERE fighteraircraft = 0

-- Find the Averages for TotalMilitaryPersonnel, TotalAircraftStrength, TotalHelicopterStrength, and TotalPopulation, and rename the columns with their designated average.

SELECT  ROUND(AVG(TotalMilitaryPersonnel)) AS "Average Military Pers Force Size",
        ROUND(AVG(TotalAircraftStrength)) AS "Average Aircraft Force Size",
        ROUND(AVG(TotalHelicopterStrength)) AS "Average Helo Force Size",
        ROUND(AVG(TotalPopulation)) AS "Average Population Size"
FROM firepower