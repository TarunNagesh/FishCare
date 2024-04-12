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
CREATE TABLE Managers (
    ManagerID INT NOT NULL PRIMARY KEY,
    Budget INT,
    CONSTRAINT fk02 FOREIGN KEY (ManagerID)
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
CREATE TABLE Keeper (
    KeeperID INT NOT NULL PRIMARY KEY,
    CONSTRAINT fk00 FOREIGN KEY (KeeperID)
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
    OverseenBy INT NOT NULL,
    AssignedTo INT NOT NULL,
    Temp INT NOT NULL,
    TimeCleaned DATETIME,
    WaterType TEXT,
    PHlevel FLOAT,
    Food TEXT,
    TimeFed DATETIME,
    Status TEXT,
    CONSTRAINT fk09 FOREIGN KEY (ManagedBy)
        REFERENCES Managers(ManagerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk10 FOREIGN KEY (OverseenBy)
        REFERENCES Ichthyologist(IchID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk11 FOREIGN KEY (AssignedTo)
        REFERENCES Keeper(KeeperID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Fish(
    FishID INT NOT NULL PRIMARY KEY,
    HousedIn INT NOT NULL,
    KeptBy INT NOT NULL,
    Notes LONGTEXT,
    Sex TEXT,
    Species TEXT,
    Status TEXT,
    CONSTRAINT fk12 FOREIGN KEY (HousedIn)
        REFERENCES Tanks(TankID)
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
    ReportID INT NOT NULL PRIMARY KEY,
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

INSERT INTO Employees
    VALUES (0001, 0001, 'John', 'P', 'Park', 40, '123 Antwerp St'),
           (0002, 0002, 'Park', 'A', 'Nontenot', 80, '2 Merserve Terr'),
           (0003, 0001, 'Marissa', 'J', 'Kent', 20, '300 Huntington Ave'),
           (0004, 0001, 'Projes', 'U', 'Crane', 25, '90 Adams St'),
           (0005, 0002, 'Corg', 'I', 'Gatsby', 45, '21 Atlantis C'),
           (0006, 0002, 'Craig', 'H', 'Ate', 44, '20 Atlantis C'),
           (0007, 0001, 'Doc', 'T', 'Erfish', 34, '10 Salt Lake Blvd'),
           (0008, 0001, 'Stur', 'G', 'Eon', 18, '1 Street Ave');
INSERT INTO Managers
    VALUES (0001, 8000),
           (0002, 500);
INSERT INTO Surgeons
    VALUES (0003, 'PHD in Marine Biology Operations @ UCLA'),
           (0004, 'Masters in Veterinary Surgery @ SMU');
INSERT INTO Keeper
    VALUES (0005),
           (0006);
INSERT INTO Ichthyologist
    VALUES (0007, 'PHD in Marine Biology Observation @ Yale'),
           (0008, 'Post Doc in Aquarium Management @ SASE');
INSERT INTO Plans
    VALUES (1111, 0007, 0001, 'Breeding',
            'Sturgeon population is declining to point of endangerment:
            need to invest in a breeding tank.',
            'Approved', 2000),
        (2222, 0008, 0001, 'Expansion',
            'Fish in tank seem to be cramped: could benefit from separating entities',
            'Denied', 10);
INSERT INTO Tanks
    VALUES (1000, 0002, 0007, 0005, 79, CURRENT_TIMESTAMP, 'Fresh Water',
            7.3, 'PetCo', CURRENT_TIMESTAMP, 'Active'),
        (2000, 0002, 0008, 0006, 75, CURRENT_TIMESTAMP, 'Salt Water',
         7.1, 'PetSmart', CURRENT_TIMESTAMP, 'Active'),
        (3000, 0002, 0007, 0006, 78, CURRENT_TIMESTAMP, 'Fresh Water',
         6.9, 'NontenotHungry', CURRENT_TIMESTAMP, 'Inactive');
INSERT INTO Fish
    VALUES (1, 1000, 0005, 'Lorem Ipsum Switch', 'F', 'Sturgeon', 'Alive'),
           (2, 1000, 0005, 'Lorem Ipsum Switch', 'M', 'Sturgeon', 'Alive'),
           (3, 2000, 0006, 'Lorem Ipsum Switch', 'M', 'Tuna', 'Alive'),
           (4, 2000, 0006, 'Lorem Ipsum Switch', 'M', 'Fluke', 'Dead');
INSERT INTO Procedures
    VALUES (0003, 9999, 1, 'Scale Removal', 'Invasive', 'Success'),
           (0003, 9998, 2, 'Wound Closure', 'Invasive', 'Success'),
           (0004, 9997, 4, 'Eye Check-Up', 'Non-invasive', 'Failure'),
           (0004, 9996, 4, 'Resuscitation', 'Invasive', 'Failure');
INSERT INTO FishProcDate
    VALUES (1, CURRENT_TIMESTAMP),
           (2, CURRENT_TIMESTAMP),
           (4, CURRENT_TIMESTAMP),
           (4, '2023-03-31 19:05:47');
INSERT INTO Prescriptions
    VALUES (9999, 82792, 'Advil', 1.5),
           (9997, 92973, 'CPR', 1.0),
           (9996, 93898, 'Funeral', 1.0);
INSERT INTO Tools
    VALUES (10001, 9999, 'Scalpel', 'Clean'),
           (10002, 9999, 'Sutures', 'Used'),
           (10003, 9998, 'Sutures', 'Used');
INSERT INTO Finances
    VALUES (20001, 0001, 8000, 5000, CURRENT_TIMESTAMP),
           (20002, 0002, 0, 10000, CURRENT_TIMESTAMP);
INSERT INTO Reports
    VALUES (101, 1, 0005, 0007, 'Impaled Scale', 'Lorem Ipsum Switch'),
           (102, 2, 0005, 0007, 'Bite Wound', 'Lorem Ipsum Switch'),
           (103, 4, 0006, 0008, 'Lazy Eye', 'Lorem Ipsum Switch');
