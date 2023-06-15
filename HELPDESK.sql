-- Table: Status
CREATE TABLE Status (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    Description varchar2(255)  NOT NULL,
    Is_Active char(1)  NOT NULL,
    Created_At timestamp  NOT NULL,
    Updated_At timestamp  NULL,
    CONSTRAINT Status_pk PRIMARY KEY (ID)
) ;

-- Insertion Status
INSERT INTO Status (ID, Name, Description, Is_Active, Created_At, Updated_At)
VALUES (1, 'Open', 'Task or ticket is open', 'Y', TIMESTAMP '2023-05-12 10:31:56', NULL);

INSERT INTO Status (ID, Name, Description, Is_Active, Created_At, Updated_At)
VALUES (2, 'Closed', 'Task or ticket is closed', 'Y', TIMESTAMP '2023-05-12 10:31:56', NULL);

-- Table: Urgency
CREATE TABLE Urgency (
    ID integer  NOT NULL,
    "Level" varchar2(6)  NOT NULL,
    Response_Time varchar2(50)  NOT NULL,
    Escalation_Path varchar2(255)  NOT NULL,
    CONSTRAINT Urgency_pk PRIMARY KEY (ID)
) ;

-- Insertion Urgency
INSERT INTO Urgency (ID, "Level", Response_Time, Escalation_Path)
VALUES (1, 'Low', '24 hours', 'Level 1 escalation path');

INSERT INTO Urgency (ID, "Level", Response_Time, Escalation_Path)
VALUES (2, 'Medium', '12 hours', 'Level 2 escalation path');

INSERT INTO Urgency (ID, "Level", Response_Time, Escalation_Path)
VALUES (3, 'High', '1 hour', 'Level 3 escalation path');

-- Table: Person
CREATE TABLE Person (
    PESEL integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    Surname varchar2(50)  NOT NULL,
    DOB date  NOT NULL,
    Gender char(1)  NOT NULL,
    Email varchar2(50)  NOT NULL,
    Phone integer  NOT NULL,
    Address varchar2(50)  NOT NULL,
    CONSTRAINT Person_pk PRIMARY KEY (PESEL)
) ;

-- Insertion Person
INSERT INTO Person (PESEL, Name, Surname, DOB, Gender, Email, Phone, Address)
VALUES (1234567890, 'John', 'Doe', DATE '1990-01-01', 'M', 'john.doe@example.com', 1234567890, '123 Main Street');

INSERT INTO Person (PESEL, Name, Surname, DOB, Gender, Email, Phone, Address)
VALUES (9876543210, 'Jane', 'Smith', DATE '1995-05-10', 'F', 'jane.smith@example.com', 9876543210, '456 Elm Street');

INSERT INTO Person (PESEL, Name, Surname, DOB, Gender, Email, Phone, Address)
VALUES (5555555555, 'Michael', 'Johnson', DATE '1985-12-15', 'M', 'michael.johnson@example.com', 5555555555, '789 Oak Avenue');

-- Table: Technician
CREATE TABLE Technician (
    ID integer  NOT NULL,
    Skills varchar2(255)  NOT NULL,
    Years_Of_Experience integer  NOT NULL,
    Availability varchar2(75)  NOT NULL,
    PESEL integer  NOT NULL,
    CONSTRAINT Technician_pk PRIMARY KEY (ID)
) ;

-- Reference: Technicians_Person_ (table: Technician)
ALTER TABLE Technician ADD CONSTRAINT Technicians_Person_
    FOREIGN KEY (PESEL)
    REFERENCES Person (PESEL);

-- Insertion Technician
INSERT INTO Technician (ID, Skills, Years_Of_Experience, Availability, PESEL)
VALUES (1, 'Skillset 1', 5, 'Available', 1234567890);

INSERT INTO Technician (ID, Skills, Years_Of_Experience, Availability, PESEL)
VALUES (2, 'Skillset 2', 3, 'Available', 9876543210);

INSERT INTO Technician (ID, Skills, Years_Of_Experience, Availability, PESEL)
VALUES (3, 'Skillset 3', 8, 'Available', 5555555555);

