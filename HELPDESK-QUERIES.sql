-- Retrieve all open support tickets
SELECT *
FROM Support_Ticket
WHERE Status = 2;

-- Retrieve all high urgency incidents
SELECT *
FROM Incident_Report
WHERE Urgency = 3;

-- Retrieve the IDs and names of all roles except for the role 'Administrator'
SELECT r.ID, r.Role_name
FROM Role r
WHERE r.Role_name <> 'Administrator';

-- Count the number of support tickets for each status
SELECT Status, COUNT(*) AS Ticket_Count
FROM Support_Ticket
GROUP BY Status;

-- Find the maximum years of experience among technicians
SELECT MAX(Years_Of_Experience) AS Max_Experience
FROM Technician;

-- Retrieve all technicians who are assigned to a support ticket
SELECT *
FROM Technician
WHERE ID IN
      (SELECT Technician
       FROM Support_Ticket);

-- Retrieve all active support tickets along with the names of technicians assigned to them
SELECT ID, Type, Description, Resolution,
       (SELECT Name
        FROM Technician
            JOIN PERSON PERSON on TECHNICIAN.PESEL = PERSON.PESEL
        WHERE ID = Support_Ticket.Technician) AS Technician_Name
FROM Support_Ticket
WHERE Status = 2;

-- Retrieve the details of all active tickets along with their urgency level:
SELECT s.Name AS Ticket_Status, u."Level" AS Urgency_Level
FROM Support_Ticket st
    JOIN Status s ON st.Status = s.ID
    JOIN Urgency u ON st.Urgency = u.ID
WHERE s.Is_Active = 'Y';

-- Retrieve the usernames and departments of all users who have submitted a support ticket:
SELECT u.Username, u.Department
FROM "User" u
    JOIN Support_Ticket st ON u.ID = st."User";

-- Retrieve the description and time spent resolving issue
-- for support tickets assigned to technicians with more than 5 years of experience
SELECT st.Description, st.Time_Spent_Resolving_Issue
FROM Support_Ticket st
    JOIN Technician t ON st.Technician = t.ID
WHERE t.Years_Of_Experience > 5;

-- Trigger to update the Updated_At column in Status table before inserting a new row
CREATE OR REPLACE TRIGGER before_insert_status
BEFORE INSERT ON Status
FOR EACH ROW
BEGIN
  :NEW.Updated_At := CURRENT_TIMESTAMP;
END;
/

-- Trigger to calculate the total amount for an expense report before inserting a new row
CREATE OR REPLACE TRIGGER before_insert_expense_report
BEFORE INSERT ON Expense_Report
FOR EACH ROW
BEGIN
  :NEW.Total_Amount := (SELECT SUM(Purchase_Price) FROM IT_Asset);
END;
/
-- Trigger to update the Updated_At field in the Status table when the Status column is updated in the Support_Ticket table.
CREATE OR REPLACE TRIGGER Update_Ticket_Status
AFTER UPDATE OF Status ON Support_Ticket
FOR EACH ROW
BEGIN
    UPDATE Status
    SET Updated_At = CURRENT_TIMESTAMP
    WHERE ID = :NEW.Status;
END;
/

-- Trigger to display a message when a support ticket is inserted into the Support_Ticket table.
CREATE OR REPLACE TRIGGER trg_after_insert_support_ticket
AFTER INSERT ON Support_Ticket
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Support ticket inserted with ID: ' || :NEW.ID);
END;
/
