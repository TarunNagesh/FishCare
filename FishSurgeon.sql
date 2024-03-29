CREATE DATABASE FishCare;
USE FishCare;

CREATE TABLE Surgeons (
    EmpID INT NOT NULL PRIMARY KEY,
    FirstName TEXT,
    MiddleInitial TEXT,
    LastName TEXT,
    Hours INT
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
CREATE TABLE Fish(
    FishID INT NOT NULL PRIMARY KEY,
    Notes LONGTEXT
)
CREATE TABLE FishProcDate (
    FishID INT NOT NULL,
    ProcDate DATETIME NOT NULL,
    PRIMARY KEY (FishId, ProcDate),
    CONSTRAINT fk03 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
);
CREATE TABLE Prescriptions (
    ProcID INT NOT NULL,
    MedID INT NOT NULL,
    Medicine TEXT,
    Dosage FLOAT,
    PRIMARY KEY (ProcID, MedID),
    CONSTRAINT fk04 FOREIGN KEY (ProcID)
        REFERENCES Procedures(ProcID)
);
CREATE TABLE Tools (
    ToolID INT NOT NULL PRIMARY KEY,
    ProcID INT NOT NULL,
    Type TEXT,
    Status TEXT,
    CONSTRAINT fk05 FOREIGN KEY (ProcID)
        REFERENCES Procedures(ProcID)
);