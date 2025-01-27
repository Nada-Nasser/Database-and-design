SELECT * from customers;

-- ==========================================
-- Simple views
-- ==========================================
-- Create a simple view to display customer names and join dates
CREATE VIEW customer_overview AS
SELECT customer_id, first_name, last_name, join_date
FROM customers;

-- Query the view
SELECT * FROM customer_overview;

-- ==========================================
-- Enforcing Read-Only Behavior for the view
-- ==========================================

-- Add a trigger to reject updates on the view
CREATE OR REPLACE FUNCTION prevent_view_updates()
RETURNS TRIGGER AS $$
BEGIN
  RAISE EXCEPTION 'Updates not allowed on this view';
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_update
INSTEAD OF UPDATE ON customer_overview
FOR EACH ROW EXECUTE FUNCTION prevent_view_updates();


UPDATE customer_overview SET first_name = 'John' WHERE customer_id = 1; -- Should fail

-- ==========================================
-- Complex views
-- ==========================================
CREATE VIEW customer_pet_info AS
SELECT c.customer_id, c.first_name, p.nickname AS pet_name, p.category
FROM customers c
JOIN pets p ON c.customer_id = p.customer_id
WHERE p.category = 'Dog';


-- Query the view
SELECT * FROM customer_pet_info;

-- ==================================
-- Materialized Views
-- ==================================

-- Create a materialized view to store aggregated data
CREATE MATERIALIZED VIEW pet_category_summary AS
SELECT category, COUNT(*) AS total_pets
FROM pets
GROUP BY category;

CREATE VIEW pet_category_summary_view AS
SELECT category, COUNT(*) AS total_pets
FROM pets
GROUP BY category;


SELECT * FROM pet_category_summary;
SELECT * FROM pet_category_summary_view;

SELECT * from pets;

INSERT INTO public.pets(
	customer_id, pet_id, nickname, category, species_breed, gender, dob, notes)
	VALUES (2, 7, 'joy2', 'Cat', 'Tabby Cat', 'Female', '2018-09-22 00:00:00', 'funny cat');


REFRESH MATERIALIZED VIEW pet_category_summary;

-- =================================


-- Add an index to the materialized view for faster queries
CREATE INDEX idx_pet_category ON pet_category_summary (category);

-- Query the materialized view
SELECT * FROM pet_category_summary WHERE category = 'Dog';

