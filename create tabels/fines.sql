CREATE TABLE Fines (
    FineID INT IDENTITY(1,1) PRIMARY KEY,
    LoanID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    IssueDate DATE NOT NULL DEFAULT GETDATE(),
    PaymentDate DATE,
    Status NVARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Paid', 'Waived')),
    CONSTRAINT FK_Fines_Loans FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);