CREATE TABLE Staff (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    Position NVARCHAR(100),
    HireDate DATE NOT NULL DEFAULT GETDATE(),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    AccessLevel NVARCHAR(20) NOT NULL CHECK (AccessLevel IN ('Admin', 'Librarian', 'Assistant'))
);