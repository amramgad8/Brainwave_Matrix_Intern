
USE LibraryDB;
GO

-- 1. Display all books with publisher and category
SELECT 
    b.BookID,
    b.Title,
    b.TotalCopies,
    b.AvailableCopies,
    p.Name AS PublisherName,
    c.Name AS CategoryName
FROM Books b
INNER JOIN Publishers p ON b.PublisherID = p.PublisherID
INNER JOIN Categories c ON b.CategoryID = c.CategoryID;
GO

-- 2. Display available books for borrowing
SELECT 
    BookID,
    Title,
    AvailableCopies
FROM Books
WHERE AvailableCopies > 0;
GO

-- 3. Display all current active loans (not returned yet)
SELECT 
    l.LoanID,
    b.Title,
    br.Name AS BorrowerName,
    l.LoanDate,
    l.DueDate
FROM Loans l
INNER JOIN Books b ON l.BookID = b.BookID
INNER JOIN Borrowers br ON l.BorrowerID = br.BorrowerID
WHERE l.ReturnDate IS NULL;
GO

-- 4. Display borrowers with overdue loans
SELECT 
    br.BorrowerID,
    br.Name,
    l.BookID,
    l.LoanDate,
    l.DueDate
FROM Loans l
INNER JOIN Borrowers br ON l.BorrowerID = br.BorrowerID
WHERE l.ReturnDate IS NULL 
  AND l.DueDate < GETDATE();
GO

-- 5. Display number of active loans per borrower
SELECT 
    BorrowerID,
    COUNT(*) AS ActiveLoans
FROM Loans
WHERE ReturnDate IS NULL
GROUP BY BorrowerID;
GO

-- 6. Update return date of a book (simulate returning a book)
UPDATE Loans
SET ReturnDate = GETDATE()
WHERE LoanID = 1;
GO

-- 7. Delete a loan record (for testing purposes)
DELETE FROM Loans
WHERE LoanID = 1;
GO

-- 8. Display top 5 most borrowed books
SELECT 
    b.Title,
    COUNT(l.LoanID) AS LoanCount
FROM Loans l
INNER JOIN Books b ON l.BookID = b.BookID
GROUP BY b.Title
ORDER BY LoanCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
GO

-- 9. Display books that have never been borrowed
SELECT 
    b.BookID,
    b.Title
FROM Books b
LEFT JOIN Loans l ON b.BookID = l.BookID
WHERE l.BookID IS NULL;
GO

-- 10. Display books overdue by more than 30 days
SELECT 
    b.Title,
    br.Name AS BorrowerName,
    l.LoanDate,
    DATEDIFF(DAY, l.DueDate, GETDATE()) AS DaysOverdue
FROM Loans l
INNER JOIN Books b ON l.BookID = b.BookID
INNER JOIN Borrowers br ON l.BorrowerID = br.BorrowerID
WHERE l.ReturnDate IS NULL 
  AND l.DueDate < DATEADD(DAY, -30, GETDATE());
GO
