-- Creating  tables
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);


INSERT INTO clinics (cid, clinic_name, city, state, country)
VALUES 
('cnc-0100001', 'XYZ Clinic', 'Lorem', 'Ipsum', 'Dolor'),
('cnc-0100002', 'CarePlus Clinic', 'Hyderabad', 'Telangana', 'India'),
('cnc-0100003', 'HealthyLife Clinic', 'Mumbai', 'Maharashtra', 'India'),
('cnc-0100004', 'Nova Health Center', 'Bangalore', 'Karnataka', 'India'),
('cnc-0100005', 'Sunshine Clinic', 'Chennai', 'Tamil Nadu', 'India');

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
);

INSERT INTO customer (uid, name, mobile)
VALUES
('bk-09f3e-95hj', 'Jon Doe', '9700000001'),
('bk-09f3e-95hk', 'Alice Smith', '9700000002'),
('bk-09f3e-95hl', 'Robert Brown', '9700000003'),
('bk-09f3e-95hm', 'Emily Davis', '9700000004'),
('bk-09f3e-95hn', 'Michael Johnson', '9700000005');


CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel)
VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999.00, '2021-09-23 12:03:22', 'sodat'),
('ord-00100-00101', 'bk-09f3e-95hk', 'cnc-0100002', 14999.00, '2021-09-23 12:10:45', 'online'),
('ord-00100-00102', 'bk-09f3e-95hl', 'cnc-0100003', 17999.00, '2021-09-24 14:30:10', 'walkin'),
('ord-00100-00103', 'bk-09f3e-95hm', 'cnc-0100004', 20999.00, '2021-09-24 15:45:33', 'sodat'),
('ord-00100-00104', 'bk-09f3e-95hn', 'cnc-0100005', 9999.00,  '2021-09-25 09:20:18', 'online'),
('ord-00100-00105', 'bk-09f3e-95hj', 'cnc-0100003', 12999.00, '2021-09-25 11:50:22', 'walkin'),
('ord-00100-00106', 'bk-09f3e-95hk', 'cnc-0100001', 18999.00, '2021-09-26 10:05:50', 'sodat'),
('ord-00100-00107', 'bk-09f3e-95hl', 'cnc-0100004', 25999.00, '2021-09-26 13:16:30', 'online');


CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(255),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO expenses (eid, cid, description, amount, datetime)
VALUES
('exp-0100-00100', 'cnc-0100001', 'First-aid supplies', 557.00, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100002', 'Cleaning supplies', 799.00,   '2021-09-23 09:15:10'),
('exp-0100-00102', 'cnc-0100003', 'Medical equipment repair', 1250.00, '2021-09-24 10:40:55'),
('exp-0100-00103', 'cnc-0100004', 'Electricity bill', 3400.00, '2021-09-24 11:25:12'),
('exp-0100-00104', 'cnc-0100005', 'Water bill', 890.00, '2021-09-24 16:55:40'),
('exp-0100-00105', 'cnc-0100001', 'Staff refreshments', 650.00, '2021-09-25 08:30:18'),
('exp-0100-00106', 'cnc-0100003', 'Disinfectant purchase', 499.00, '2021-09-25 14:22:02'),
('exp-0100-00107', 'cnc-0100004', 'Printer ink', 320.00, '2021-09-26 10:10:30');





-- 1----------------------------------------------------------
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021  -- Replace with desired year
GROUP BY sales_channel;

-- 2---------------------------------------------------------------
SELECT uid, SUM(amount) AS total_value
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_value DESC
LIMIT 10;

-- 3------------------------------------------------------
WITH monthly_revenue AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY month
),
monthly_expenses AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS expenses
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY month
)
SELECT 
    r.month, 
    r.revenue, 
    e.expenses, 
    (r.revenue - e.expenses) AS profit,
    CASE WHEN (r.revenue - e.expenses) > 0 THEN 'profitable' ELSE 'not-profitable' END AS status
FROM monthly_revenue r
LEFT JOIN monthly_expenses e ON r.month = e.month;

-- 4----------------------------------
WITH sales_per_clinic AS (
    SELECT cid, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021 AND MONTH(datetime) = 9
    GROUP BY cid
),
expenses_per_clinic AS (
    SELECT cid, SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021 AND MONTH(datetime) = 9
    GROUP BY cid
),
clinic_profit AS (
    SELECT 
        c.cid,
        c.city,
        COALESCE(s.revenue,0) - COALESCE(e.expense,0) AS profit
    FROM clinics c
    LEFT JOIN sales_per_clinic s ON c.cid = s.cid
    LEFT JOIN expenses_per_clinic e ON c.cid = e.cid
),
ranked AS (
    SELECT 
        city,
        cid,
        profit,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT city, cid AS most_profitable_clinic, profit
FROM ranked
WHERE rnk = 1;


-- 5------------
WITH sales_per_clinic AS (
    SELECT cid, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021 AND MONTH(datetime) = 9
    GROUP BY cid
),
expenses_per_clinic AS (
    SELECT cid, SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021 AND MONTH(datetime) = 9
    GROUP BY cid
),
clinic_profit AS (
    SELECT 
        c.cid,
        c.state,
        COALESCE(s.revenue,0) - COALESCE(e.expense,0) AS profit
    FROM clinics c
    LEFT JOIN sales_per_clinic s ON c.cid = s.cid
    LEFT JOIN expenses_per_clinic e ON c.cid = e.cid
),
ranked AS (
    SELECT 
        state,
        cid,
        profit,
        RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT state, cid AS second_least_profitable_clinic, profit
FROM ranked
WHERE rnk = 2;
