### **1. Basic Queries**

- Retrieve data using `SELECT`.
- Apply `WHERE` conditions.

**Examples:**

- List all customers:
    
    ```sql
    SELECT * FROM customers;
    ```
    
- Find pets of a specific category (e.g., "Dog"):
    
    ```sql
    SELECT * FROM pets WHERE category = 'Dog';
    ```
    

---

### **2. Joins**

- Combine data from multiple tables using `INNER JOIN`, `LEFT JOIN`, or `RIGHT JOIN`.

**Examples:**

- List all customer details with their pets:
    
    ```sql
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        p.nickname 
    FROM customers c
    INNER JOIN pets p ON c.customer_id = p.customer_id;
    ```
    
- Show the visits made by pets and the service provided:
    
    ```sql
    SELECT 
        v.visit_id, 
        p.nickname, 
        sd.service_name, 
        v.bill 
    FROM visit v
    INNER JOIN pets p ON v.pet_id = p.pet_id
    INNER JOIN service_details sd ON v.service_id = sd.service_id;
    ```
    

---

### **3. Aggregations and Grouping**

- Use `COUNT`, `SUM`, `AVG`, `GROUP BY`, and `HAVING`.

**Examples:**

- Count the number of pets each customer owns:
    
    ```sql
    SELECT 
        customer_id, 
        COUNT(*) AS pet_count 
    FROM pets 
    GROUP BY customer_id;
    ```
    
- Find the total revenue generated from services:
    
    ```sql
    SELECT 
        SUM(bill) AS total_revenue 
    FROM visit 
    WHERE paid = TRUE;
    ```
    

---

### **4. Subqueries**

- Use subqueries in `SELECT`, `FROM`, or `WHERE` clauses.

**Examples:**

- Find customers who referred others:
    
    ```sql
    SELECT 
        first_name, 
        last_name 
    FROM customers 
    WHERE customer_id IN (SELECT referred_by_customer_id FROM customers);
    ```
    

---

### **5. Constraints and Foreign Keys**

- Validate relationships and ensure integrity by inserting data.

**Examples:**

- Try inserting a pet with a nonexistent customer ID to observe a foreign key violation:
    
    ```sql
    INSERT INTO pets (pet_id, customer_id, nickname) VALUES (1, 999, 'Buddy');
    ```
    

---

### **6. Data Modification**

- Practice `INSERT`, `UPDATE`, and `DELETE`.

**Examples:**

- Add a new customer:
    
    ```sql
    INSERT INTO customers (customer_id, first_name, last_name, join_date) 
    VALUES (101, 'Jane', 'Doe', CURRENT_TIMESTAMP);
    ```
    
- Update a customer's email:
    
    ```sql
    UPDATE customer_details 
    SET email = 'jane.doe@example.com' 
    WHERE customer_id = 101;
    ```
    

---

### **7. Advanced Topics**

- Recursive queries with Common Table Expressions (CTEs).
- Window functions for ranking or partitioning.

**Examples:**

- Find all employees and their supervisors:
    
    ```sql
    WITH RECURSIVE SupervisorTree AS (
        SELECT employee_id, first_name, last_name, supervisor_id
        FROM staff
        WHERE supervisor_id IS NULL
        UNION ALL
        SELECT s.employee_id, s.first_name, s.last_name, t.supervisor_id
        FROM staff s
        INNER JOIN SupervisorTree t ON s.supervisor_id = t.employee_id
    )
    SELECT * FROM SupervisorTree;
    ```
    

---
### **8. Views**

- Create views for frequently accessed data.

**Examples:**

- Create a view of visits with pet and service details:
    
    ```sql
    CREATE VIEW visit_details AS
    SELECT 
        v.visit_id, 
        p.nickname AS pet_name, 
        sd.service_name, 
        v.bill 
    FROM visit v
    INNER JOIN pets p ON v.pet_id = p.pet_id
    INNER JOIN service_details sd ON v.service_id = sd.service_id;
    ```
    
