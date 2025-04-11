
USE LibraryDB;
GO


------------------------------------------------------------
-- 1. Disable constraints temporarily for all tables
------------------------------------------------------------
ALTER TABLE Fines NOCHECK CONSTRAINT ALL;
ALTER TABLE Reservations NOCHECK CONSTRAINT ALL;
ALTER TABLE Loans NOCHECK CONSTRAINT ALL;
ALTER TABLE BookAuthors NOCHECK CONSTRAINT ALL;
ALTER TABLE Books NOCHECK CONSTRAINT ALL;
ALTER TABLE Borrowers NOCHECK CONSTRAINT ALL;
ALTER TABLE Authors NOCHECK CONSTRAINT ALL;
ALTER TABLE Categories NOCHECK CONSTRAINT ALL;
ALTER TABLE Publishers NOCHECK CONSTRAINT ALL;
ALTER TABLE Staff NOCHECK CONSTRAINT ALL;

------------------------------------------------------------
-- 2. Delete data in order of dependencies (child -> parent)
------------------------------------------------------------
DELETE FROM Fines;
DELETE FROM Reservations;
DELETE FROM Loans;
DELETE FROM BookAuthors;
DELETE FROM Books;
DELETE FROM Borrowers;
DELETE FROM Authors;
DELETE FROM Categories;
DELETE FROM Publishers;
DELETE FROM Staff;

------------------------------------------------------------
-- 3. Reseed identity values (use DBCC CHECKIDENT for tables that have an identity)
------------------------------------------------------------
DBCC CHECKIDENT ('Fines', RESEED, 0);
DBCC CHECKIDENT ('Reservations', RESEED, 0);
DBCC CHECKIDENT ('Loans', RESEED, 0);
-- Note: BookAuthors does not have an identity column.
DBCC CHECKIDENT ('Books', RESEED, 0);
DBCC CHECKIDENT ('Borrowers', RESEED, 0);
DBCC CHECKIDENT ('Authors', RESEED, 0);
DBCC CHECKIDENT ('Categories', RESEED, 0);
DBCC CHECKIDENT ('Publishers', RESEED, 0);
DBCC CHECKIDENT ('Staff', RESEED, 0);

------------------------------------------------------------
-- 4. Re-enable constraints
------------------------------------------------------------
ALTER TABLE Fines WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Reservations WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Loans WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE BookAuthors WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Books WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Borrowers WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Authors WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Categories WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Publishers WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Staff WITH CHECK CHECK CONSTRAINT ALL;

------------------------------------------------------------
-- 5. Insert Data in the correct order
------------------------------------------------------------

