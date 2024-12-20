-- ======================================
-- Task 1: Optimize Frequent Queries with Composite Index
-- ======================================

-- Create a composite index on customer_id and category in pets table
CREATE INDEX idx_customer_category ON pets (customer_id, category);

-- Test the optimized query
EXPLAIN SELECT pet_id, nickname FROM pets WHERE customer_id = 1 AND category = 'Dog';

-- ======================================
-- Task 2: Enforce Uniqueness with Unique Index
-- ======================================

-- Ensure unique email addresses in the staff table
CREATE UNIQUE INDEX idx_unique_email_staff ON staff (email);

-- Test the uniqueness
INSERT INTO staff (employee_id, first_name, last_name, email, dob)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '1990-01-01');

-- The following will fail due to the unique constraint
-- INSERT INTO staff (employee_id, first_name, last_name, email, dob)
-- VALUES (2, 'Jane', 'Smith', 'john.doe@example.com', '1995-05-05');

-- ======================================
-- Task 3: Implement a Full-Text Search
-- ======================================

-- Add a full-text index to the notes column in pets table
CREATE FULLTEXT INDEX idx_fulltext_notes ON pets (notes);

-- Test full-text search
SELECT pet_id, nickname FROM pets WHERE MATCH(notes) AGAINST('friendly');

-- ======================================
-- Task 4: Use Partial Index for Conditional Data
-- ======================================

-- Create an index for rows where supervisor_id is not NULL
CREATE INDEX idx_active_staff ON staff (supervisor_id);

-- Test the query using this index
EXPLAIN SELECT first_name, last_name FROM staff WHERE supervisor_id IS NOT NULL;

-- ======================================
-- Task 5: Speed Up Join Queries with Foreign Key Index
-- ======================================

-- Create indexes to optimize the join between visit and pets tables
CREATE INDEX idx_visit_pet_id ON visit (pet_id);
CREATE INDEX idx_pets_pet_id ON pets (pet_id);

-- Test the join query
EXPLAIN SELECT v.visit_id, p.nickname
FROM visit v
JOIN pets p ON v.pet_id = p.pet_id
WHERE v.date = '2024-12-01';

-- ======================================
-- Task 6: Analyze Query Performance with Covering Index
-- ======================================

-- Create a covering index for category, pet_id, and nickname in pets table
CREATE INDEX idx_pet_cover ON pets (category, pet_id, nickname);

-- Test the optimized query
EXPLAIN SELECT pet_id, nickname FROM pets WHERE category = 'Cat';

-- ======================================
-- Task 7: Identify and Remove Redundant Indexes
-- ======================================

-- List all indexes in the customers table
SHOW INDEX FROM customers;

-- Use EXPLAIN to identify unused indexes
EXPLAIN SELECT * FROM customers WHERE customer_id = 10;

-- Drop an unused index (example)
-- DROP INDEX idx_redundant_index ON customers;

-- ======================================
-- Task 8: Use Spatial Index for Geographic Data
-- ======================================

-- Add a POINT column for location in customer_details
ALTER TABLE customer_details ADD location POINT;

-- Create a spatial index for location
CREATE SPATIAL INDEX idx_location ON customer_details (location);

-- Query customers within a region (requires valid POLYGON input)
-- SELECT * FROM customer_details
-- WHERE ST_Within(location, ST_GeomFromText('POLYGON(...)'));

-- ======================================
-- Task 9: Optimize Updates with Indexed Columns
-- ======================================

-- Add an index on customer_id and date in the visit table
CREATE INDEX idx_visit_paid ON visit (customer_id, date);

-- Test the optimized update
EXPLAIN UPDATE visit SET paid = TRUE WHERE customer_id = 1 AND date < '2024-12-01';

-- ======================================
-- Task 10: Benchmark Queries
-- ======================================

-- Disable query caching
SET SESSION query_cache_type = OFF;

-- Run the query without an index
SELECT SQL_NO_CACHE pet_id, nickname FROM pets WHERE category = 'Dog';

-- Add an index and re-run the query
CREATE INDEX idx_category ON pets (category);
SELECT SQL_NO_CACHE pet_id, nickname FROM pets WHERE category = 'Dog';

-- Use EXPLAIN to check index usage
EXPLAIN SELECT SQL_NO_CACHE pet_id, nickname FROM pets WHERE category = 'Dog';