USE LibraryDB;
GO

CREATE TRIGGER trg_AfterLoanInsert
ON Loans
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE b
    SET b.AvailableCopies = b.AvailableCopies - 1
    FROM Books b
    INNER JOIN inserted i ON b.BookID = i.BookID
    WHERE i.ReturnDate IS NULL
      AND b.AvailableCopies > 0;
END;
GO

PRINT 'Trigger trg_AfterLoanInsert created successfully.';