-- 5.1 Insert Publishers
INSERT INTO Publishers (Name, Address, Phone, Email) VALUES
('Penguin Random House', '1745 Broadway, New York, NY 10019', '212-782-9000', 'info@penguinrandomhouse.com'),
('HarperCollins', '195 Broadway, New York, NY 10007', '212-207-7000', 'contact@harpercollins.com'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', '212-698-7000', 'inquiries@simonandschuster.com'),
('Macmillan', '120 Broadway, New York, NY 10271', '646-307-5151', 'press@macmillan.com'),
('Hachette Book Group', '1290 Avenue of the Americas, New York, NY 10104', '212-364-1100', 'publicity@hbgusa.com'),
('Scholastic', '557 Broadway, New York, NY 10012', '212-343-6100', 'scholastic@scholastic.com'),
('Oxford University Press', '198 Madison Ave, New York, NY 10016', '800-445-9714', 'custserv.us@oup.com'),
('Cambridge University Press', '1 Liberty Plaza, New York, NY 10006', '212-337-5000', 'information@cambridge.org'),
('Wiley', '111 River St, Hoboken, NJ 07030', '201-748-6000', 'info@wiley.com'),
('Pearson', '330 Hudson St, New York, NY 10013', '800-848-9500', 'customer.service@pearson.com');

-- 5.2 Insert Categories
INSERT INTO Categories (Name, Description) VALUES
('Fiction', 'Novels and short stories'),
('Non-Fiction', 'Factual works and documentaries'),
('Science Fiction', 'Speculative fiction with scientific elements'),
('Fantasy', 'Imaginary worlds and magical elements'),
('Biography', 'Accounts of people''s lives'),
('History', 'Records of past events'),
('Science', 'Systematic study of the natural world'),
('Technology', 'Application of scientific knowledge'),
('Mystery', 'Works involving puzzles or crimes'),
('Romance', 'Love stories and relationships');

-- 5.3 Insert Authors
INSERT INTO Authors (FirstName, LastName, BirthYear, DeathYear, Biography) VALUES
('John', 'Smith', 1975, NULL, 'Contemporary fiction writer'),
('Emily', 'Johnson', 1982, NULL, 'Award-winning novelist'),
('Michael', 'Williams', 1960, NULL, 'Science fiction pioneer'),
('Sarah', 'Brown', 1955, 2020, 'Pulitzer Prize winning author'),
('David', 'Jones', 1948, NULL, 'Historical fiction specialist'),
('Jennifer', 'Garcia', 1978, NULL, 'Bestselling mystery writer'),
('Robert', 'Miller', 1965, NULL, 'Technical and scientific author'),
('Lisa', 'Davis', 1985, NULL, 'Young adult fiction writer'),
('Thomas', 'Rodriguez', 1970, NULL, 'Political commentator'),
('Amanda', 'Martinez', 1980, NULL, 'Romance novelist'),
('James', 'Hernandez', 1950, 2015, 'Literary fiction master'),
('Patricia', 'Lopez', 1968, NULL, 'Fantasy world builder'),
('Christopher', 'Gonzalez', 1972, NULL, 'Crime thriller writer'),
('Jessica', 'Wilson', 1988, NULL, 'Emerging science fiction voice'),
('Daniel', 'Anderson', 1940, 2010, 'Classic literature author'),
('Michelle', 'Taylor', 1975, NULL, 'Biography expert'),
('Matthew', 'Thomas', 1963, NULL, 'Military history writer'),
('Laura', 'Moore', 1982, NULL, 'Contemporary romance writer'),
('Kevin', 'Jackson', 1958, NULL, 'Science popularizer'),
('Stephanie', 'Lee', 1979, NULL, 'Cultural commentator');

-- 5.4 Insert Books (50 rows)
INSERT INTO Books (ISBN, Title, PublisherID, PublicationYear, Edition, CategoryID, ShelfLocation, TotalCopies, AvailableCopies) VALUES
('978-0451524935', '1984', 1, 1949, '1st Edition', 3, 'A101', 5, 5),
('978-0061120084', 'To Kill a Mockingbird', 2, 1960, '1st Edition', 1, 'A102', 3, 3),
('978-0743273565', 'The Great Gatsby', 3, 1925, '1st Edition', 1, 'A103', 4, 4),
('978-0547928227', 'The Hobbit', 4, 1937, '1st Edition', 4, 'B101', 6, 6),
('978-0439023481', 'The Hunger Games', 5, 2008, '1st Edition', 3, 'B102', 5, 5),
('978-0316769488', 'The Catcher in the Rye', 6, 1951, '1st Edition', 1, 'A104', 3, 3),
('978-0062315007', 'The Alchemist', 7, 1988, '1st Edition', 1, 'A105', 4, 4),
('978-0553418026', 'The Martian', 8, 2011, '1st Edition', 3, 'B103', 5, 5),
('978-0553803716', 'A Game of Thrones', 9, 1996, '1st Edition', 4, 'B104', 4, 4),
('978-0743477109', 'Romeo and Juliet', 10, 1597, '1st Edition', 1, 'A106', 3, 3),
('978-0307474278', 'The Da Vinci Code', 1, 2003, '1st Edition', 9, 'C101', 5, 5),
('978-0553293357', 'Foundation', 2, 1951, '1st Edition', 3, 'B105', 4, 4),
('978-0553103540', 'A Brief History of Time', 3, 1988, '1st Edition', 7, 'D101', 3, 3),
('978-0743273566', 'The Lean Startup', 4, 2011, '1st Edition', 8, 'D102', 4, 4),
('978-0062073564', 'The 7 Habits of Highly Effective People', 5, 1989, '1st Edition', 2, 'D103', 5, 5),
('978-0143105428', 'Steve Jobs', 6, 2011, '1st Edition', 5, 'E101', 3, 3),
('978-0062457714', 'The Subtle Art of Not Giving a F*ck', 7, 2016, '1st Edition', 2, 'D104', 4, 4),
('978-0385514231', 'Thinking, Fast and Slow', 8, 2011, '1st Edition', 2, 'D105', 5, 5),
('978-0553418027', 'The Power of Habit', 9, 2012, '1st Edition', 2, 'D106', 4, 4),
('978-1501127625', 'The Wright Brothers', 10, 2015, '1st Edition', 5, 'E102', 3, 3),
('978-0062316110', 'The Girl on the Train', 1, 2015, '1st Edition', 9, 'C102', 5, 5),
('978-0553418033', 'Gone Girl', 2, 2012, '1st Edition', 9, 'C103', 4, 4),
('978-0316017830', 'Twilight', 3, 2005, '1st Edition', 10, 'F101', 6, 6),
('978-0451169525', 'The Shining', 4, 1977, '1st Edition', 1, 'A107', 4, 4),
('978-0307743657', 'The Girl with the Dragon Tattoo', 5, 2005, '1st Edition', 9, 'C104', 5, 5),
('978-0553418028', 'The Silent Patient', 6, 2019, '1st Edition', 9, 'C105', 4, 4),
('978-0062073496', 'The Fault in Our Stars', 7, 2012, '1st Edition', 10, 'F102', 5, 5),
('978-0316042672', 'Water for Elephants', 8, 2006, '1st Edition', 1, 'A108', 3, 3),
('978-0061122415', 'The Notebook', 9, 1996, '1st Edition', 10, 'F103', 4, 4),
('978-0743477108', 'Pride and Prejudice', 10, 1813, '1st Edition', 1, 'A109', 5, 5),
-- FIXED: Use a unique ISBN for "The Book Thief"
('978-0375842207', 'The Book Thief', 1, 2005, '1st Edition', 1, 'A110', 4, 4),
('978-0545010221', 'Harry Potter and the Sorcerer''s Stone', 2, 1997, '1st Edition', 4, 'B106', 6, 6),
('978-0439554930', 'Harry Potter and the Chamber of Secrets', 3, 1998, '1st Edition', 4, 'B107', 5, 5),
('978-0439655484', 'Harry Potter and the Prisoner of Azkaban', 4, 1999, '1st Edition', 4, 'B108', 5, 5),
('978-0439362139', 'Harry Potter and the Goblet of Fire', 5, 2000, '1st Edition', 4, 'B109', 4, 4),
('978-0439554947', 'Harry Potter and the Order of the Phoenix', 6, 2003, '1st Edition', 4, 'B110', 4, 4),
('978-0439784542', 'Harry Potter and the Half-Blood Prince', 7, 2005, '1st Edition', 4, 'B111', 4, 4),
('978-0545139700', 'Harry Potter and the Deathly Hallows', 8, 2007, '1st Edition', 4, 'B112', 4, 4),
('978-0553418029', 'The Lord of the Rings', 9, 1954, '1st Edition', 4, 'B113', 5, 5),
('978-0553418030', 'The Chronicles of Narnia', 10, 1950, '1st Edition', 4, 'B114', 6, 6),
('978-0553418031', 'Dune', 1, 1965, '1st Edition', 3, 'B115', 4, 4),
('978-0553418032', 'Ender''s Game', 2, 1985, '1st Edition', 3, 'B116', 5, 5),
('978-0553418034', 'The Hitchhiker''s Guide to the Galaxy', 3, 1979, '1st Edition', 3, 'B117', 4, 4),
('978-0553418035', 'Brave New World', 4, 1932, '1st Edition', 3, 'B118', 3, 3),
('978-0553418036', 'Fahrenheit 451', 5, 1953, '1st Edition', 3, 'B119', 4, 4),
('978-0553418037', 'The Handmaid''s Tale', 6, 1985, '1st Edition', 3, 'B120', 5, 5),
('978-0553418038', 'Neuromancer', 7, 1984, '1st Edition', 3, 'B121', 4, 4),
('978-0553418039', 'Snow Crash', 8, 1992, '1st Edition', 3, 'B122', 4, 4),
('978-0553418040', 'The Stand', 9, 1978, '1st Edition', 1, 'A111', 5, 5),
('978-0553418041', 'It', 10, 1986, '1st Edition', 1, 'A112', 4, 4);

-- 5.5 Insert BookAuthors (assumes BookID = 1..50 and AuthorID = 1..20)
INSERT INTO BookAuthors (BookID, AuthorID) VALUES
(1, 3), (1, 5),
(2, 1), (2, 7),
(3, 2), (3, 8),
(4, 4), (4, 6), (4, 9),
(5, 10), (5, 12),
(6, 11), (6, 13),
(7, 14), (7, 15),
(8, 16), (8, 17), (8, 18),
(9, 19), (9, 20),
(10, 1), (10, 3),
(11, 2), (11, 4), (11, 5),
(12, 6), (12, 7),
(13, 8), (13, 9),
(14, 10), (14, 11), (14, 12),
(15, 13), (15, 14),
(16, 15), (16, 16),
(17, 17), (17, 18), (17, 19),
(18, 20), (18, 1),
(19, 2), (19, 3),
(20, 4), (20, 5), (20, 6),
(21, 7), (21, 8),
(22, 9), (22, 10),
(23, 11), (23, 12), (23, 13),
(24, 14), (24, 15),
(25, 16), (25, 17),
(26, 18), (26, 19), (26, 20),
(27, 1), (27, 2),
(28, 3), (28, 4),
(29, 5), (29, 6), (29, 7),
(30, 8), (30, 9),
(31, 10), (31, 11),
(32, 12), (32, 13), (32, 14),
(33, 15), (33, 16),
(34, 17), (34, 18),
(35, 19), (35, 20), (35, 1),
(36, 2), (36, 3),
(37, 4), (37, 5),
(38, 6), (38, 7), (38, 8),
(39, 9), (39, 10),
(40, 11), (40, 12),
(41, 13), (41, 14), (41, 15),
(42, 16), (42, 17),
(43, 18), (43, 19),
(44, 20), (44, 1), (44, 2),
(45, 3), (45, 4),
(46, 5), (46, 6),
(47, 7), (47, 8), (47, 9),
(48, 10), (48, 11),
(49, 12), (49, 13),
(50, 14), (50, 15), (50, 16);

-- 5.6 Insert Borrowers (30 rows)
INSERT INTO Borrowers (FirstName, LastName, Email, Phone, Address, MembershipDate, MembershipExpiry, Status)
VALUES
('John', 'Smith', 'john.smith1@example.com', '555-123-4567', '123 Main St, New York, NY 10001', '2023-01-15', '2024-01-15', 'Active'),
('Emily', 'Johnson', 'emily.johnson2@example.com', '555-234-5678', '456 Oak Ave, Los Angeles, CA 90001', '2023-02-20', '2024-02-20', 'Active'),
('Michael', 'Williams', 'michael.williams3@example.com', '555-345-6789', '789 Pine Rd, Chicago, IL 60601', '2023-03-10', '2024-03-10', 'Active'),
('Sarah', 'Brown', 'sarah.brown4@example.com', '555-456-7890', '101 Maple Dr, Houston, TX 77001', '2023-04-05', '2024-04-05', 'Active'),
('David', 'Jones', 'david.jones5@example.com', '555-567-8901', '202 Cedar Ln, Phoenix, AZ 85001', '2023-05-12', '2024-05-12', 'Active'),
('Jennifer', 'Garcia', 'jennifer.garcia6@example.com', '555-678-9012', '303 Elm St, New York, NY 10002', '2023-06-18', '2024-06-18', 'Active'),
('Robert', 'Miller', 'robert.miller7@example.com', '555-789-0123', '404 Birch Ave, Los Angeles, CA 90002', '2023-07-22', '2024-07-22', 'Active'),
('Lisa', 'Davis', 'lisa.davis8@example.com', '555-890-1234', '505 Spruce Rd, Chicago, IL 60602', '2023-08-30', '2024-08-30', 'Active'),
('Thomas', 'Rodriguez', 'thomas.rodriguez9@example.com', '555-901-2345', '606 Willow Dr, Houston, TX 77002', '2023-09-14', '2024-09-14', 'Active'),
('Amanda', 'Martinez', 'amanda.martinez10@example.com', '555-012-3456', '707 Oak Ln, Phoenix, AZ 85002', '2023-10-25', '2024-10-25', 'Active'),
('James', 'Hernandez', 'james.hernandez11@example.com', '555-123-4568', '808 Pine St, New York, NY 10003', '2023-11-05', '2024-11-05', 'Active'),
('Patricia', 'Lopez', 'patricia.lopez12@example.com', '555-234-5679', '909 Maple Ave, Los Angeles, CA 90003', '2023-12-10', '2024-12-10', 'Active'),
('Christopher', 'Gonzalez', 'christopher.gonzalez13@example.com', '555-345-6780', '111 Cedar Rd, Chicago, IL 60603', '2024-01-15', '2025-01-15', 'Active'),
('Jessica', 'Wilson', 'jessica.wilson14@example.com', '555-456-7891', '222 Elm Dr, Houston, TX 77003', '2024-02-20', '2025-02-20', 'Active'),
('Daniel', 'Anderson', 'daniel.anderson15@example.com', '555-567-8902', '333 Birch Ln, Phoenix, AZ 85003', '2024-03-10', '2025-03-10', 'Active'),
('Michelle', 'Taylor', 'michelle.taylor16@example.com', '555-678-9013', '444 Spruce St, New York, NY 10004', '2024-04-05', '2025-04-05', 'Active'),
('Matthew', 'Thomas', 'matthew.thomas17@example.com', '555-789-0124', '555 Willow Ave, Los Angeles, CA 90004', '2024-05-12', '2025-05-12', 'Active'),
('Laura', 'Moore', 'laura.moore18@example.com', '555-890-1235', '666 Oak Rd, Chicago, IL 60604', '2024-06-18', '2025-06-18', 'Active'),
('Kevin', 'Jackson', 'kevin.jackson19@example.com', '555-901-2346', '777 Pine Dr, Houston, TX 77004', '2024-07-22', '2025-07-22', 'Active'),
('Stephanie', 'Lee', 'stephanie.lee20@example.com', '555-012-3457', '888 Maple Ln, Phoenix, AZ 85004', '2024-08-30', '2025-08-30', 'Active'),
('Richard', 'Perez', 'richard.perez21@example.com', '555-123-4569', '999 Cedar St, New York, NY 10005', '2024-09-14', '2025-09-14', 'Active'),
('Kimberly', 'White', 'kimberly.white22@example.com', '555-234-5670', '1010 Elm Ave, Los Angeles, CA 90005', '2024-10-25', '2025-10-25', 'Active'),
('Joseph', 'Harris', 'joseph.harris23@example.com', '555-345-6781', '1212 Birch Rd, Chicago, IL 60605', '2024-11-05', '2025-11-05', 'Active'),
('Angela', 'Clark', 'angela.clark24@example.com', '555-456-7892', '1313 Spruce Dr, Houston, TX 77005', '2024-12-10', '2025-12-10', 'Active'),
('Charles', 'Lewis', 'charles.lewis25@example.com', '555-567-8903', '1414 Willow Ln, Phoenix, AZ 85005', '2025-01-15', '2026-01-15', 'Active'),
('Melissa', 'Robinson', 'melissa.robinson26@example.com', '555-678-9014', '1515 Oak St, New York, NY 10006', '2025-02-20', '2026-02-20', 'Active'),
('Steven', 'Walker', 'steven.walker27@example.com', '555-789-0125', '1616 Pine Ave, Los Angeles, CA 90006', '2025-03-10', '2026-03-10', 'Active'),
('Amanda', 'Young', 'amanda.young28@example.com', '555-890-1236', '1717 Maple Rd, Chicago, IL 60606', '2025-04-05', '2026-04-05', 'Active'),
('Timothy', 'Allen', 'timothy.allen29@example.com', '555-901-2347', '1818 Cedar Dr, Houston, TX 77006', '2025-05-12', '2026-05-12', 'Active'),
('Christine', 'King', 'christine.king30@example.com', '555-012-3458', '1919 Elm Ln, Phoenix, AZ 85006', '2025-06-18', '2026-06-18', 'Active');

-- 5.7 Insert Loans (100 rows)
INSERT INTO Loans (BookID, BorrowerID, LoanDate, DueDate, ReturnDate, Status) VALUES
(1, 1, '2024-01-10', '2024-01-24', '2024-01-20', 'Returned'),
(2, 2, '2024-01-15', '2024-01-29', '2024-01-25', 'Returned'),
(3, 3, '2024-02-05', '2024-02-19', '2024-02-15', 'Returned'),
(4, 4, '2024-02-10', '2024-02-24', '2024-02-20', 'Returned'),
(5, 5, '2024-03-01', '2024-03-15', '2024-03-10', 'Returned'),
(6, 6, '2024-03-10', '2024-03-24', '2024-03-20', 'Returned'),
(7, 7, '2024-04-05', '2024-04-19', '2024-04-15', 'Returned'),
(8, 8, '2024-04-10', '2024-04-24', '2024-04-20', 'Returned'),
(9, 9, '2024-05-01', '2024-05-15', '2024-05-10', 'Returned'),
(10, 10, '2024-05-10', '2024-05-24', '2024-05-20', 'Returned'),
(11, 11, '2024-06-05', '2024-06-19', '2024-06-15', 'Returned'),
(12, 12, '2024-06-10', '2024-06-24', '2024-06-20', 'Returned'),
(13, 13, '2024-07-01', '2024-07-15', '2024-07-10', 'Returned'),
(14, 14, '2024-07-10', '2024-07-24', '2024-07-20', 'Returned'),
(15, 15, '2024-08-05', '2024-08-19', '2024-08-15', 'Returned'),
(16, 16, '2024-08-10', '2024-08-24', '2024-08-20', 'Returned'),
(17, 17, '2024-09-01', '2024-09-15', '2024-09-10', 'Returned'),
(18, 18, '2024-09-10', '2024-09-24', '2024-09-20', 'Returned'),
(19, 19, '2024-10-05', '2024-10-19', '2024-10-15', 'Returned'),
(20, 20, '2024-10-10', '2024-10-24', '2024-10-20', 'Returned'),
(21, 1, '2024-01-20', '2024-02-03', NULL, 'Overdue'),
(22, 2, '2024-01-25', '2024-02-08', NULL, 'Overdue'),
(23, 3, '2024-02-15', '2024-02-29', NULL, 'Overdue'),
(24, 4, '2024-02-20', '2024-03-05', NULL, 'Overdue'),
(25, 5, '2024-03-10', '2024-03-24', NULL, 'Overdue'),
(26, 6, '2024-03-20', '2024-04-03', NULL, 'Overdue'),
(27, 7, '2024-04-15', '2024-04-29', NULL, 'Overdue'),
(28, 8, '2024-04-20', '2024-05-04', NULL, 'Overdue'),
(29, 9, '2024-05-10', '2024-05-24', NULL, 'Overdue'),
(30, 10, '2024-05-20', '2024-06-03', NULL, 'Overdue'),
(31, 11, '2024-06-15', '2024-06-29', NULL, 'Overdue'),
(32, 12, '2024-06-20', '2024-07-04', NULL, 'Overdue'),
(33, 13, '2024-07-10', '2024-07-24', NULL, 'Overdue'),
(34, 14, '2024-07-20', '2024-08-03', NULL, 'Overdue'),
(35, 15, '2024-08-15', '2024-08-29', NULL, 'Overdue'),
(36, 16, '2024-08-20', '2024-09-03', NULL, 'Overdue'),
(37, 17, '2024-09-10', '2024-09-24', NULL, 'Overdue'),
(38, 18, '2024-09-20', '2024-10-04', NULL, 'Overdue'),
(39, 19, '2024-10-15', '2024-10-29', NULL, 'Overdue'),
(40, 20, '2024-10-20', '2024-11-03', NULL, 'Overdue'),
(41, 1, '2024-01-05', '2024-01-19', '2024-01-15', 'Returned'),
(42, 2, '2024-01-10', '2024-01-24', '2024-01-20', 'Returned'),
(43, 3, '2024-02-01', '2024-02-15', '2024-02-10', 'Returned'),
(44, 4, '2024-02-10', '2024-02-24', '2024-02-20', 'Returned'),
(45, 5, '2024-03-05', '2024-03-19', '2024-03-15', 'Returned'),
(46, 6, '2024-03-10', '2024-03-24', '2024-03-20', 'Returned'),
(47, 7, '2024-04-01', '2024-04-15', '2024-04-10', 'Returned'),
(48, 8, '2024-04-10', '2024-04-24', '2024-04-20', 'Returned'),
(49, 9, '2024-05-05', '2024-05-19', '2024-05-15', 'Returned'),
(50, 10, '2024-05-10', '2024-05-24', '2024-05-20', 'Returned'),
(1, 11, '2024-06-01', '2024-06-15', '2024-06-10', 'Returned'),
(2, 12, '2024-06-10', '2024-06-24', '2024-06-20', 'Returned'),
(3, 13, '2024-07-05', '2024-07-19', '2024-07-15', 'Returned'),
(4, 14, '2024-07-10', '2024-07-24', '2024-07-20', 'Returned'),
(5, 15, '2024-08-01', '2024-08-15', '2024-08-10', 'Returned'),
(6, 16, '2024-08-10', '2024-08-24', '2024-08-20', 'Returned'),
(7, 17, '2024-09-05', '2024-09-19', '2024-09-15', 'Returned'),
(8, 18, '2024-09-10', '2024-09-24', '2024-09-20', 'Returned'),
(9, 19, '2024-10-01', '2024-10-15', '2024-10-10', 'Returned'),
(10, 20, '2024-10-10', '2024-10-24', '2024-10-20', 'Returned'),
(11, 1, '2024-01-15', '2024-01-29', NULL, 'Overdue'),
(12, 2, '2024-01-20', '2024-02-03', NULL, 'Overdue'),
(13, 3, '2024-02-10', '2024-02-24', NULL, 'Overdue'),
(14, 4, '2024-02-15', '2024-03-01', NULL, 'Overdue'),
(15, 5, '2024-03-10', '2024-03-24', NULL, 'Overdue'),
(16, 6, '2024-03-15', '2024-03-29', NULL, 'Overdue'),
(17, 7, '2024-04-10', '2024-04-24', NULL, 'Overdue'),
(18, 8, '2024-04-15', '2024-04-29', NULL, 'Overdue'),
(19, 9, '2024-05-10', '2024-05-24', NULL, 'Overdue'),
(20, 10, '2024-05-15', '2024-05-29', NULL, 'Overdue'),
(21, 11, '2024-06-10', '2024-06-24', NULL, 'Overdue'),
(22, 12, '2024-06-15', '2024-06-29', NULL, 'Overdue'),
(23, 13, '2024-07-10', '2024-07-24', NULL, 'Overdue'),
(24, 14, '2024-07-15', '2024-07-29', NULL, 'Overdue'),
(25, 15, '2024-08-10', '2024-08-24', NULL, 'Overdue'),
(26, 16, '2024-08-15', '2024-08-29', NULL, 'Overdue'),
(27, 17, '2024-09-10', '2024-09-24', NULL, 'Overdue'),
(28, 18, '2024-09-15', '2024-09-29', NULL, 'Overdue'),
(29, 19, '2024-10-10', '2024-10-24', NULL, 'Overdue'),
(30, 20, '2024-10-15', '2024-10-29', NULL, 'Overdue'),
(31, 1, '2024-01-01', '2024-01-15', '2024-01-10', 'Returned'),
(32, 2, '2024-01-05', '2024-01-19', '2024-01-15', 'Returned'),
(33, 3, '2024-02-01', '2024-02-15', '2024-02-10', 'Returned'),
(34, 4, '2024-02-05', '2024-02-19', '2024-02-15', 'Returned'),
(35, 5, '2024-03-01', '2024-03-15', '2024-03-10', 'Returned'),
(36, 6, '2024-03-05', '2024-03-19', '2024-03-15', 'Returned'),
(37, 7, '2024-04-01', '2024-04-15', '2024-04-10', 'Returned'),
(38, 8, '2024-04-05', '2024-04-19', '2024-04-15', 'Returned'),
(39, 9, '2024-05-01', '2024-05-15', '2024-05-10', 'Returned'),
(40, 10, '2024-05-05', '2024-05-19', '2024-05-15', 'Returned');

-- 5.8 Update AvailableCopies based on open Loans
UPDATE Books
SET AvailableCopies = TotalCopies - (
    SELECT COUNT(*) 
    FROM Loans 
    WHERE Loans.BookID = Books.BookID 
      AND Loans.ReturnDate IS NULL
);

-- 5.9 Insert Fines for Overdue Loans (using GETDATE() for current date)
INSERT INTO Fines (LoanID, Amount, IssueDate, PaymentDate, Status)
SELECT 
    LoanID,
    DATEDIFF(DAY, DueDate, GETDATE()) * 0.5,
    DATEADD(DAY, 1, DueDate),
    CASE WHEN RAND() > 0.7 THEN DATEADD(DAY, CAST(FLOOR(RAND()*30)+1 AS INT), DueDate) ELSE NULL END,
    CASE WHEN RAND() > 0.7 THEN 'Paid' ELSE 'Pending' END
FROM Loans
WHERE Status = 'Overdue'
  AND DATEDIFF(DAY, DueDate, GETDATE()) > 0;

-- 5.10 Insert Reservations (20 rows)
INSERT INTO Reservations (BookID, BorrowerID, ReservationDate, ExpirationDate, Status)
VALUES
(1, 11, '2024-01-05', '2024-01-12', 'Fulfilled'),
(2, 12, '2024-01-10', '2024-01-17', 'Fulfilled'),
(3, 13, '2024-02-01', '2024-02-08', 'Fulfilled'),
(4, 14, '2024-02-05', '2024-02-12', 'Fulfilled'),
(5, 15, '2024-03-01', '2024-03-08', 'Fulfilled'),
(6, 16, '2024-03-05', '2024-03-12', 'Fulfilled'),
(7, 17, '2024-04-01', '2024-04-08', 'Fulfilled'),
(8, 18, '2024-04-05', '2024-04-12', 'Fulfilled'),
(9, 19, '2024-05-01', '2024-05-08', 'Fulfilled'),
(10, 20, '2024-05-05', '2024-05-12', 'Fulfilled'),
(11, 1, '2024-06-01', '2024-06-08', 'Cancelled'),
(12, 2, '2024-06-05', '2024-06-12', 'Cancelled'),
(13, 3, '2024-07-01', '2024-07-08', 'Expired'),
(14, 4, '2024-07-05', '2024-07-12', 'Expired'),
(15, 5, '2024-08-01', '2024-08-08', 'Pending'),
(16, 6, '2024-08-05', '2024-08-12', 'Pending'),
(17, 7, '2024-09-01', '2024-09-08', 'Pending'),
(18, 8, '2024-09-05', '2024-09-12', 'Pending'),
(19, 9, '2024-10-01', '2024-10-08', 'Pending'),
(20, 10, '2024-10-05', '2024-10-12', 'Pending');

-- 5.11 Insert Staff
INSERT INTO Staff (FirstName, LastName, Email, Phone, Position, HireDate, Username, PasswordHash, AccessLevel)
VALUES
('Admin', 'User', 'admin@library.com', '555-100-1000', 'System Administrator', '2020-01-15', 'admin', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'admin123'), 2), 'Admin'),
('Sarah', 'Librarian', 'sarah@library.com', '555-200-2000', 'Head Librarian', '2019-05-20', 'slibrarian', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'library123'), 2), 'Librarian'),
('Mike', 'Assistant', 'mike@library.com', '555-300-3000', 'Library Assistant', '2021-03-10', 'massistant', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'assistant1'), 2), 'Assistant'),
('Emily', 'Clerk', 'emily@library.com', '555-400-4000', 'Circulation Clerk', '2022-01-05', 'eclerk', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'clerk456'), 2), 'Assistant'),
('David', 'Technician', 'david@library.com', '555-500-5000', 'IT Technician', '2020-11-15', 'dtech', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'tech789'), 2), 'Librarian');

------------------------------------------------------------
-- 6. Final message:
------------------------------------------------------------
PRINT 'Data loaded successfully without foreign key errors.';
