
CREATE NONCLUSTERED INDEX idx_loans_dates ON Loans(LoanDate, DueDate, ReturnDate);
CREATE NONCLUSTERED INDEX idx_loans_status ON Loans(Status);