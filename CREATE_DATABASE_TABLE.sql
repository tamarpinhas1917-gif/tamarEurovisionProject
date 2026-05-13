-- SQL Script to create personalData table
-- Run this in SQL Server Management Studio or Visual Studio's SQL Server Object Explorer

CREATE TABLE personalData (
    idnum VARCHAR(20) PRIMARY KEY,      -- User ID (unique identifier)
    fname NVARCHAR(50) NULL,            -- First Name (supports Hebrew)
    lname NVARCHAR(50) NULL,            -- Last Name (supports Hebrew)
    pass VARCHAR(50) NULL,              -- Password
    area NVARCHAR(50) NULL,             -- Region: מרכז, צפון, דרום
    isAdmin BIT NULL                    -- Admin flag: 0=user, 1=admin
);

-- Optional: Create some test data
-- INSERT INTO personalData (idnum, fname, lname, pass, area, isAdmin) 
-- VALUES ('123456789', N'תמר', N'פינחס', 'password123', N'מרכז', 0);
-- INSERT INTO personalData (idnum, fname, lname, pass, area, isAdmin) 
-- VALUES ('987654321', N'מנהל', N'מערכת', 'admin123', N'מרכז', 1);