-- Table: IT_Asset
CREATE TABLE IT_Asset (
    ID integer  NOT NULL,
    Serial_Number integer  NOT NULL,
    Purchase_Date date  NOT NULL,
    Purchase_Price integer  NOT NULL,
    Location varchar2(255)  NOT NULL,
    Maintenance_Schedule date  NOT NULL,
    CONSTRAINT IT_Asset_pk PRIMARY KEY (ID)
) ;

-- Insertion IT Asset
INSERT INTO IT_Asset (ID, Serial_Number, Purchase_Date, Purchase_Price, Location, Maintenance_Schedule)
VALUES (1, 12345, DATE '2022-01-15', 1500, 'Office A', DATE '2023-06-15');

INSERT INTO IT_Asset (ID, Serial_Number, Purchase_Date, Purchase_Price, Location, Maintenance_Schedule)
VALUES (2, 54321, DATE '2021-09-10', 2000, 'Office B', DATE '2023-07-20');

INSERT INTO IT_Asset (ID, Serial_Number, Purchase_Date, Purchase_Price, Location, Maintenance_Schedule)
VALUES (3, 98765, DATE '2023-03-05', 1000, 'Office C', DATE '2024-01-10');

-- Table: Role
CREATE TABLE Role (
    ID integer  NOT NULL,
    Role_name varchar2(50)  NOT NULL,
    CONSTRAINT Role_pk PRIMARY KEY (ID)
) ;

-- Insertion Role
INSERT INTO Role (ID, Role_name)
VALUES (1, 'Administrator');

INSERT INTO Role (ID, Role_name)
VALUES (2, 'Technician');

INSERT INTO Role (ID, Role_name)
VALUES (3, 'User');

-- Table: Technicians_Assets_List
CREATE TABLE Technicians_Assets_List (
    IT_Asset integer  NOT NULL,
    Technician integer  NOT NULL,
    CONSTRAINT Technicians_Assets_List_pk PRIMARY KEY (IT_Asset,Technician)
) ;

-- Reference: Technicians_Assets_List (table: Technicians_Assets_List)
ALTER TABLE Technicians_Assets_List ADD CONSTRAINT Technicians_Assets_List
    FOREIGN KEY (IT_Asset)
    REFERENCES IT_Asset (ID);

-- Reference: Technicians_Assets_List_ (table: Technicians_Assets_List)
ALTER TABLE Technicians_Assets_List ADD CONSTRAINT Technicians_Assets_List_
    FOREIGN KEY (Technician)
    REFERENCES Technician (ID);

-- Insertion Technicians Assets List
INSERT INTO Technicians_Assets_List (IT_Asset, Technician)
VALUES (1, 1);

INSERT INTO Technicians_Assets_List (IT_Asset, Technician)
VALUES (2, 2);

INSERT INTO Technicians_Assets_List (IT_Asset, Technician)
VALUES (3, 3);

-- Table: User
CREATE TABLE "User" (
    ID integer  NOT NULL,
    Username varchar2(255)  NOT NULL,
    Password varchar2(255)  NOT NULL,
    Department varchar2(255)  NOT NULL,
    PESEL integer  NOT NULL,
    Role integer  NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (ID)
) ;

-- Reference: User_Role (table: User)
ALTER TABLE "User" ADD CONSTRAINT User_Role
    FOREIGN KEY (Role)
    REFERENCES Role (ID);

-- Reference: Users_Person (table: User)
ALTER TABLE "User" ADD CONSTRAINT Users_Person
    FOREIGN KEY (PESEL)
    REFERENCES Person (PESEL);

-- Insertion User
INSERT INTO "User" (ID, Username, Password, Department, PESEL, Role)
VALUES (1, 'admin', 'admin123', 'IT', 1234567890, 1);

INSERT INTO "User" (ID, Username, Password, Department, PESEL, Role)
VALUES (2, 'tech1', 'tech123', 'IT', 9876543210, 2);

INSERT INTO "User" (ID, Username, Password, Department, PESEL, Role)
VALUES (3, 'user1', 'user123', 'Sales', 5555555555, 3);

