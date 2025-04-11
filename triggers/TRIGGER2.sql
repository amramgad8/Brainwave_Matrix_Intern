

USE LibraryDB;
GO

CREATE TRIGGER trg_AfterLoanUpdate
ON Loans
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(ReturnDate)
    BEGIN
        UPDATE Books 
        SET AvailableCopies = AvailableCopies + 1 
        FROM Books b
        INNER JOIN inserted i ON b.BookID = i.BookID
        INNER JOIN deleted d ON i.LoanID = d.LoanID
        WHERE i.ReturnDate IS NOT NULL AND d.ReturnDate IS NULL;
    END
END;