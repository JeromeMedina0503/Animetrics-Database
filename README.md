# Animetrics Database: SQL Data Modeling & Analytics

## 📌 Overview
Animetrics is a custom-built relational database designed to categorize, manage, and analyze extensive datasets of anime and manga properties. This project demonstrates end-to-end data processing, from architecting the initial entity-relationship models to executing complex SQL queries to extract meaningful insights. 

It serves as a practical application of data engineering and analytics principles, utilizing a lightweight SQLite database integrated with a Java backend.

## 🛠️ Tools & Technologies
* **Database Management:** SQLite, DB Browser for SQLite
* **Languages:** SQL, Java (JDBC integration)
* **Core Competencies:** Relational Data Modeling, Database Normalization, Automated Data Pipelines, CRUD Operations, Data Aggregation

## 📂 Repository Structure
* **`database_setup.sql`**: The foundational script containing all `CREATE TABLE` and `INSERT` statements used to build the schema and populate the initial datasets.
* **`analytical_queries.sql`**: A collection of complex SQL scripts (utilizing multi-table JOINs, filtering, and aggregation) designed to answer specific business questions, such as identifying top-performing animation studios and comparing media ratings across decades.
* **`Animetrics ERD.png`**: The Entity-Relationship Diagram visualizing the database architecture, complex cardinalities, and primary/foreign key mappings.
* **`AnimetricsApp/src/AnimetricsApp.java`**: The Java source code demonstrating how the database connects to a backend application via JDBC to automate data entry and updates.
* **`animetrics.db`**: The compiled SQLite database file.

## 💡 Key SQL Insights Extracted
To analyze the dataset effectively, several targeted queries were developed to evaluate:
1. **Top Performers:** Aggregating average ratings across all properties produced by each studio to rank top performers.
2. **Media Comparisons:** Calculating and comparing global average ratings between anime and manga formats.
3. **Targeted Filtering:** Retrieving properties created by specific authors within strict time frames (e.g., 1990s releases).
4. **Volume Analysis:** Identifying expansive manga series and cross-referencing their anime adaptation status.

## 🚀 How to Run
1. Clone this repository to your local machine.
2. Open the `animetrics.db` file using DB Browser for SQLite to view the table structures and raw data.
3. Execute the scripts within `analytical_queries.sql` inside your SQL environment to view the generated insights.
4. To explore the backend integration, compile the Java source files in your preferred IDE and ensure the SQLite JDBC driver is added to your build path.

---
*Created by Jerome Medina* | [LinkedIn](https://linkedin.com/in/jeromemedina)