-- Table: Support_Ticket
CREATE TABLE Support_Ticket (
    ID integer  NOT NULL,
    Type varchar2(255)  NOT NULL,
    Description varchar2(255)  NOT NULL,
    Resolution varchar2(50)  NOT NULL,
    Time_Spent_Resolving_Issue timestamp  NOT NULL,
    "User" integer  NOT NULL,
    Technician integer  NOT NULL,
    Status integer  NOT NULL,
    Urgency integer  NOT NULL,
    CONSTRAINT Support_Ticket_pk PRIMARY KEY (ID)
) ;

-- Reference: Support_Tickets_Status (table: Support_Ticket)
ALTER TABLE Support_Ticket ADD CONSTRAINT Support_Tickets_Status
    FOREIGN KEY (Status)
    REFERENCES Status (ID);

-- Reference: Support_Tickets_Technicians (table: Support_Ticket)
ALTER TABLE Support_Ticket ADD CONSTRAINT Support_Tickets_Technicians
    FOREIGN KEY (Technician)
    REFERENCES Technician (ID);

-- Reference: Support_Tickets_Urgency (table: Support_Ticket)
ALTER TABLE Support_Ticket ADD CONSTRAINT Support_Tickets_Urgency
    FOREIGN KEY (Urgency)
    REFERENCES Urgency (ID);

-- Reference: Support_Tickets_Users (table: Support_Ticket)
ALTER TABLE Support_Ticket ADD CONSTRAINT Support_Tickets_Users
    FOREIGN KEY ("User")
    REFERENCES "User" (ID);

-- Insertion Support Ticket
INSERT INTO Support_Ticket (ID, Type, Description, Resolution, Time_Spent_Resolving_Issue,
                            "User", Technician, Status, Urgency)
