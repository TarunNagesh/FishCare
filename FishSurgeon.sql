DROP DATABASE FishCare;
CREATE DATABASE FishCare;
USE FishCare;


CREATE TABLE Employees (
    EmpID INT NOT NULL PRIMARY KEY,
    ManagerID INT NOT NULL,
    FirstName TEXT,
    MiddleInitial TEXT,
    LastName TEXT,
    Role TEXT,
    Hours INT
);
CREATE TABLE Surgeons (
    SurgeonID INT NOT NULL PRIMARY KEY,
    CONSTRAINT fk00 FOREIGN KEY (SurgeonID)
        REFERENCES Employees(EmpID)
);
CREATE TABLE Managers (
    ManagerID INT NOT NULL PRIMARY KEY,
    Budget INT,
    CONSTRAINT fk01 FOREIGN KEY (ManagerID)
        REFERENCES Employees(EmpID)
);
CREATE TABLE Tanks (
    TankID INT NOT NULL PRIMARY KEY,
    Temp INT NOT NULL,
    TimeCleaned DATETIME,
    WaterType TEXT,
    PHlevel INT,
    Food TEXT,
    TimeFed DATETIME,
    ManagerID INT NOT NULL,
    Status TEXT,
    CONSTRAINT fk02 FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Fish(
    FishID INT NOT NULL PRIMARY KEY,
    TankID INT NOT NULL,
    ManagerID INT NOT NULL,
    Notes LONGTEXT,
    Sex TEXT,
    Species TEXT,
    Status TEXT,
    CONSTRAINT fk03 FOREIGN KEY (TankID)
        REFERENCES Tanks(TankID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk04 FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Procedures (
    EmpID INT NOT NULL,
    ProcID INT NOT NULL PRIMARY KEY ,
    FishID INT NOT NULL,
    Description LONGTEXT,
    Type TEXT,
    Result TEXT,
    CONSTRAINT fk05 FOREIGN KEY (EmpID)
        REFERENCES Surgeons(EmpID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk06 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE FishProcDate (
    FishID INT NOT NULL,
    ProcDate DATETIME NOT NULL,
    PRIMARY KEY (FishId, ProcDate),
    CONSTRAINT fk07 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Prescriptions (
    ProcID INT NOT NULL,
    MedID INT NOT NULL,
    Medicine TEXT,
    Dosage FLOAT,
    PRIMARY KEY (ProcID, MedID),
    CONSTRAINT fk08 FOREIGN KEY (ProcID)
        REFERENCES Procedures(ProcID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Tools (
    ToolID INT NOT NULL PRIMARY KEY,
    ProcID INT NOT NULL,
    Type TEXT,
    Status TEXT,
    CONSTRAINT fk09 FOREIGN KEY (ProcID)
        REFERENCES Procedures(ProcID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Finances (
    TransactionID INT NOT NULL PRIMARY KEY,
    ManagerID INT NOT NULL,
    Recievables INT,
    Payables INT,
    DateSent DATETIME,
    CONSTRAINT fk10 FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
