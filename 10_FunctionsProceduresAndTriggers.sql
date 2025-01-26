SELECT * FROM pets;

-- ======================================
-- Functions --
-- ======================================

-- create function
CREATE OR REPLACE FUNCTION calculate_pet_age(pet_dob DATE) RETURNS INTEGER AS $$
BEGIN
    RETURN DATE_PART('year', AGE(pet_dob));
END;
$$ LANGUAGE plpgsql;

-- Returns the age of the pet
SELECT calculate_pet_age('1999-01-20'); 

-- ======================================
-- Procedure --
-- ======================================

-- create proceudure 
CREATE OR REPLACE PROCEDURE insert_customer(
	customer_id INTEGER,
    first_name VARCHAR,
    last_name VARCHAR,
    payment_info VARCHAR
) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO customers (customer_id, first_name, last_name, payment_info, join_date)
    VALUES (customer_id, first_name, last_name, payment_info, CURRENT_TIMESTAMP);
END;
$$;

-- 
SELECT * FROM customers;

CALL insert_customer(6, 'John', 'Doe', 'Visa 1234');

-- ======================================
--  More Complex Procedure --
-- ======================================

CREATE OR REPLACE PROCEDURE insert_pet(
	pet_id INTEGER,
    customer_id INTEGER,
    nickname VARCHAR,
    category VARCHAR,
    species_breed VARCHAR,
    gender VARCHAR,
    dob DATE,
    notes VARCHAR
) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO pets (pet_id, customer_id, nickname, category, species_breed, gender, dob, notes)
    VALUES (pet_id, customer_id, nickname, category, species_breed, gender, dob, notes);

    -- Optional: Log action
    RAISE NOTICE 'Pet % has been added for Customer ID %', nickname, customer_id;
END;
$$;

-- 
CALL insert_pet(5, 1, 'Buddy', 'Dog', 'Golden Retriever', 'Male', '2020-01-01', 'Healthy');

SELECT * FROM pets;

---
-- ======================================
--  Triggers --
-- ======================================

CREATE OR REPLACE FUNCTION update_join_date_trigger() RETURNS TRIGGER AS $$
BEGIN
    UPDATE customers
    SET join_date = CURRENT_TIMESTAMP
    WHERE customer_id = NEW.customer_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER update_join_date
AFTER UPDATE OF referred_by_customer_id ON customers
FOR EACH ROW
EXECUTE FUNCTION update_join_date_trigger();


SELECT * FROM customers;

UPDATE customers
SET referred_by_customer_id = 1
WHERE customer_id = 4;
