--(1)Create Customers table
         CREATE TABLE Customers (
             CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255)
);

--(2) Create Loans table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    LoanType VARCHAR(50),
    PrincipalAmount DECIMAL(15, 2),
    InterestRate DECIMAL(5, 2),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

--(3)Create Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    LoanID INT,
    PaymentDate DATE,
    Amount DECIMAL(15, 2),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

--(4)Calculate monthly interest for each loan
SELECT 
    LoanID,
    PrincipalAmount,
    InterestRate,
    (PrincipalAmount * (InterestRate / 100) / 12) AS MonthlyInterest
FROM 
    Loans;
--(5) Insert a payment record for a loan
INSERT INTO Payments (PaymentID, LoanID, PaymentDate, Amount)
VALUES (1, 101, '2025-01-12', 5000.00);
-- Generate a report of payments for a specific loan
SELECT 
    p.PaymentID, 
    p.PaymentDate, 
    p.Amount, 
    l.LoanType, 
    l.PrincipalAmount
FROM 
    Payments p
JOIN 
    Loans l ON p.LoanID = l.LoanID
WHERE 
    l.LoanID = 101;
