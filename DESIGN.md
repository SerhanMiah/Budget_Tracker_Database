# Budget Tracker Database

  # 💰 Budget Tracker Database

  **Author:** Serhan Miah  
  **Course:** Harvard CS50 SQL Track  
  **Video Overview:** *[Insert Video URL Here]* 


   ## 📌 Project Overview

  The Budget Tracker Database is a personal finance management system that enables users to track their expenses, income, budgets, savings goals, and recurring financial obligations. Inspired by common personal finance needs and budgeting applications, the project is implemented entirely in SQLite. It serves as a backend database capable of supporting a frontend client or command-line interface in the future.

  This project was built as the final submission for CS50’s Introduction to Databases with SQL. It demonstrates normalized schema design, relational integrity, foreign key constraints, joins, filtering, and aggregation.

  ## Motivation
    
  Personal financial health is a core part of many people’s lives, yet many struggle to stay on top of their budgeting, bills, and savings. While many applications exist for tracking finances, designing such a system from scratch offered an opportunity to deeply explore relational database principles, such as:

  - Managing multiple types of financial records (transactions, recurring payments, budgets).

  - Modeling user behavior and constraints.

  - Building queries that provide real insights (budget vs. actual spend, goal progress).

  - Ensuring data integrity with foreign keys and proper normalization.

  - The goal was to build something useful, scalable, and extensible, while applying what I learned about SQL schema design and query writing.

 ## 📦 Scope

  **Purpose:**  
  The purpose of this database is to empower users to make informed financial decisions by providing tools to monitor spending, plan budgets, and manage recurring financial commitments.

  **Included in Scope:**  
  - Individual users tracking personal finances  
  - Transactions (income and expenses)  
  - Budgets categorized by month  
  - Recurring payments like subscriptions  
  - Savings goals  
  - Payment methods (e.g., bank, card, cash)

  **Outside the Scope:**  
  - Real-time banking API integration  
  - Multi-user or enterprise support  
  - Investment or trading features  
  - User authentication/login system  
  - Multi-currency support

  ---

## ✅ Functional Requirements

  **What Users Can Do:**
  - Add and categorize transactions  
  - Set and track monthly budgets  
  - Monitor spending vs. budget  
  - Manage recurring payments (e.g., subscriptions)  
  - Define and track savings goals  
  - Record payment methods used

  **What Users Cannot Do:**
  - Sync directly with banks or credit cards  
  - Use multiple currencies  
  - Authenticate into personal accounts  
  - Analyze investments or predict future spending

  ---
  ## 🧱 Representation

  ### Entities

  The database includes the following entities:

  - `Users`: Stores information about individuals using the tracker  
  - `Transactions`: Records of income or expense entries  
  - `Categories`: Classification of transactions (e.g., Rent, Salary)  
  - `Budgets`: Monthly allocated amounts per category  
  - `Contracts`: Ongoing commitments like rent or subscriptions  
  - `Recurring_Transactions`: Automatically repeating transactions  
  - `Goals`: User-defined savings targets  
  - `Payment_Methods`: Source of payments (e.g., Credit Card, Bank Transfer)

  ## 🧩 Database Schema

  ### Tables and Key Fields

  | Table                | Key Fields                                                                 |
  |----------------------|----------------------------------------------------------------------------|
  | Users              | id, name                                                               |
  | Transactions       | id, user_id, category_id, amount, description, transaction_date |
  | Categories         | id, name, type (income or expense), description               |
  | Budgets            | id, user_id, category_id, month, amount                         |
  | Contracts          | id, user_id, category_id, name, start_date, end_date, monthly_amount, description |
  | RecurringTransactions | id, user_id, category_id, amount, frequency, start_date    |
  | Goals              | id, user_id, category_id, name, target_amount, current_amount, deadline |
  | PaymentMethods     | id, user_id, name, type                                           |

  - **Primary keys** are integers.
  - **Foreign keys** maintain data integrity between tables (e.g., user_id, category_id).


  **Types and Constraints:**  
  - `INTEGER PRIMARY KEY` for unique identifiers  
  - `TEXT` for names and descriptions  
  - `REAL` for financial values  
  - `DATE` or `TEXT` (formatted as YYYY-MM-DD) for dates  
  - `CHECK` constraints to ensure valid types (e.g., only "income" or "expense")

  ### Relationships

  - A `User` can have many `Transactions`, `Budgets`, `Contracts`, `Recurring_Transactions`, `Goals`, and `Payment_Methods`.  
  - Every `Transaction`, `Budget`, and `Contract` is linked to a `Category`.  
  - Foreign keys ensure relational integrity across the database.

