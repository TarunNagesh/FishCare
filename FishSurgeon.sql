DROP DATABASE FishCare;
CREATE DATABASE FishCare;
USE FishCare;

CREATE TABLE Surgeons (
    EmpID INT NOT NULL PRIMARY KEY,
    FirstName TEXT,
    MiddleInitial TEXT,
    LastName TEXT,
    Hours INT
);
CREATE TABLE Managers (
    ManagerID INT NOT NULL PRIMARY KEY,
    FirstName TEXT,
    MiddleInitial TEXT,
    LastName TEXT,
    Budget INT
)
CREATE TABLE Tanks (
    TankID INT NOT NULL PRIMARY KEY,
    ManagerID INT NOT NULL,
    Status TEXT,
    CONSTRAINT fk01 FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID)
);
CREATE TABLE Fish(
    FishID INT NOT NULL PRIMARY KEY,
    TankID INT NOT NULL,
    ManagerID INT NOT NULL,
    Notes LONGTEXT,
    Sex TEXT,
    Species TEXT,
    Status TEXT,
    CONSTRAINT fk01 FOREIGN KEY (TankID)
        REFERENCES Tanks(TankID),
    CONSTRAINT fk02 FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID)
);
CREATE TABLE Procedures (
    EmpID INT NOT NULL,
    ProcID INT NOT NULL PRIMARY KEY ,
    FishID INT NOT NULL,
    Description LONGTEXT,
    Type TEXT,
    Result TEXT,
    CONSTRAINT fk01 FOREIGN KEY (EmpID)
        REFERENCES Surgeons(EmpID),
    CONSTRAINT fk02 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
);
CREATE TABLE FishProcDate (
    FishID INT NOT NULL,
    ProcDate DATETIME NOT NULL,
    PRIMARY KEY (FishId, ProcDate),
    CONSTRAINT fk01 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
);
CREATE TABLE Prescriptions (
    ProcID INT NOT NULL,
    MedID INT NOT NULL,
    Medicine TEXT,
    Dosage FLOAT,
    PRIMARY KEY (ProcID, MedID),
    CONSTRAINT fk01 FOREIGN KEY (ProcID)
        REFERENCES Procedures(ProcID)
);
CREATE TABLE Tools (
    ToolID INT NOT NULL PRIMARY KEY,
    ProcID INT NOT NULL,
    Type TEXT,
    Status TEXT,
    CONSTRAINT fk01 FOREIGN KEY (ProcID)
        REFERENCES Procedures(ProcID)
);
CREATE TABLE Employees (
    EmpID INT NOT NULL PRIMARY KEY,
    ManagerID INT NOT NULL,
    FirstName TEXT,
    MiddleInitial TEXT,
    LastName TEXT,
    Role TEXT,
    CONSTRAINT fk01 FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID)
);
CREATE TABLE Finances (
    TransactionID INT NOT NULL PRIMARY KEY,
    ManagerID INT NOT NULL,
    Recievables INT,
    Payables INT,
    DateSent DATETIME,
    CONSTRAINT fk01 FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID)
);
