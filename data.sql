-- Insert dummy data into customers
INSERT INTO customers (customer_id, first_name, last_name, payment_info, join_date, referred_by_customer_id)
VALUES 
(1, 'John', 'Doe', 'Visa 1234', '2023-01-01', NULL),
(2, 'Jane', 'Smith', 'Mastercard 5678', '2023-02-15', 1),
(3, 'Alice', 'Brown', 'PayPal', '2023-03-10', 2);

-- Insert dummy data into customer_details
INSERT INTO customer_details (customer_id, address, email, phone, dob)
VALUES 
(1, '123 Elm Street', 'john.doe@example.com', '555-1234', '1985-05-20'),
(2, '456 Oak Street', 'jane.smith@example.com', '555-5678', '1990-07-15'),
(3, '789 Pine Street', 'alice.brown@example.com', '555-9012', '1995-10-25');

-- Insert dummy data into species_breed
INSERT INTO species_breed (species_breed, species_breed_description)
VALUES 
('Golden Retriever', 'Friendly and intelligent dog breed'),
('Tabby Cat', 'Common domestic cat with distinctive striped coat');

-- Insert dummy data into pets
INSERT INTO pets (customer_id, pet_id, nickname, category, species_breed, gender, dob, notes)
VALUES 
(1, 1, 'Buddy', 'Dog', 'Golden Retriever', 'Male', '2020-06-15', 'Loves playing fetch'),
(2, 2, 'Whiskers', 'Cat', 'Tabby Cat', 'Female', '2018-09-22', 'Shy but affectionate'),
(3, 3, 'Max', 'Dog', 'Golden Retriever', 'Male', '2021-03-12', 'Enjoys swimming');

-- Insert dummy data into staff
INSERT INTO staff (employee_id, first_name, last_name, ssn, address, email, phone, dob, supervisor_id)
VALUES 
(1, 'Emily', 'Johnson', '123-45-6789', '111 Maple Avenue', 'emily.j@example.com', '555-3456', '1980-02-14', NULL),
(2, 'Michael', 'Williams', '987-65-4321', '222 Birch Road', 'michael.w@example.com', '555-7890', '1985-08-30', 1);

-- Insert dummy data into service_details
INSERT INTO service_details (service_id, service_name, service_price, service_description)
VALUES 
(1, 'Grooming', 50.00, 'Full grooming service for pets'),
(2, 'Vaccination', 30.00, 'Annual vaccination for pets');

-- Insert dummy data into visit
INSERT INTO visit (visit_id, date, time, customer_id, pet_id, service_id, employee_id, bill, paid)
VALUES 
(1, '2023-12-01', '2023-12-01 10:00:00', 1, 1, 1, 1, 50.00, true),
(2, '2023-12-02', '2023-12-02 11:00:00', 2, 2, 2, 2, 30.00, false);


-- Insert dummy data into pets_staff
INSERT INTO pets_staff (customer_id, pet_id, employee_id)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 1);
