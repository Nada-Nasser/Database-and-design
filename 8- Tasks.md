### **Task 1: Optimize Frequent Queries with Composite Index**

You frequently query pets owned by a customer, filtered by `customer_id` and `category`.

**Task:**  
Optimize the query:

```sql
SELECT pet_id, nickname FROM pets WHERE customer_id = 1 AND category = 'Dog';
```

**Solution:**

1. Create a composite index:
    
    ```sql
    CREATE INDEX idx_customer_category ON pets (customer_id, category);
    ```
    
2. Use `EXPLAIN` to verify index usage:
    
    ```sql
    EXPLAIN SELECT pet_id, nickname FROM pets WHERE customer_id = 1 AND category = 'Dog';
    ```
    

---

### **Task 2: Enforce Uniqueness with Unique Index**

Ensure that no two employees have the same email in the `staff` table.

**Task:**  
Prevent duplicate email entries.

**Solution:**

1. Create a unique index:
    
    ```sql
    CREATE UNIQUE INDEX idx_unique_email_staff ON staff (email);
    ```
    
2. Test the constraint:
    
    ```sql
    INSERT INTO staff (employee_id, first_name, last_name, email, ...) 
    VALUES (1, 'John', 'Doe', 'john.doe@example.com', ...);
    
    INSERT INTO staff (employee_id, first_name, last_name, email, ...) 
    VALUES (2, 'Jane', 'Doe', 'john.doe@example.com', ...);
    -- This second query will fail due to the unique index.
    ```
    

---

### **Task 3: Implement a Full-Text Search**

Allow searching notes in the `pets` table for specific keywords like "friendly" or "aggressive."

**Task:**  
Search the `notes` column efficiently.

**Solution:**

1. Create a full-text index:
    
    ```sql
    CREATE FULLTEXT INDEX idx_fulltext_notes ON pets (notes);
    ```
    
2. Run a full-text search:
    
    ```sql
    SELECT pet_id, nickname FROM pets WHERE MATCH(notes) AGAINST('friendly');
    ```
    

---

### **Task 4: Use Partial Index for Conditional Data**

Optimize queries for active staff (with non-NULL `supervisor_id`).

**Task:**  
Index only active staff in the `staff` table.

**Solution:**  
If using MySQL, mimic partial indexes by filtering queries:

```sql
CREATE INDEX idx_active_staff ON staff (supervisor_id);
```

Use this index in queries:

```sql
SELECT first_name, last_name FROM staff WHERE supervisor_id IS NOT NULL;
```

---

### **Task 5: Speed Up Join Queries with Foreign Key Index**

You often join `visit` and `pets` on `pet_id`. Optimize this join.

**Task:**  
Optimize the following query:

```sql
SELECT v.visit_id, p.nickname 
FROM visit v
JOIN pets p ON v.pet_id = p.pet_id 
WHERE v.date = '2024-12-01';
```

**Solution:**

1. Index the `pet_id` column in both tables:
    
    ```sql
    CREATE INDEX idx_visit_pet_id ON visit (pet_id);
    CREATE INDEX idx_pets_pet_id ON pets (pet_id);
    ```
    
2. Validate with `EXPLAIN`:
    
    ```sql
    EXPLAIN SELECT v.visit_id, p.nickname 
    FROM visit v
    JOIN pets p ON v.pet_id = p.pet_id 
    WHERE v.date = '2024-12-01';
    ```
    

---

### **Task 6: Analyze Query Performance with Covering Index**

Optimize queries that fetch specific columns only.

**Task:**  
Speed up this query:

```sql
SELECT pet_id, nickname FROM pets WHERE category = 'Cat';
```

**Solution:**

1. Create a covering index:
    
    ```sql
    CREATE INDEX idx_pet_cover ON pets (category, pet_id, nickname);
    ```
    
2. Run the query and validate with `EXPLAIN`.

---

### **Task 7: Identify and Remove Redundant Indexes**

Inspect the `customers` table to identify unnecessary indexes.

**Task:**  
Determine if any existing indexes overlap or are unused.

**Solution:**

1. Check all indexes on the `customers` table:
    
    ```sql
    SHOW INDEX FROM customers;
    ```
    
2. Use `EXPLAIN` to find if indexes are used:
    
    ```sql
    EXPLAIN SELECT * FROM customers WHERE customer_id = 10;
    ```
    
3. Drop unused or redundant indexes:
    
    ```sql
    DROP INDEX idx_redundant_index ON customers;
    ```
    

---

### **Task 8: Use Spatial Index for Geographic Data**

Add a `location` column to `customer_details` (e.g., storing coordinates) and optimize location-based queries.

**Task:**  
Optimize queries for customers within a specific region.

**Solution:**

1. Add a `location` column (using `POINT` type if supported):
    
    ```sql
    ALTER TABLE customer_details ADD location POINT;
    ```
    
2. Create a spatial index:
    
    ```sql
    CREATE SPATIAL INDEX idx_location ON customer_details (location);
    ```
    
3. Query using geographic constraints:
    
    ```sql
    SELECT * FROM customer_details 
    WHERE ST_Within(location, ST_GeomFromText('POLYGON(...)'));
    ```
    

---

### **Task 9: Optimize Updates with Indexed Columns**

Minimize the performance impact of frequent updates on `visit`'s `paid` status.

**Task:**  
Optimize this update:

```sql
UPDATE visit SET paid = TRUE WHERE customer_id = 1 AND date < '2024-12-01';
```

**Solution:**

1. Add an index on frequently updated columns:
    
    ```sql
    CREATE INDEX idx_visit_paid ON visit (customer_id, date);
    ```
    
2. Test the update:
    
    ```sql
    UPDATE visit SET paid = TRUE WHERE customer_id = 1 AND date < '2024-12-01';
    ```
    

---

### **Task 10: Benchmark Queries**

Use different indexing strategies to compare query performance.

**Task:**  
Measure query times before and after adding indexes.

**Solution:**

1. Disable query cache for accurate results:
    
    ```sql
    SET SESSION query_cache_type = OFF;
    ```
    
2. Benchmark query without index:
    
    ```sql
    SELECT SQL_NO_CACHE pet_id, nickname FROM pets WHERE category = 'Dog';
    ```
    
3. Add an index and re-run the benchmark:
    
    ```sql
    CREATE INDEX idx_category ON pets (category);
    SELECT SQL_NO_CACHE pet_id, nickname FROM pets WHERE category = 'Dog';
    ```
    
4. Use `EXPLAIN` and `SHOW PROFILES` to analyze performance.

---
### All SQL Scripts 

```sql
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

```

