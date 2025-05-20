-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it


-- Creating the database schema 
-- Table will need a way to identify user. 
-- CREATING

CREATE TABLE users (
  id INTEGER,
  name TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);


-- Categories Table
-- Store incomes or expenses categories table - e.g. Salary, bills
CREATE TABLE categories (
  id INTEGER,
  name TEXT NOT NULL,
  type TEXT CHECK(type IN ('income', 'expense')) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

-- ===============================
-- BUDGETS TABLE
-- Table for budget per category, linked by user and category
CREATE TABLE budgets (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  month TEXT NOT NULL, 
  amount REAL NOT NULL CHECK(amount >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- ===============================
-- TRANSACTIONS TABLE
-- Stores financial transactions (income or expense).
CREATE TABLE transactions (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  payment_method_id INTEGER,  -- Link to payment method used (optional)
  amount REAL NOT NULL CHECK(amount >= 0),
  description TEXT,
  transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
  payment_date DATE,  -- Optional: actual payment date
  due_date DATE,      -- Optional: for scheduled or expected payments
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES categories(id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id)
);

-- ===============================
-- CONTRACTS TABLE
-- table to store the financial contract this could be 24 month, 12 month etc, linked by user and category by id. 
CREATE TABLE contracts (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE, 
  monthly_amount REAL NOT NULL CHECK(monthly_amount >= 0),
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- GOALS TABLE
-- Stores user financial goals (e.g., save £2000, pay off £500 debt).
CREATE TABLE goals (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  target_amount REAL NOT NULL CHECK(target_amount >= 0),
  current_amount REAL DEFAULT 0 CHECK(current_amount >= 0),
  deadline DATE,
  category_id INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- ===============================
-- RECURRING TRANSACTIONS TABLE
-- Stores transactions that occur on a regular basis.
CREATE TABLE recurring_transactions (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  amount REAL NOT NULL,
  frequency TEXT CHECK(frequency IN ('daily', 'weekly', 'monthly', 'yearly')) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE, 
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- PAYMENT METHODS TABLE
-- Stores different ways a user can pay (e.g., credit card, cash, Monzo).
CREATE TABLE payment_methods (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  name TEXT NOT NULL, -- E.g., 'Barclays Visa', 'Cash', 'Monzo'
  type TEXT CHECK(type IN ('cash', 'credit', 'direct debit', 'bank transfer', 'crypto')) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);


-- INDEXES FOR PERFORMANCE
-- These indexes improve query speed for frequent queries (e.g., filtering by date).
CREATE INDEX idx_transactions_user_date ON transactions(user_id, transaction_date);
CREATE INDEX idx_budgets_user_month ON budgets(user_id, month);
CREATE INDEX idx_recurring_user_start ON recurring_transactions(user_id, start_date);



