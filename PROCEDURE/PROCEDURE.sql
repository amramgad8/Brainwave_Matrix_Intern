
USE LibraryDB;
GO

CREATE PROCEDURE sp_CheckOutBook
    @BookID INT,
    @BorrowerID INT,
    @Result NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @available INT;
    DECLARE @max_loans INT = 5;
    DECLARE @current_loans INT;
    
    -- Check book availability
    SELECT @available = AvailableCopies FROM Books WHERE BookID = @BookID;
    
    -- Check borrower's current loans
    SELECT @current_loans = COUNT(*) FROM Loans 
    WHERE BorrowerID = @BorrowerID AND ReturnDate IS NULL;
    
    IF @available <= 0
        SET @Result = 'Book not available';
    ELSE IF @current_loans >= @max_loans
        SET @Result = 'Maximum loans reached';
    ELSE
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;
            
            INSERT INTO Loans (BookID, BorrowerID, LoanDate, DueDate)
            VALUES (@BookID, @BorrowerID, GETDATE(), DATEADD(day, 14, GETDATE()));
            
            SET @Result = 'Book checked out successfully';
            
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SET @Result = 'Error: ' + ERROR_MESSAGE();
        END CATCH
    END
END;