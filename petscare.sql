CREATE TABLE `customers` (
  `customer_id` integer PRIMARY KEY,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `payment_info` varchar(255),
  `join_date` timestamp,
  `referred_by_customer_id` integer
);

CREATE TABLE `customer_details` (
  `customer_id` integer PRIMARY KEY,
  `address` varchar(255),
  `email` varchar(255),
  `phone` varchar(255),
  `dob` timestamp
);

CREATE TABLE `pets` (
  `customer_id` integer,
  `pet_id` integer PRIMARY KEY,
  `nickname` varchar(255),
  `category` varchar(255),
  `species_breed` varchar(255),
  `gender` varchar(255),
  `dob` timestamp,
  `notes` varchar(255)
);

CREATE TABLE `species_breed` (
  `species_breed` varchar(255) PRIMARY KEY,
  `species_breed_description` varchar(255)
);

CREATE TABLE `staff` (
  `employee_id` integer PRIMARY KEY,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `ssn` varchar(255),
  `address` varchar(255),
  `email` varchar(255),
  `phone` varchar(255),
  `dob` timestamp,
  `supervisor_id` integer
);

CREATE TABLE `visit` (
  `visit_id` integer PRIMARY KEY,
  `date` timestamp,
  `time` timestamp,
  `customer_id` integer,
  `pet_id` integer,
  `service_id` integer,
  `employee_id` integer,
  `bill` decimal,
  `paid` boolean
);

CREATE TABLE `service_details` (
  `service_id` integer PRIMARY KEY,
  `service_name` varchar(255),
  `service_price` decimal,
  `service_description` varchar(255)
);

CREATE TABLE `pets_staff` (
  `customer_id` integer,
  `pet_id` integer,
  `employee_id` integer
);

ALTER TABLE `customers` ADD FOREIGN KEY (`referred_by_customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `customer_details` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `pets` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `pets` ADD FOREIGN KEY (`species_breed`) REFERENCES `species_breed` (`species_breed`);

ALTER TABLE `staff` ADD FOREIGN KEY (`supervisor_id`) REFERENCES `staff` (`employee_id`);

ALTER TABLE `visit` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `visit` ADD FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`);

ALTER TABLE `visit` ADD FOREIGN KEY (`service_id`) REFERENCES `service_details` (`service_id`);

ALTER TABLE `visit` ADD FOREIGN KEY (`employee_id`) REFERENCES `staff` (`employee_id`);

ALTER TABLE `pets_staff` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `pets_staff` ADD FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`);

ALTER TABLE `pets_staff` ADD FOREIGN KEY (`employee_id`) REFERENCES `staff` (`employee_id`);
