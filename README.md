# PlatinumRx Assignment – Data Analyst Round

This repository contains my complete solution for the PlatinumRx Data Analyst Assignment.  
It includes SQL schema creation, analytical SQL queries, spreadsheet-based data manipulation, and Python scripts for logical programming tasks.

---

## 📂 Project Structure

```

PlatinumRx_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
│
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
│
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
│
└── README.md

````

---

## 🏨 SQL – Hotel Management System (Part A)

### Tasks Completed:
- Created database schema for:
  - `users`
  - `bookings`
  - `items`
  - `booking_commercials`
- Wrote analytical queries to:
  - Find last booked room for each user
  - Calculate total billing for bookings in Nov 2021
  - Identify high-value bills (>1000)
  - Determine most/least ordered items per month
  - Find customers with second-highest bill value per month

### Approach Summary:
- Used **window functions** (`ROW_NUMBER`) for ranking.
- Used `SUM()`, `GROUP BY`, and date filters for billing calculations.
- Applied `DATE_FORMAT` to group data month-wise (MySQL).

---

## 🏥 SQL – Clinic Management System (Part B)

### Tasks Completed:
- Created schema for:
  - `clinics`
  - `customer`
  - `clinic_sales`
  - `expenses`
- Developed queries to:
  - Calculate revenue by sales channel
  - Identify top 10 customers
  - Compute monthly revenue, expense, profit/loss
  - Find most profitable clinic per city
  - Identify second-least profitable clinic per state

### Approach Summary:
- Used **aggregations** and **joins** to compute metrics.
- Implemented month-wise grouping via `DATE_FORMAT`.
- Used ranking (`ROW_NUMBER`) for “most” / “least” selections.

---

## 📊 Spreadsheet – Ticket & Feedback Analysis

### Tasks Completed:
- Created an Excel/Google Sheets file with:
  - `ticket` sheet
  - `feedbacks` sheet
- Populated `created_at` in `feedbacks` using:
  - `INDEX-MATCH` for accurate lookup by `cms_id`
- Created helper columns to check:
  - Same-day ticket closure
  - Same-hour ticket closure
- Built summary counts using:
  - Pivot Table or `SUMIFS`

### Formula Examples:
```excel
=INDEX(ticket!$B:$B, MATCH($A2, ticket!$E:$E, 0))
=INT(B2)
=HOUR(B2)
=IF(AND(INT(B2)=INT(C2), HOUR(B2)=HOUR(C2)),1,0)
````

---

## 🐍 Python Programs

### 1️⃣ Time Converter

File: `01_Time_Converter.py`
Converts minutes into “X hrs Y minutes”.

### 2️⃣ Duplicate Remover

File: `02_Remove_Duplicates.py`
Removes duplicate characters while preserving order.

Both run independently and handle basic edge cases.

---

