DROP DATABASE FishCare;
CREATE DATABASE FishCare;
USE FishCare;

CREATE TABLE Employees (
    EmpID INT NOT NULL PRIMARY KEY,
    ManagerID INT,
    FirstName TEXT,
    MiddleInitial TEXT,
    LastName TEXT,
    Hours INT,
    Address VARCHAR(75),
    CONSTRAINT fk0 FOREIGN KEY (ManagerID)
        REFERENCES Employees(EmpID)
        ON UPDATE CASCADE ON DELETE RESTRICT

);
CREATE TABLE Keeper (
    KeeperID INT NOT NULL PRIMARY KEY,
    CONSTRAINT fk00 FOREIGN KEY (KeeperID)
        REFERENCES Employees(EmpID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Surgeons (
    SurgeonID INT NOT NULL PRIMARY KEY,
    Certification TEXT,
    CONSTRAINT fk01 FOREIGN KEY (SurgeonID)
        REFERENCES Employees(EmpID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Managers (
    ManagerID INT NOT NULL PRIMARY KEY,
    Budget INT,
    CONSTRAINT fk02 FOREIGN KEY (ManagerID)
        REFERENCES Employees(EmpID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Ichthyologist (
    IchID INT NOT NULL PRIMARY KEY,
    Certification TEXT,
    CONSTRAINT fk03 FOREIGN KEY (IchID)
        REFERENCES Employees(EmpID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Plans (
    PlanID INT NOT NULL PRIMARY KEY,
    MadeBy INT NOT NULL,
    ApprovedBy INT NOT NULL,
    Type TEXT,
    Details LONGTEXT,
    Status TEXT,
    Cost INT,
    CONSTRAINT fk04 FOREIGN KEY (MadeBy)
        REFERENCES Ichthyologist(IchID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk05 FOREIGN KEY (ApprovedBy)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Tanks (
    TankID INT NOT NULL PRIMARY KEY,
    ManagedBy INT NOT NULL,
    OverseedBy INT NOT NULL,
    Temp INT NOT NULL,
    TimeCleaned DATETIME,
    WaterType TEXT,
    PHlevel INT,
    Food TEXT,
    TimeFed DATETIME,
    Status TEXT,
    CONSTRAINT fk09 FOREIGN KEY (ManagedBy)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk10 FOREIGN KEY (OverseedBy)
        REFERENCES Ichthyologist(IchID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Fish(
    FishID INT NOT NULL PRIMARY KEY,
    HousedIn INT NOT NULL,
    ManagedBy INT NOT NULL,
    KeptBy INT NOT NULL,
    Notes LONGTEXT,
    Sex TEXT,
    Species TEXT,
    Status TEXT,
    CONSTRAINT fk11 FOREIGN KEY (HousedIn)
        REFERENCES Tanks(TankID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk12 FOREIGN KEY (ManagedBy)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk13 FOREIGN KEY (KeptBy)
        REFERENCES Keeper(KeeperID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Procedures (
    Surgeon INT NOT NULL,
    ProcID INT NOT NULL PRIMARY KEY ,
    Fish INT NOT NULL,
    Description LONGTEXT,
    Type TEXT,
    Result TEXT,
    CONSTRAINT fk14 FOREIGN KEY (Surgeon)
        REFERENCES Surgeons(SurgeonID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk15 FOREIGN KEY (Fish)
        REFERENCES Fish(FishID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE FishProcDate (
    FishID INT NOT NULL,
    ProcDate DATETIME NOT NULL,
    PRIMARY KEY (FishId, ProcDate),
    CONSTRAINT fk16 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Prescriptions (
    ProcFor INT NOT NULL,
    MedID INT NOT NULL,
    Medicine TEXT,
    Dosage FLOAT,
    PRIMARY KEY (ProcFor, MedID),
    CONSTRAINT fk17 FOREIGN KEY (ProcFor)
        REFERENCES Procedures(ProcID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Tools (
    ToolID INT NOT NULL PRIMARY KEY,
    ProcUsedIn INT NOT NULL,
    Type TEXT,
    Status TEXT,
    CONSTRAINT fk18 FOREIGN KEY (ProcUsedIn)
        REFERENCES Procedures(ProcID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Finances (
    TransactionID INT NOT NULL PRIMARY KEY,
    ManagedBy INT NOT NULL,
    Recievables INT,
    Payables INT,
    DateSent DATETIME,
    CONSTRAINT fk19 FOREIGN KEY (ManagedBy)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Reports (
    FishID INT NOT NULL,
    MadeBy INT NOT NULL,
    SentTo INT NOT NULL,
    Type TEXT,
    Description LONGTEXT,
    CONSTRAINT fk06 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk07 FOREIGN KEY (MadeBy)
        REFERENCES Keeper(KeeperID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk08 FOREIGN KEY (SentTo)
        REFERENCES Ichthyologist(IchID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO Surgeons(Certification, SurgeonID)
VALUES('PhD in Marine Biology at UCLA', 1);

INSERT INTO Surgeons(Certification, SurgeonID)
VALUES('PhD in Vetrinary Studies at Northeastern', 2);