I have attached a Entity Relationship Diagram created using mermaid.js

**Entity Relationship Diagram:**  
![ER Diagram](EDR_budget_tracker.png)

## ⚙️ Optimizations

  **Indexes & Views:**
  - Indexes were added on foreign keys (e.g., `user_id`, `category_id`) for faster joins and queries.
  These optimizations ensure smooth performance even as the database scales with additional data.

  ---

  ## 🚫 Limitations

  - **No Real-Time Sync:** Users must enter all data manually.
  - **No Multi-User Accounts:** Each user is isolated; no support for shared accounts.
  - **No Forecasting:** Budgeting is based on existing data only, with no predictive features.
  - **Not Designed for Businesses:** This tool is optimized for individuals, not for business accounting or complex financial models.

  ---

  ## ⚙️ Getting Started

  # 🧾 SQLite Setup Guide

  This guide walks you through setting up and interacting with the **Budget Tracker Database** using SQLite.

  ---

  ## 1. Launch SQLite

  Open a terminal and run:

  ```bash
  sqlite3 budget.db
  ```

  This opens or creates the `budget.db` SQLite database file.

  ---

  ## 2. Insert Sample Data

  Here are some example SQL statements to populate the database manually:

  ```sql
  -- Insert a user
  INSERT INTO Users (name) VALUES ('Serhan Miah');

  -- Insert a category
  INSERT INTO Categories (name, type, description)
  VALUES ('Groceries', 'expense', 'Weekly grocery shopping');

  -- Insert a transaction
  INSERT INTO Transactions (user_id, category_id, amount, description, transaction_date)
  VALUES (1, 1, 150.00, 'Grocery shopping at local store', '2025-05-12');

  -- Insert a budget
  INSERT INTO Budgets (user_id, category_id, month, amount)
  VALUES (1, 1, '2025-05', 200.00);

  -- Insert a contract/subscription
  INSERT INTO Contracts (user_id, category_id, name, start_date, end_date, monthly_amount, description)
  VALUES (1, 2, 'Streaming Service Subscription', '2025-01-01', '2025-12-31', 15.00, 'Monthly subscription for streaming service');
  ```

  ---

  ## 3. Load Predefined Data

  To populate the database using a file like `seed.sql`, use:

  ```bash
  .read seed.sql
  ```

  This will execute all SQL statements in `seed.sql`.

  ---

  ## 4. Load and Run Queries

  To execute predefined queries from a file (e.g., `queries.sql`):

  ```bash
  .mode box
  .read queries.sql
  ```

  Using `.mode box` improves output formatting for better readability.

  ---

  ## 5. View Data in Tables

  Run SQL queries to inspect data in your tables:

  ```sql
  SELECT * FROM Users;
  SELECT * FROM Categories;
  SELECT * FROM Transactions;
  SELECT * FROM Budgets;
  SELECT * FROM Contracts;
  SELECT * FROM RecurringTransactions;
  SELECT * FROM Goals;
  SELECT * FROM PaymentMethods;
  ```

  ---


  ## 6. Drop All Tables (Reset Database)
If you want to reset your database schema, you can drop all tables in a dependency-safe order like this:


  ```sql
DROP TABLE IF EXISTS RecurringTransactions;
DROP TABLE IF EXISTS Goals;
DROP TABLE IF EXISTS Contracts;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Budgets;
DROP TABLE IF EXISTS PaymentMethods;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;
  ```


  ## 7. Exit SQLite

  When you're done, type:

  ```bash
  .quit
  ```

  ---


  ## 🐍 Optional: Use Python to Insert Data

  Example Python script to interact with the database:

  ```python
  import sqlite3

  # Connect to SQLite database
  conn = sqlite3.connect('budget.db')
  cursor = conn.cursor()

  # Insert a new user
  cursor.execute("INSERT INTO Users (name) VALUES ('Serhan Miah')")

  # Commit and close connection
  conn.commit()
  conn.close()
  ```

  ---

  ## 📈 Future Improvements (Optional Ideas)

  - 🔐 Add user authentication
  - 🌐 Build a web interface with Flask or Django
  - 💹 Add investment and prediction modules
  - 🌍 Add multi-currency and exchange rate support
  - 📱 Connect to mobile budgeting apps or banks via API

  ---

  ## 🎓 Credits

  Created as part of the [Harvard CS50 SQL Track](https://cs50.harvard.edu/sql/)  
  Author: Serhan Miah  
  Date: May 2025

