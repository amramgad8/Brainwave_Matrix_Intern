# 📚 Library Management Database System

This project is part of my internship program at **Brainwave Matrix Solutions**.  
The goal was to design and implement a relational database system for a library, managing books, borrowers, loans, and related operations efficiently.

---

## 📂 Project Structure

The project consists of the following components:

- **Database Schema**: SQL scripts to create tables and relationships.
- **Insert Data**: SQL script to populate tables with initial sample data.
- **Triggers**: Automatic operations for real-time updates:
  - Decrease available book copies after a new loan.
  - Increase available book copies after book return.
- **Stored Procedures**:
  - `sp_CheckOutBook`: Borrow a book with validation.
  - (Additional procedures can be added for returns and fines.)
- **Test Queries**: SQL scripts to test and validate database operations.

---

## 🛠️ Technologies Used

- Microsoft SQL Server
- SQL (DDL, DML, Triggers, Stored Procedures)

---

## 🗂️ Tables Overview

| Table        | Description                          |
|--------------|--------------------------------------|
| Books        | Stores all books details             |
| Authors      | Stores authors' information          |
| Borrowers    | Stores library members' details      |
| Publishers   | Stores publishing companies          |
| Categories   | Classifies books into categories     |
| Loans        | Tracks the borrowing history         |
| Reservations | Manages book reservations            |
| Fines        | Calculates overdue fines             |
| Staff        | Stores information about staff members |
| BookAuthors  | Handles many-to-many relation between books and authors |

---

## ⚡ Triggers Overview

| Trigger Name         | Purpose                                                  |
|----------------------|-----------------------------------------------------------|
| `trg_AfterLoanInsert` | Decrease `AvailableCopies` when a book is borrowed        |
| `trg_AfterLoanUpdate` | Increase `AvailableCopies` when a book is returned        |

---

## 🧠 Stored Procedures Overview

| Procedure Name  | Purpose                               |
|-----------------|---------------------------------------|
| `sp_CheckOutBook` | Borrow a book with validation (availability and max limit) |

---

## 🧪 Testing the Database

Sample test queries are included to:

- Display available books
- Display active loans
- Display borrowers with overdue books
- Update return dates to simulate returns
- Track most borrowed books

(Refer to `TestQueries.sql` for detailed tests.)

---

## 📈 How to Run the Project

1. Create a new database (e.g., `LibraryDB`).
2. Execute all table creation scripts (`create tables` folder).
3. Execute `insert random data.sql` to populate sample data.
4. Create all triggers.
5. Create stored procedures.
6. Run the test queries to validate database functionalities.

---

## 🎯 What This Project Demonstrates

- Practical understanding of database design principles.
- Implementation of referential integrity with Foreign Keys.
- Automation of business logic using Triggers.
- Writing clean and structured Stored Procedures.
- Handling transactions and exceptions.
- Writing advanced SQL queries for real-world scenarios.

---

## 📜 License

This project is part of the internship at **Brainwave Matrix Solutions** and is for educational and demonstration purposes.

---
