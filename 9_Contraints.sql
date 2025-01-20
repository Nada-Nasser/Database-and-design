DELETE FROM pets WHERE customer_id NOT IN (SELECT customer_id FROM customers);


SELECT * from pets;
SELECT * from customers;

ALTER TABLE pets ADD CONSTRAINT fk_pets_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE visit ADD CONSTRAINT chk_bill_positive CHECK (bill >= 0);

-- ======================================
-- Task : add optional foreign key
-- ======================================

--Clean data if needed:
UPDATE customers
SET referred_by_customer_id = NULL
WHERE referred_by_customer_id IS NOT NULL
AND referred_by_customer_id NOT IN (SELECT customer_id FROM customers);

-- required foreign key
ALTER TABLE customer 
ADD CONSTRAINT fk_referred_by 
FOREIGN KEY (referred_by_customer_id) 
REFERENCES customers(customer_id);

-- optional foreign key
ALTER TABLE customers
ADD CONSTRAINT fk_referred_by
FOREIGN KEY (referred_by_customer_id)
REFERENCES customers(customer_id)
ON DELETE SET NULL;

--Testing
INSERT INTO customers (customer_id, first_name, last_name, referred_by_customer_id)
VALUES (4, 'John', 'Doe', NULL); -- No referral

INSERT INTO customers (customer_id, first_name, last_name, referred_by_customer_id)
VALUES (5, 'Jane', 'Smith', 4); -- Referred by John
