## Using CRUD: Seek, Create, Update, and Destroy

In this activity, you will be utilizing CRUD operations (Create, Read, Update, Destroy) on the provided data.

### Instructions

* Create a new database named `GlobalFirePower` in pgAdmin.

* Create a table by copying the code provided in `schema.sql` into a new query window in pgAdmin. Import the data from `GlobalFirePower.csv` using the Import/Export tool.

* Find the rows that have a `ReservePersonnel` of 0 and remove these rows from the dataset.

* Every country in the world at least deserves one `FighterAircraft`—it only seems fair. Let's add one to each nation that has none.

* Find the [Averages](https://www.w3schools.com/sql/sql_count_avg_sum.asp) for `TotalMilitaryPersonnel`, `TotalAircraftStrength`, `TotalHelicopterStrength`, and `TotalPopulation`, and rename the columns with their designated average.
