-- Description of tables
describe Customers;
describe Loans;
describe Transactions;
describe BankBranches;

-- Displaying tables
select * from Customers;
select * from Loans;
select * from Transactions;
select * from BankBranches;

-- Applying complex queries on tables
-- 1. Calculate Total EMI Paid for Each Loan
    SELECT 
    Loan_ID,
    SUM(CASE WHEN Payment_Type = 'EMI' THEN Amount ELSE 0 END) AS Total_EMI_Paid
    FROM 
    Transactions
    GROUP BY 
    Loan_ID;

-- 2. Calculate Outstanding Balance for Each Loan
    SELECT 
    l.Loan_ID,
    l.Principal_Amount - COALESCE(SUM(t.Amount), 0) AS Outstanding_Balance
    FROM 
    Loans l
    LEFT JOIN 
    Transactions t ON l.Loan_ID = t.Loan_ID
    GROUP BY 
    l.Loan_ID, l.Principal_Amount;

-- 3. Generate EMI Schedule for a Loan
    SELECT 
    l.Loan_ID,
    l.Start_Date,
    DATE_ADD(l.Start_Date, INTERVAL n MONTH) AS EMI_Due_Date,
    l.EMI_Amount
    FROM 
    Loans l
    CROSS JOIN 
    (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS numbers
    WHERE 
    Loan_ID = 1
    AND DATE_ADD(l.Start_Date, INTERVAL n MONTH) <= l.End_Date;


-- 4. Calculate Total Interest Collected for Each Loan
    SELECT 
    l.Loan_ID,
    SUM(t.Amount) - l.Principal_Amount AS Total_Interest_Collected
    FROM 
    Loans l
    JOIN 
    Transactions t ON l.Loan_ID = t.Loan_ID
    GROUP BY 
    l.Loan_ID, l.Principal_Amount;





-- Note:- All the output images for these will be provided.


