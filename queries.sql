-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

  -- Run SQL queries to inspect data in your tables:
-- 
.mode box


-- READ
-- sql - SELECTS all the tables in the database
  SELECT * FROM Users;
  SELECT * FROM Categories;
  SELECT * FROM Transactions;
  SELECT * FROM Budgets;
  SELECT * FROM Contracts;
  SELECT * FROM recurring_transactions;
  SELECT * FROM Goals;
  SELECT * FROM payment_methods;


-- SELECT Queries: 
-- Total income
-- Showing total income and expenses group by type.
SELECT c.name AS transaction_type, -- name of transaction e.g rent, salary 
      SUM(t.amount) AS total_amount -- total amount of transaction 
FROM transactions t
JOIN categories c ON t.category_id = c.id
WHERE t.user_id = 1
    AND strftime('%Y-%m', t.transaction_date) = strftime('%Y-%m', 'now') 
GROUP BY c.type;


-- Monthly Savings (Income - Expenses) for the Past 6 Months
SELECT
    strftime('%Y-%m', t.transaction_date) AS month,
    SUM(CASE WHEN c.type = 'income' THEN t.amount ELSE 0 END) AS total_income,
    ABS(SUM(CASE WHEN c.type = 'expense' THEN t.amount ELSE 0 END)) AS total_expenses,
    SUM(t.amount) AS net_savings
FROM transactions t
JOIN categories c ON t.category_id = c.id
WHERE t.user_id = 1
  AND t.transaction_date >= DATE('now', '-6 months')
GROUP BY month
ORDER BY month DESC;


-- Top 5 Largest Expenses
SELECT
    t.id AS transaction_id,
    c.name AS category,
    ABS(t.amount) AS expense_amount,
    t.transaction_date
FROM transactions t
JOIN categories c ON t.category_id = c.id
WHERE t.user_id = 1
  AND c.type = 'expense'
ORDER BY ABS(t.amount) DESC
LIMIT 5;

-- Select Budget Categories for a Specific Month
SELECT
    c.name AS category,
    b.amount AS budgeted,
    ABS(SUM(t.amount)) AS spent
FROM budgets b
JOIN categories c ON b.category_id = c.id
JOIN transactions t
    ON t.category_id = b.category_id
    AND t.user_id = b.user_id
    AND strftime('%Y-%m', t.transaction_date) = b.month
WHERE b.user_id = 1
  AND b.month = strftime('%Y-%m', 'now')
  AND c.type = 'expense'
GROUP BY c.name, b.amount
HAVING ABS(SUM(t.amount)) > b.amount;


-- Show Each Expense and Its Associated Payment Method 
SELECT
    t.id AS transaction_id,
    c.name AS category,
    ABS(t.amount) AS amount,
    t.transaction_date,
    pm.name AS payment_method,
    pm.type AS payment_type
FROM transactions t
JOIN categories c ON t.category_id = c.id
LEFT JOIN payment_methods pm ON t.payment_method_id = pm.id
WHERE t.user_id = 1
  AND c.type = 'expense'
ORDER BY t.transaction_date DESC;

-- All Transactions This Month
SELECT
    t.id AS transaction_id,
    c.name AS category,
    c.type AS transaction_type,
    t.amount,
    t.transaction_date,
    pm.name AS payment_method
FROM transactions t
JOIN categories c ON t.category_id = c.id
LEFT JOIN payment_methods pm ON t.payment_method_id = pm.id
WHERE t.user_id = 1
  AND strftime('%Y-%m', t.transaction_date) = strftime('%Y-%m', 'now')
ORDER BY t.transaction_date DESC;


-- CRUD 
-- CREATE, READ, UPDATE, DELETE

INSERT INTO transactions (
    user_id,
    category_id,
    amount,
    transaction_date,
    payment_method_id,
    description
) VALUES (
    1,              -- user_id
    2,              -- category_id (must exist in categories)
    45.99,         -- amount
    DATE('now'),    -- transaction_date
    1,              -- payment_method_id (must exist in payment_methods or be NULL)
    'Grocery shopping'
);


-- ==============================================
-- 9. Update Budget for a Category in a Given Month
UPDATE budgets
SET amount = :new_amount
WHERE user_id = :user_id
  AND category_id = :category_id
  AND month = :month;

-- ==============================================
-- 10. Delete a Transaction
DELETE FROM transactions
WHERE user_id = :user_id
  AND id = :transaction_id;

-- ==============================================
-- 11. Add New Monthly Budget
INSERT INTO budgets (
    user_id,
    category_id,
    amount,
    month
) VALUES (
    1,             -- user_id
    2,             -- category_id (must exist)
    200.00,        -- amount
    strftime('%Y-%m', 'now')  -- current month
);


-- ==============================================
-- 12. Update Payment Method Info
UPDATE payment_methods
SET name = :new_name,
    type = :new_type
WHERE id = :payment_method_id;

