SELECT * FROM customers;

-- Test Atomicity
BEGIN;
INSERT INTO customers (customer_id, first_name, last_name, payment_info) VALUES (10,'Jane', 'Doe', 'Visa 1111');
-- Simulated failure
UPDATE customers SET last_name = 'Smith' WHERE customer_id = 9999; -- Nonexistent ID
COMMIT;

ROLLBACK;

-- ==========================

BEGIN;
INSERT INTO customers (customer_id,first_name, last_name, payment_info) VALUES (12,'Emily', 'Green', 'Visa 7777');
INSERT INTO customers (customer_id,first_name, last_name, payment_info) VALUES (13,'EE', 'Green', 'Visa 7777');
COMMIT;

SELECT * FROM customers;

BEGIN;
INSERT INTO customers (customer_id, first_name, last_name, payment_info) VALUES (14, 'Jack', 'Green', 'Visa 7777');
UPDATE customers SET payment_info = 'Amex 1234' WHERE first_name = 'Jack';
COMMIT;

ROLLBACK;

-- ===============
-- Isolation Level
-- ===============

-- Session 1: Begin transaction
BEGIN;
UPDATE customers SET last_name = 'Taylor' WHERE first_name = 'Alice';

-- Session 2: read before commit
SELECT * FROM customers WHERE first_name = 'Alice'; -- will not see the change

-- Session 1: Commit the change
COMMIT;

-- =============
-- Savepoints
-- ============= 

BEGIN;
INSERT INTO customers (customer_id, first_name, last_name, payment_info) VALUES (15, 'Olivia', 'Brown', 'Visa 3030');

SAVEPOINT before_update;
UPDATE customers SET last_name = 'Smith' WHERE first_name = 'Olivia';

-- Rollback to savepoint
ROLLBACK TO SAVEPOINT before_update;

COMMIT;

-- Verify the result

SELECT * FROM customers WHERE first_name = 'Olivia'; -- Should show original 'Brown'


