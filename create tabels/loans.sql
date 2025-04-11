CREATE TABLE Loans (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    BorrowerID INT NOT NULL,
    LoanDate DATE NOT NULL DEFAULT GETDATE(),
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status NVARCHAR(20) DEFAULT 'On Loan' CHECK (Status IN ('On Loan', 'Returned', 'Overdue', 'Lost')),
    FineAmount DECIMAL(10,2) DEFAULT 0.00,
    CONSTRAINT FK_Loans_Books FOREIGN KEY (BookID) REFERENCES Books(BookID),
    CONSTRAINT FK_Loans_Borrowers FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);