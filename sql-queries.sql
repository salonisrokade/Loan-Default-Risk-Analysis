SQL QUERIES

-- ===============================
--  Load data in SQL table
-- ===============================
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/Loan_Default.csv"'
INTO TABLE loan_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '/n'
IGNORE 1 ROWS;


Initial Exploration

-- ===============================
1.  Count of Defaults
-- ===============================
SELECT status, COUNT(*) AS total FROM loan_data GROUP BY status;


-- ========================================
2.  Avg Loan amount by Status (Default flag)
-- ========================================
SELECT status, AVG(loan_amount) FROM loan_data GROUP BY status;


-- ===============================
3.  Default Rate by Region
-- ===============================
SELECT 
	region, 
    	COUNT(*) AS total_loans, 
    	SUM(status = 1) AS defaults, 
    	ROUND(SUM(status = 1)/COUNT(*)*100,2) AS default_rate 
FROM loan_data 
GROUP BY region 
ORDER BY default_rate DESC;


-- ===============================
4.  Default Rate by Age Group
-- ===============================
SELECT 
	age, 
    	COUNT(*) AS total_loans, 
    	SUM(status = 1) AS defaults,
    	ROUND(SUM(status = 1)/ COUNT(*)*100,2) AS default_rate_percent 
FROM loan_data 
GROUP BY age 
ORDER BY default_rate_percent DESC;


-- ===============================
5.  Default Rate by Income Bracket
-- ===============================
SELECT 
	CASE 
    	WHEN income < 30000 THEN '<30K' 
    	WHEN income BETWEEN 30000 AND 60000 THEN '30K-60K' 
    	WHEN income BETWEEN 60000 AND 100000 THEN '60K-100K' ELSE '>100K' 
    	END AS income_bracket, 
	COUNT(*) AS total_loans, 
    	SUM(status = 1 ) AS defaults, 
    	ROUND(SUM(status = 1)/COUNT(*) * 100,2) AS default_rate 
FROM loan_data 
GROUP BY income_bracket 
ORDER BY default_rate DESC;


-- ===============================
6. Default Rate by Credit Scores
-- ===============================
SELECT 
	CASE 
    	WHEN credit_score < 600 THEN 'Poor (<600)' 
    	WHEN credit_score BETWEEN 600 AND 699 THEN 'Fair (600-699)' 
    	WHEN credit_score BETWEEN 700 AND 749 THEN 'Good (700-749)' 
    	ELSE 'Excellent (750+)' 
    	END AS credit_score_range, 
    	COUNT(*) AS total_loans, 
    	SUM(status = 1) AS defaults, 
    	ROUND(SUM(status = 1)/COUNT(*) *100,2) AS default_rate 
FROM loan_data 
WHERE credit_score IS NOT NULL 
GROUP BY credit_score_range 
ORDER BY default_rate DESC;


-- ===============================
7. Default Rate by LTV Bucket
-- ===============================
SELECT 
	CASE 
    	WHEN ltv < 80 THEN 'Low (<80)' 
    	WHEN ltv BETWEEN 80 AND 90 THEN 'Moderate (80-90)' 
    	ELSE 'High (>90)' 
    	END AS ltv_range, 
    	COUNT(*) AS total_loans, 
    	SUM(status = 1) AS defaults, 
    	ROUND(SUM(status = 1)/COUNT(*) *100,2) AS default_rate 
FROM loan_data 
WHERE ltv IS NOT NULL 
GROUP BY ltv_range 
ORDER BY default_rate DESC;


-- ===============================
8.  Default Rate by Loan Purpose
-- ===============================
SELECT 
	loan_purpose, 
    	COUNT(*) AS total_loans, 
    	SUM(status = 1) AS defaults,
    	ROUND(SUM(status =1)/COUNT(*)*100,2) AS default_rate 
FROM loan_data 
GROUP BY loan_purpose 
ORDER BY default_rate DESC;


-- ======================================
9.  Default Rate by Debt-To-Income Range
-- ======================================
SELECT 
	CASE 
    	WHEN dtir1 <20 THEN '<20' 
    	WHEN dtir1 BETWEEN 20 AND 35 THEN '20-35' ELSE '>35' 
    	END AS dti_range, 
    	COUNT(*) AS total_loans, 
   	 SUM(status = 1) AS defaults, 
    	ROUND(SUM(status = 1)/COUNT(*) *100,2) AS default_rate 
FROM loan_data 
GROUP BY dti_range 
ORDER BY default_rate DESC;

