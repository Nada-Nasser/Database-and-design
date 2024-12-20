### **1. Single-Column Index**

A single-column index improves queries that filter or sort based on one column.

**Example:** Index on `customer_id` in the `pets` table:

```sql
CREATE INDEX idx_customer_id ON pets (customer_id);
```

**Usage:**  
This index speeds up queries like:

```sql
SELECT * FROM pets WHERE customer_id = 101;
```

---

### **2. Composite Index**

A composite index (multi-column index) includes multiple columns. It is useful for queries involving conditions on multiple columns.

**Example:** Composite index on `customer_id` and `pet_id` in the `pets_staff` table:

```sql
CREATE INDEX idx_customer_pet ON pets_staff (customer_id, pet_id);
```

**Usage:**  
This index optimizes:

```sql
SELECT * FROM pets_staff WHERE customer_id = 101 AND pet_id = 5;
```

**Note:**  
The order of columns matters. Queries filtering by `customer_id` first will benefit most.

---

### **3. Unique Index**

A unique index ensures all values in the indexed column(s) are unique.

**Example:** Unique index on `email` in the `customer_details` table:

```sql
CREATE UNIQUE INDEX idx_unique_email ON customer_details (email);
```

**Usage:**  
Prevents duplicate entries for email addresses:

```sql
INSERT INTO customer_details (customer_id, address, email, phone, dob) 
VALUES (102, '123 Elm St', 'unique@example.com', '123-456-7890', '1990-01-01');
```

---

### **4. Full-Text Index**

A full-text index is designed for efficient text searching.

**Example:** Full-text index on `notes` in the `pets` table:

```sql
CREATE FULLTEXT INDEX idx_fulltext_notes ON pets (notes);
```

**Usage:**  
Optimized for search queries like:

```sql
SELECT * FROM pets WHERE MATCH(notes) AGAINST('friendly');
```

---

### **5. Partial Index**

A partial index is created on a subset of rows, often used in databases like PostgreSQL. (MySQL doesn't directly support partial indexes but can mimic this with expressions.)

**Example (PostgreSQL):** Index only active employees in the `staff` table:

```sql
CREATE INDEX idx_active_staff ON staff (employee_id) WHERE supervisor_id IS NOT NULL;
```

---

### **6. Clustered Index**

In a clustered index, the table's rows are physically sorted to match the index. MySQL uses the primary key as the clustered index for InnoDB tables.

**Example:**  
The `visit_id` column in the `visit` table is the clustered index since it's the primary key:

```sql
CREATE TABLE visit (
  visit_id INT PRIMARY KEY,
  date TIMESTAMP,
  ...
);
```

---

### **7. Covering Index**

A covering index includes all columns needed by a query, avoiding accessing the table itself.

**Example:** Index on `pet_id`, `nickname`, and `category` in the `pets` table:

```sql
CREATE INDEX idx_covering_pet ON pets (pet_id, nickname, category);
```

**Usage:**  
Optimizes:

```sql
SELECT pet_id, nickname, category FROM pets WHERE category = 'Dog';
```

---

### **8. Spatial Index**

For geographic data (if the database supports spatial data types).

**Example:** Spatial index on a `location` column (if added) in the `customer_details` table:

```sql
ALTER TABLE customer_details ADD SPATIAL INDEX idx_location (location);
```

    
