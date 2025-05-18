-- ========================================
-- SAMPLE SEEDING DATA FOR BUDGET TRACKER DATABASE
-- ========================================

-- =================
-- USERS
INSERT INTO users (id, name) VALUES
(1, 'Serhan');

-- =================
-- CATEGORIES
-- Income categories
INSERT INTO categories (id, name, type, description) VALUES
(1, 'Salary', 'income', 'Monthly salary from full-time job'),

-- Expense categories
(2, 'Rent', 'expense', 'Monthly rent payment for accommodation'),
(3, 'Phone Contract', 'expense', 'Monthly mobile contract'),
(4, 'Groceries', 'expense', 'Food, snacks, and other essentials'),
(5, 'Streaming Services', 'expense', 'Netflix & Spotify combo'),
(6, 'Debt Repayment', 'expense', 'Monthly credit card or loan payments');

-- =================
-- BUDGETS
INSERT INTO budgets (id, user_id, category_id, month, amount) VALUES
(1, 1, 2, '2025-05', 1200),   -- Rent
(2, 1, 4, '2025-05', 300);    -- Groceries

-- =================
-- PAYMENT METHODS
INSERT INTO payment_methods (id, user_id, name, type) VALUES
(1, 1, 'Barclays Visa', 'credit'),
(2, 1, 'Monzo', 'bank transfer');

-- =================
-- TRANSACTIONS
-- =================
INSERT INTO transactions (id, user_id, category_id, amount, description, transaction_date, payment_method_id) VALUES
-- Income
(1, 1, 1, 3000, 'Salary for May', '2025-05-01', 2),  -- Monzo

-- Expense
(2, 1, 2, 1200, 'Paid Rent - May', '2025-05-05', 2),     -- Monzo
(3, 1, 4, 185, 'Groceries - Lidl and Aldi', '2025-05-07', 2), -- Monzo
(4, 1, 3, 45, 'O2 Mobile - May bill', '2025-05-08', 1),        -- Barclays Visa
(5, 1, 5, 28, 'Netflix & Spotify combo', '2025-05-09', 1),     -- Barclays Visa
(6, 1, 6, 400, 'Barclays credit card payment', '2025-05-10', 2); -- Monzo

-- =================
-- CONTRACTS
-- =================
INSERT INTO contracts (id, user_id, category_id, name, start_date, end_date, monthly_amount, description) VALUES
(1, 1, 3, 'iPhone 13 - O2 Plan', '2023-01-01', '2026-01-01', 36, '24-month contract for mobile phone'),
(2, 1, 5, 'Netflix Premium', '2022-01-01', NULL, 15, 'Streaming movies and TV'),
(3, 1, 5, 'Spotify Premium', '2021-06-01', NULL, 13, 'Music subscription service');

-- =================
-- GOALS
-- =================
INSERT INTO goals (id, user_id, name, target_amount, current_amount, deadline, category_id) VALUES
(1, 1, 'Pay off Credit Card Debt', 2000, 800, '2025-12-31', 6);

-- =============================
-- RECURRING TRANSACTIONS
-- =============================
INSERT INTO recurring_transactions (id, user_id, category_id, amount, frequency, start_date) VALUES
(1, 1, 3, 45, 'monthly', '2023-01-01'),   -- Phone Bill
(2, 1, 5, 28, 'monthly', '2022-01-01'),   -- Streaming Bundle
(3, 1, 6, 400, 'monthly', '2025-01-01');  -- Debt Repayment


-- Drop all tables in dependency-safe order
-- DROP TABLE IF EXISTS recurring_transactions;
-- DROP TABLE IF EXISTS goals;
-- DROP TABLE IF EXISTS contracts;
-- DROP TABLE IF EXISTS transactions;
-- DROP TABLE IF EXISTS budgets;
-- DROP TABLE IF EXISTS payment_methods;
-- DROP TABLE IF EXISTS categories;
-- DROP TABLE IF EXISTS users;