VALUES (1, 'Hardware', 'Printer not working', 'Replaced faulty printer',
        TO_TIMESTAMP('2023-06-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        1, 1, 2, 1);

INSERT INTO Support_Ticket (ID, Type, Description, Resolution, Time_Spent_Resolving_Issue,
                            "User", Technician, Status, Urgency)
VALUES (2, 'Software', 'Email application not responding', 'Reinstalled email application',
        TO_TIMESTAMP('2023-06-02 10:45:00', 'YYYY-MM-DD HH24:MI:SS'),
        2, 2, 1, 2);

INSERT INTO Support_Ticket (ID, Type, Description, Resolution, Time_Spent_Resolving_Issue,
                            "User", Technician, Status, Urgency)
VALUES (3, 'Network', 'Unable to connect to the internet', 'Reset network router',
        TO_TIMESTAMP('2023-06-03 16:15:00', 'YYYY-MM-DD HH24:MI:SS'),
        3, 3, 1, 3);

-- Table: Incident_Report
CREATE TABLE Incident_Report (
    ID integer  NOT NULL,
    Description varchar2(255)  NOT NULL,
    Resolution_Description varchar2(255)  NOT NULL,
    Technicians integer  NOT NULL,
    Status integer  NOT NULL,
    Urgency integer  NOT NULL,
    CONSTRAINT Incident_Report_pk PRIMARY KEY (ID)
) ;

-- Reference: Incident_Reports_Status (table: Incident_Report)
ALTER TABLE Incident_Report ADD CONSTRAINT Incident_Reports_Status
    FOREIGN KEY (Status)
    REFERENCES Status (ID);

-- Reference: Incident_Reports_Technicians (table: Incident_Report)
ALTER TABLE Incident_Report ADD CONSTRAINT Incident_Reports_Technicians
    FOREIGN KEY (Technicians)
    REFERENCES Technician (ID);

-- Reference: Incident_Reports_Urgency (table: Incident_Report)
ALTER TABLE Incident_Report ADD CONSTRAINT Incident_Reports_Urgency
    FOREIGN KEY (Urgency)
    REFERENCES Urgency (ID);

-- Insertion Incident Report
INSERT INTO Incident_Report (ID, Description, Resolution_Description, Technicians, Status, Urgency)
VALUES (1, 'Network server outage', 'Rebooted server to restore connectivity', 1, 1, 3);

INSERT INTO Incident_Report (ID, Description, Resolution_Description, Technicians, Status, Urgency)
VALUES (2, 'Software application crash', 'Reinstalled application to resolve crash', 2, 2, 2);

INSERT INTO Incident_Report (ID, Description, Resolution_Description, Technicians, Status, Urgency)
VALUES (3, 'Hardware malfunction', 'Replaced faulty hardware component', 3, 1, 1);

-- Table: Expense_Report
CREATE TABLE Expense_Report (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    Total_Amount number(7,2)  NOT NULL,
    Status integer  NOT NULL,
    Incident_Report integer  NOT NULL,
    CONSTRAINT Expense_Report_pk PRIMARY KEY (ID)
) ;

-- Reference: Expense_Incident_Reports (table: Expense_Report)
ALTER TABLE Expense_Report ADD CONSTRAINT Expense_Incident_Reports
    FOREIGN KEY (Incident_Report)
    REFERENCES Incident_Report (ID);

-- Reference: Expense_Reports_Status (table: Expense_Report)
ALTER TABLE Expense_Report ADD CONSTRAINT Expense_Reports_Status
    FOREIGN KEY (Status)
    REFERENCES Status (ID);

-- Insertion Expense Report
INSERT INTO Expense_Report (ID, Name, Total_Amount, Status, Incident_Report)
VALUES (1, 'Expense Report 1', 1000.00, 1, 1);

INSERT INTO Expense_Report (ID, Name, Total_Amount, Status, Incident_Report)
VALUES (2, 'Expense Report 2', 2500.50, 2, 2);

INSERT INTO Expense_Report (ID, Name, Total_Amount, Status, Incident_Report)
VALUES (3, 'Expense Report 3', 500.25, 1, 3);

-- Table: IT_Staff_Schedules
CREATE TABLE IT_Staff_Schedules (
    ID integer  NOT NULL,
    Work_Hours varchar2(50)  NOT NULL,
    Shift_Schedule varchar2(50)  NOT NULL,
    Technician integer  NOT NULL,
    CONSTRAINT IT_Staff_Schedules_pk PRIMARY KEY (ID)
) ;

-- Reference: IT_Staff_Schedules_Technician (table: IT_Staff_Schedules)
ALTER TABLE IT_Staff_Schedules ADD CONSTRAINT IT_Staff_Schedules_Technician
    FOREIGN KEY (Technician)
    REFERENCES Technician (ID);

-- Insertion IT Staff Schedules
INSERT INTO IT_Staff_Schedules (ID, Work_Hours, Shift_Schedule, Technician)
VALUES (1, '8 AM - 4 PM', 'Monday to Friday', 1);

INSERT INTO IT_Staff_Schedules (ID, Work_Hours, Shift_Schedule, Technician)
VALUES (2, '12 PM - 8 PM', 'Tuesday to Saturday', 2);

INSERT INTO IT_Staff_Schedules (ID, Work_Hours, Shift_Schedule, Technician)
VALUES (3, '9 AM - 5 PM', 'Monday to Friday', 3);

-- Table: IT_Task
CREATE TABLE IT_Task (
    ID integer  NOT NULL,
    Description varchar2(255)  NOT NULL,
    Time_Spend_On_Task integer  NOT NULL,
    Status integer  NOT NULL,
    Support_Ticket integer  NOT NULL,
    CONSTRAINT IT_Task_pk PRIMARY KEY (ID)
) ;

-- Reference: IT_Tasks_Status (table: IT_Task)
ALTER TABLE IT_Task ADD CONSTRAINT IT_Tasks_Status
    FOREIGN KEY (Status)
    REFERENCES Status (ID);

-- Reference: IT_Tasks_Support_Tickets (table: IT_Task)
ALTER TABLE IT_Task ADD CONSTRAINT IT_Tasks_Support_Tickets
    FOREIGN KEY (Support_Ticket)
    REFERENCES Support_Ticket (ID);

-- Insertion IT Task
INSERT INTO IT_Task (ID, Description, Time_Spend_On_Task, Status, Support_Ticket)
VALUES (1, 'Fix network connectivity issue', 2, 1, 1);

INSERT INTO IT_Task (ID, Description, Time_Spend_On_Task, Status, Support_Ticket)
VALUES (2, 'Install software updates', 1, 2, 2);

INSERT INTO IT_Task (ID, Description, Time_Spend_On_Task, Status, Support_Ticket)
VALUES (3, 'Replace faulty hard drive', 3, 1, 3);
