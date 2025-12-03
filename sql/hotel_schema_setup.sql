-- creating tables----
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address)
VALUES
    ('usr-183c-e23a', 'Jane Smith', '98XXXXXXXX', 'jane.smith@example.com', NULL),
    ('usr-32bd-24dc', 'Alice Johnson', '99XXXXXXXX', 'alice.j@example.com', NULL),
    ('usr-8d09-d080', 'Bob Brown', '96XXXXXXXX', 'bob.b@example.com', NULL);



CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ) ;
    
    
INSERT INTO bookings (booking_id, booking_date, room_no, user_id)
VALUES
    ('bk-7c15-7fa7', '2021-09-17 23:48:34', 'rm-3966-94fd', '21wrcxuy-67erfn'),
    ('bk-0257-5031', '2021-09-10 20:59:58', 'rm-4258-3d1c', '21wrcxuy-67erfn'),
    ('bk-f5da-62fd', '2021-09-21 13:32:25', 'rm-6313-8d27', 'usr-183c-e23a'),
    ('bk-0c85-f4aa', '2021-09-20 01:15:18', 'rm-bc8f-a7c1', '21wrcxuy-67erfn'),
    ('bk-50fb-e688', '2021-09-09 03:55:31', 'rm-10d6-77b0', 'usr-8d09-d080'),
    ('bk-34cb-bac2', '2021-10-16 18:37:31', 'rm-dea1-6fd0', 'usr-183c-e23a'),
    ('bk-b3fc-fa1d', '2021-10-07 21:21:52', 'rm-bcd0-4d28', 'usr-183c-e23a'),
    ('bk-8cfa-7688', '2021-10-28 17:27:24', 'rm-6520-7e2e', '21wrcxuy-67erfn'),
    ('bk-2b48-48a2', '2021-10-18 08:25:26', 'rm-208d-72b5', 'usr-32bd-24dc'),
    ('bk-7da3-8d75', '2021-10-19 03:08:53', 'rm-8fbe-44bf', '21wrcxuy-67erfn'),
    ('bk-0938-5784', '2021-11-08 21:54:02', 'rm-9ff6-1cda', 'usr-32bd-24dc'),
    ('bk-f055-0f63', '2021-11-10 07:46:04', 'rm-eb51-054e', 'usr-32bd-24dc'),
    ('bk-630e-4c0f', '2021-11-27 23:21:53', 'rm-2feb-d7ef', '21wrcxuy-67erfn'),
    ('bk-19a2-1d8a', '2021-11-12 21:08:14', 'rm-8d4b-2568', '21wrcxuy-67erfn'),
    ('bk-ca6d-2ba6', '2021-11-24 23:01:49', 'rm-09f3-1862', 'usr-183c-e23a');

    
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);

INSERT INTO items (item_id, item_name, item_rate)
VALUES
    ('itm-7828-0a7d', 'Butter Naan', 25.0),
    ('itm-400c-9ad8', 'Paneer Tikka', 150.0),
    ('itm-b774-09ca', 'Tea', 10.0);



CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(5, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO bookings (booking_id)
VALUES ('bk-09f3e-95hj'),
       ('bk-q034-q4o')
ON DUPLICATE KEY UPDATE booking_id = booking_id;

INSERT INTO items (item_id)
VALUES ('itm-a9e8-q8fu')
ON DUPLICATE KEY UPDATE item_id = item_id;

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity)
VALUES 
    ('q34r-3q4o8-dtd8', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
    ('q3o4-ahf32-oj94', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', NULL, 1),
    ('134lr-oyfo8-3o08', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:05:37', NULL, 0.5),
	('bc-001-aui2', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:06:10', 'itm-a9e8-q8fu', 2),
    ('bc-002-ai92', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:06:11', 'itm-a9e8-q8fu', 1),
    ('bc-003-akl2', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:06:12', NULL, 4),
    ('bc-004-an02', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:06:13', NULL, 3),
    ('bc-005-avd2', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:06:14', 'itm-a9e8-q8fu', 0.5),
    ('bc-006-ax42', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:06:15', 'itm-a9e8-q8fu', 5),
    ('bc-007-ao92', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:06:16', NULL, 2.5),
    ('bc-008-ap02', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:06:17', NULL, 1.5);
    
    
    
-- 1-------------------------------------------------

SELECT u.user_id, b.room_no AS last_booked_room_no
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(booking_date) FROM bookings WHERE user_id = u.user_id
);

-- 2----------------------------------------------------------------------------
SELECT b.booking_id, SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(b.booking_date) = 2021 AND MONTH(b.booking_date) = 11
GROUP BY b.booking_id;

-- 3-----------------------------------------------------------------------------------------
SELECT bc.bill_id, SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date) = 2021 AND MONTH(bc.bill_date) = 10
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- 4-------------------------------------------------------------------------------------------
WITH monthly_orders AS (
    SELECT 
        YEAR(bc.bill_date) AS year,
        MONTH(bc.bill_date) AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_quantity
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY year, month, bc.item_id
),
ranked_items AS (
    SELECT 
        year, month, item_id, total_quantity,
        RANK() OVER (PARTITION BY year, month ORDER BY total_quantity DESC) AS rank_most,
        RANK() OVER (PARTITION BY year, month ORDER BY total_quantity ASC) AS rank_least
    FROM monthly_orders
)
SELECT 
    year, month, 
    MAX(CASE WHEN rank_most = 1 THEN item_id END) AS most_ordered_item,
    MAX(CASE WHEN rank_least = 1 THEN item_id END) AS least_ordered_item
FROM ranked_items
GROUP BY year, month;

-- 5----------------------------------

WITH monthly_bills AS (
    SELECT 
        YEAR(bc.bill_date) AS year,
        MONTH(bc.bill_date) AS month,
        b.user_id,
        SUM(bc.item_quantity * i.item_rate) AS total_bill
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY year, month, b.user_id
),
ranked_bills AS (
    SELECT 
        year, month, user_id, total_bill,
        RANK() OVER (PARTITION BY year, month ORDER BY total_bill DESC) AS bill_rank
    FROM monthly_bills
)
SELECT year, month, user_id, total_bill
FROM ranked_bills
WHERE bill_rank = 2;

