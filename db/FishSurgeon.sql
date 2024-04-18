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
        ON UPDATE CASCADE 
);
CREATE TABLE FishProcDate (
    FishID INT NOT NULL,
    ProcDate DATETIME NOT NULL,
    PRIMARY KEY (FishId, ProcDate),
    CONSTRAINT fk16 FOREIGN KEY (FishID)
        REFERENCES Fish(FishID)
        ON UPDATE CASCADE
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
        ON UPDATE CASCADE,
    CONSTRAINT fk07 FOREIGN KEY (MadeBy)
        REFERENCES Keeper(KeeperID)
        ON UPDATE CASCADE,
    CONSTRAINT fk08 FOREIGN KEY (SentTo)
        REFERENCES Ichthyologist(IchID)
        ON UPDATE CASCADE
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
           insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0009, 0008, 'Blakeley', 'H', 'Whitchurch', 10, '743 Crownhardt Way');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0010, 0008, 'Geoffrey', 'N', 'Largen', 7, '00777 Portage Avenue');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0011, 0007, 'Faunie', 'F', 'Rallinshaw', 3, '6016 4th Way');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0012, 0011, 'Tucky', 'Q', 'Blas', 22, '460 Springview Hill');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0013, 0012, 'Anne-corinne', 'G', 'Boneham', 16, '7 5th Hill');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0014, 0013, 'Emmi', 'I', 'Copnell', 21, '5299 Fieldstone Court');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0015, 0009, 'Estel', 'C', 'Hawkings', 5, '50 Trailsway Hill');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0016, 0004, 'Aldridge', 'C', 'Lyal', 4, '923 Caliangt Parkway');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0017, 0001, 'Helena', 'P', 'Perry', 18, '20115 Riverside Hill');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0018, 0003, 'Niccolo', 'D', 'Mallan', 15, '62974 Sheridan Terrace');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0019, 0013, 'Alexina', 'W', 'Cleeve', 2, '76152 Bellgrove Court');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0020, 0009, 'Teddie', 'X', 'Moncarr', 10, '62 Moland Lane');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0021, 0013, 'Reggi', 'W', 'Tidder', 29, '22 Coleman Road');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0022, 0020, 'Saba', 'G', 'Exter', 17, '7653 Springview Alley');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0023, 0007, 'Heywood', 'P', 'Matton', 15, '6 Starling Terrace');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0024, 0023, 'Vikki', 'S', 'Greaser', 24, '41 Ohio Avenue');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0025, 0022, 'Ellie', 'V', 'Cavnor', 22, '1375 Warner Drive');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0026, 0025, 'Teodoor', 'X', 'Pickrill', 6, '37 Sutherland Point');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0027, 0004, 'Toddy', 'E', 'Stinson', 6, '904 Oak Plaza');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0028, 0003, 'Gretel', 'D', 'Marjanski', 13, '437 8th Place');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0029, 0009, 'Hort', 'C', 'Coleby', 20, '27 Kim Court');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0030, 0029, 'Maurise', 'K', 'Beltzner', 19, '0 Lake View Center');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0031, 0024, 'Aubrey', 'R', 'Pordal', 23, '921 Lien Parkway');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0032, 0006, 'Lewie', 'X', 'Follitt', 1, '3013 Golden Leaf Plaza');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0033, 0003, 'Violetta', 'H', 'Cockling', 6, '5 Hoffman Circle');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0034, 0032, 'Indira', 'V', 'Billion', 3, '85407 Walton Road');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0035, 0034, 'Alaster', 'R', 'Berston', 10, '63818 Macpherson Circle');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0036, 0013, 'Edithe', 'J', 'Blacklock', 9, '991 Dexter Lane');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0037, 0025, 'Glynn', 'M', 'Linzee', 16, '0233 Brentwood Center');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0038, 0032, 'Abey', 'L', 'Bowdery', 22, '47 Weeping Birch Lane');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0039, 0008, 'Janek', 'B', 'Buckenhill', 12, '251 Briar Crest Place');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0040, 0039, 'Montgomery', 'V', 'Eckh', 23, '813 Tomscot Avenue');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0041, 0035, 'Pauly', 'K', 'Downer', 16, '01541 Loomis Terrace');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0042, 0038, 'Inessa', 'Z', 'Brosi', 23, '8 Roxbury Alley');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0043, 0002, 'Adriane', 'F', 'Falconbridge', 18, '5 Waubesa Court');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0044, 0042, 'Hannis', 'P', 'Issitt', 30, '990 Dayton Parkway');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0045, 0007, 'Malanie', 'Y', 'Pigney', 11, '0228 Helena Place');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0046, 0002, 'Terrence', 'X', 'Zywicki', 19, '4749 Grasskamp Plaza');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0047, 0025, 'Brannon', 'G', 'Beange', 5, '520 Cottonwood Alley');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0048, 0033, 'Dov', 'A', 'Reeson', 12, '2 Milwaukee Parkway');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0049, 0034, 'Dory', 'K', 'Beeching', 18, '39 Eagle Crest Park');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0050, 0002, 'Charmain', 'E', 'Dacca', 20, '01 Roxbury Junction');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0051, 0015, 'Laurie', 'M', 'Whatman', 7, '3735 Anniversary Center');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0052, 0040, 'Cad', 'Y', 'Upshall', 27, '1542 Glendale Parkway');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0053, 0010, 'Bran', 'R', 'Skace', 8, '040 Vermont Circle');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0054, 0034, 'Cassius', 'A', 'Estcourt', 28, '3 Schmedeman Center');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0055, 0020, 'Blondell', 'E', 'Robun', 37, '07635 Almo Crossing');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0056, 0001, 'Casandra', 'G', 'MacPaik', 37, '40058 Saint Paul Alley');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0057, 0002, 'Idaline', 'M', 'Hasslocher', 2, '5 Clove Way');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0058, 0030, 'Hali', 'C', 'Allenson', 21, '908 Sachtjen Lane');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0059, 0023, 'Richy', 'F', 'Lafford', 28, '5 Vermont Way');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0060, 0033, 'Chicky', 'W', 'Westmoreland', 32, '98 Mifflin Street');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0061, 0004, 'Matty', 'T', 'Laxton', 9, '53 Debra Avenue');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0062, 0005, 'Allan', 'T', 'Attewill', 17, '28683 Park Meadow Park');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0063, 0006, 'Alethea', 'J', 'Piegrome', 16, '01072 Vahlen Plaza');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0064, 0007, 'Rorie', 'D', 'Volkers', 21, '66716 Red Cloud Plaza');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0065, 0008, 'Viviene', 'V', 'Gateman', 22, '3380 Warrior Way');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0066, 0009, 'Vic', 'P', 'Pedersen', 28, '682 John Wall Parkway');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0067, 0010, 'Spense', 'Y', 'Budgen', 32, '2 Gulseth Plaza');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0068, 0011, 'Corny', 'P', 'Koenen', 25, '3846 Thackeray Hill');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0069, 0012, 'Falkner', 'K', 'Roslen', 7, '647 Randy Terrace');
insert into Employees (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) values (0070, 0013, 'Amitie', 'Q', 'Carff', 15, '33966 Linden Court');


INSERT INTO Managers
    VALUES (0001, 8000),
           (0002, 500);
           insert into Managers (ManagerID, Budget) values (0003, 3085);
insert into Managers (ManagerID, Budget) values (0004, 3601);
insert into Managers (ManagerID, Budget) values (0005, 4573);
insert into Managers (ManagerID, Budget) values (0006, 954);
insert into Managers (ManagerID, Budget) values (0007, 4368);
insert into Managers (ManagerID, Budget) values (0008, 1261);
insert into Managers (ManagerID, Budget) values (0009, 4740);
insert into Managers (ManagerID, Budget) values (0010, 128);
insert into Managers (ManagerID, Budget) values (0011, 4911);
insert into Managers (ManagerID, Budget) values (0012, 565);
insert into Managers (ManagerID, Budget) values (0013, 2228);
insert into Managers (ManagerID, Budget) values (0014, 2500);
insert into Managers (ManagerID, Budget) values (0015, 3928);
insert into Managers (ManagerID, Budget) values (0016, 829);
insert into Managers (ManagerID, Budget) values (0017, 4439);
insert into Managers (ManagerID, Budget) values (0018, 2773);
insert into Managers (ManagerID, Budget) values (0019, 3816);
insert into Managers (ManagerID, Budget) values (0020, 3908);
insert into Managers (ManagerID, Budget) values (0021, 4388);
insert into Managers (ManagerID, Budget) values (0022, 3401);
insert into Managers (ManagerID, Budget) values (0023, 2882);
insert into Managers (ManagerID, Budget) values (0024, 1213);
insert into Managers (ManagerID, Budget) values (0025, 1171);
insert into Managers (ManagerID, Budget) values (0026, 496);
insert into Managers (ManagerID, Budget) values (0027, 641);
insert into Managers (ManagerID, Budget) values (0028, 4923);
insert into Managers (ManagerID, Budget) values (0029, 1726);
insert into Managers (ManagerID, Budget) values (0030, 3278);
insert into Managers (ManagerID, Budget) values (0031, 2413);
insert into Managers (ManagerID, Budget) values (0032, 3256);
insert into Managers (ManagerID, Budget) values (0033, 4649);
insert into Managers (ManagerID, Budget) values (0034, 3195);
insert into Managers (ManagerID, Budget) values (0035, 1288);
insert into Managers (ManagerID, Budget) values (0036, 2737);
insert into Managers (ManagerID, Budget) values (0037, 2123);
insert into Managers (ManagerID, Budget) values (0038, 3200);
insert into Managers (ManagerID, Budget) values (0039, 2242);
insert into Managers (ManagerID, Budget) values (0040, 1055);
insert into Managers (ManagerID, Budget) values (0041, 2692);
insert into Managers (ManagerID, Budget) values (0042, 4823);
insert into Managers (ManagerID, Budget) values (0043, 2979);
insert into Managers (ManagerID, Budget) values (0044, 2816);
insert into Managers (ManagerID, Budget) values (0045, 4066);


INSERT INTO Surgeons
    VALUES (0003, 'PHD in Marine Biology Operations @ UCLA'),
           (0004, 'Masters in Veterinary Surgery @ SMU');
           insert into Surgeons (SurgeonID, Certification) values (0005, 'Masters');
insert into Surgeons (SurgeonID, Certification) values (0006, 'PhD with Honors from a random college');
insert into Surgeons (SurgeonID, Certification) values (0007, 'PhD with Honors from a random college');
insert into Surgeons (SurgeonID, Certification) values (0008, 'PhD with Honors from a random college');
insert into Surgeons (SurgeonID, Certification) values (0009, 'Masters');
insert into Surgeons (SurgeonID, Certification) values (0010, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0011, 'Masters');
insert into Surgeons (SurgeonID, Certification) values (0012, 'PhD with Honors from a random college');
insert into Surgeons (SurgeonID, Certification) values (0013, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0014, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0015, 'Masters');
insert into Surgeons (SurgeonID, Certification) values (0016, 'PhD with Honors from a random college');
insert into Surgeons (SurgeonID, Certification) values (0017, 'Masters with Distinction');
insert into Surgeons (SurgeonID, Certification) values (0018, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0019, 'Masters with Distinction');
insert into Surgeons (SurgeonID, Certification) values (0020, 'Masters with Distinction');
insert into Surgeons (SurgeonID, Certification) values (0021, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0022, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0023, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0024, 'PhD');
insert into Surgeons (SurgeonID, Certification) values (0025, 'PhD with Honors from a random college');
insert into Surgeons (SurgeonID, Certification) values (0026, 'PhD with Honors from a random college');
insert into Surgeons (SurgeonID, Certification) values (0027, 'Masters');

INSERT INTO Keeper
    VALUES (0028),
           (0029);
           insert into Keeper (KeeperID) values (0030);
insert into Keeper (KeeperID) values (0031);
insert into Keeper (KeeperID) values (0032);
insert into Keeper (KeeperID) values (0033);
insert into Keeper (KeeperID) values (0034);
insert into Keeper (KeeperID) values (0035);
insert into Keeper (KeeperID) values (0036);
insert into Keeper (KeeperID) values (0037);
insert into Keeper (KeeperID) values (0038);
insert into Keeper (KeeperID) values (0039);
insert into Keeper (KeeperID) values (0040);
insert into Keeper (KeeperID) values (0041);
insert into Keeper (KeeperID) values (0042);
insert into Keeper (KeeperID) values (0043);
insert into Keeper (KeeperID) values (0044);
insert into Keeper (KeeperID) values (0045);
insert into Keeper (KeeperID) values (0046);
insert into Keeper (KeeperID) values (0047);
insert into Keeper (KeeperID) values (0048);
insert into Keeper (KeeperID) values (0049);
insert into Keeper (KeeperID) values (0050);
insert into Keeper (KeeperID) values (0051);
insert into Keeper (KeeperID) values (0052);

INSERT INTO Ichthyologist
    VALUES (0053, 'PHD in Marine Biology Observation @ Yale'),
           (00054, 'Post Doc in Aquarium Management @ SASE');
           insert into Ichthyologist (IchID, Certification) values (0055, 'Bachelor of Science');
insert into Ichthyologist (IchID, Certification) values (0056, 'Master of Arts');
insert into Ichthyologist (IchID, Certification) values (0057, 'Associate of Applied Science');
insert into Ichthyologist (IchID, Certification) values (0058, 'Bachelor of Science');
insert into Ichthyologist (IchID, Certification) values (0059, 'Bachelor of Science');
insert into Ichthyologist (IchID, Certification) values (0060, 'Doctor of Philosophy');
insert into Ichthyologist (IchID, Certification) values (0061, 'Doctor of Philosophy');
insert into Ichthyologist (IchID, Certification) values (0062, 'Bachelor of Science');
insert into Ichthyologist (IchID, Certification) values (0063, 'Master of Arts');
insert into Ichthyologist (IchID, Certification) values (0064, 'Master of Arts');
insert into Ichthyologist (IchID, Certification) values (0065, 'Master of Arts');
insert into Ichthyologist (IchID, Certification) values (0066, 'Doctor of Philosophy');
insert into Ichthyologist (IchID, Certification) values (0067, 'Bachelor of Science');
insert into Ichthyologist (IchID, Certification) values (0068, 'Master of Arts');
insert into Ichthyologist (IchID, Certification) values (0069, 'Master of Arts');
insert into Ichthyologist (IchID, Certification) values (0070, 'Master of Arts');

INSERT INTO Plans
    VALUES (2, 0067, 0001, 'Breeding',
            'Sturgeon population is declining to point of endangerment:
            need to invest in a breeding tank.',
            'Approved', 2000),
        (1, 0068, 0001, 'Expansion',
            'Fish in tank seem to be cramped: could benefit from separating entities',
            'Denied', 10);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (3, 0053, 0002, 'inventory_report', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'denied', 1165);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (4, 0063, 0003, 'sales_report', 'auctor sit amet aliquam vel', 'approved', 46);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (5, 0070, 0004, 'marketing_report', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'denied', 1782);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (6, 0057, 0005, 'marketing_report', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque', 'approved', 1510);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (7, 0065, 0006, 'inventory_report', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'approved', 2248);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (8, 0069, 0007, 'financial_report', 'Lorem ipsum dolor sit amet', 'approved', 793);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (9, 0069, 0008, 'inventory_report', 'ullamcorper sit amet ligula.', 'denied', 2222);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (10, 0053, 0009, 'inventory_report', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'approved', 2540);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (11, 0054, 0010, 'marketing_report', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque', 'denied', 1620);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (12, 0067, 0011, 'inventory_report', 'Lorem ipsum dolor sit amet', 'approved', 2298);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (13, 0054, 0012, 'financial_report', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque', 'denied', 2400);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (14, 0055, 0013, 'inventory_report', 'auctor sit amet aliquam vel', 'denied', 2266);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (15, 0070, 0014, 'sales_report', 'Lorem ipsum dolor sit amet', 'denied', 1594);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (16, 0069, 0015, 'inventory_report', 'ullamcorper sit amet ligula.', 'approved', 2517);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (17, 0070, 0016, 'sales_report', 'ullamcorper sit amet ligula.', 'denied', 2790);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (18, 0056, 0017, 'inventory_report', 'ullamcorper sit amet ligula.', 'denied', 2135);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (19, 0068, 0018, 'sales_report', 'consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'denied', 351);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (20, 0065, 0019, 'inventory_report', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'denied', 2579);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (21, 0064, 0020, 'marketing_report', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque', 'denied', 1540);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (22, 0065, 0021, 'marketing_report', 'auctor sit amet aliquam vel', 'denied', 1018);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (23, 0067, 0022, 'financial_report', 'Lorem ipsum dolor sit amet', 'denied', 2273);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (24, 0066, 0023, 'marketing_report', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'denied', 1161);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (25, 0068, 0024, 'financial_report', 'ullamcorper sit amet ligula.', 'approved', 1271);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (26, 0053, 0025, 'sales_report', 'Lorem ipsum dolor sit amet', 'denied', 1066);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (27, 0066, 0026, 'inventory_report', 'auctor sit amet aliquam vel', 'approved', 861);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (28, 0055, 0027, 'sales_report', 'ullamcorper sit amet ligula.', 'denied', 2087);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (29, 0069, 0028, 'marketing_report', 'ullamcorper sit amet ligula.', 'approved', 2776);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (30, 0065, 0029, 'inventory_report', 'Lorem ipsum dolor sit amet', 'denied', 2035);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (31, 0068, 0030, 'financial_report', 'consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'approved', 1120);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (32, 0066, 0031, 'sales_report', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque', 'denied', 746);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (33, 0068, 0032, 'sales_report', 'auctor sit amet aliquam vel', 'denied', 2099);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (34, 0068, 0033, 'financial_report', 'Lorem ipsum dolor sit amet', 'denied', 1277);
insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values (35, 0057, 0034, 'sales_report', 'auctor sit amet aliquam vel', 'denied', 1534);

INSERT INTO Tanks
    VALUES (1000, 0002, 0057, 0048, 79, CURRENT_TIMESTAMP, 'Freshwater',
            7.3, 'PetCo', CURRENT_TIMESTAMP, 'Active'),
        (2000, 0002, 0057, 0048, 75, CURRENT_TIMESTAMP, 'Saltwater',
         7.1, 'PetSmart', CURRENT_TIMESTAMP, 'Active'),
        (3000, 0002, 0057, 0048, 78, CURRENT_TIMESTAMP, 'Freshwater',
         6.9, 'NontenotHungry', CURRENT_TIMESTAMP, 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (1, 0045, 0057, 0048, 68, '2008-11-11 13:23:44', 'Freshwater', 6.5, 'freeze-dried', '2023-09-29 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (2, 0001, 0066, 0050, 65, '2008-11-11 13:23:44', 'Freshwater', 7.4, 'flakes', '2023-01-13 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (3, 0001, 0054, 0052, 81, '2008-11-11 13:23:44', 'Freshwater', 6.1, 'live', '2023-06-20 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (4, 0023, 0070, 0028, 38, '2008-11-11 13:23:44', 'Freshwater', 6.4, 'pellets', '2023-01-09 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (5, 0023, 0066, 0050, 77, '2008-11-11 13:23:44', 'Freshwater', 6.7, 'flakes', '2023-03-16 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (6, 0001, 0068, 0048, 76, '2008-11-11 13:23:44', 'Freshwater', 6.4, 'frozen', '2023-03-01 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (7, 0023, 0063, 0052, 81, '2023-04-08 19:05:47', 'Freshwater', 7.6, 'pellets', '2023-04-25 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (8, 0023, 0070, 0048, 74, '2023-11-02 19:05:47', 'Freshwater', 6.4, 'freeze-dried', '2023-03-25 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (9, 0023, 0059, 0052, 85, '2023-02-11 19:05:47', 'Freshwater', 7.5, 'pellets', '2023-06-30 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (10, 0023, 0066, 0028, 76, '2023-05-12 19:05:47', 'Freshwater', 7.3, 'freeze-dried', '2023-05-18 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (11, 0001, 0068, 0052, 71, '2023-04-12 19:05:47', 'Saltwater', 6.2, 'flakes', '2023-09-08 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (12, 0001, 0063, 0048, 30, '2023-10-26 19:05:47', 'Saltwater', 6.9, 'live', '2023-12-28 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (13, 0001, 0069, 0050, 32, '2023-03-23 19:05:47', 'Saltwater', 7.6, 'frozen', '2023-10-18 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (14, 0023, 0069, 0038, 86, '2023-11-28 19:05:47', 'Saltwater', 7.7, 'live', '2023-03-09 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (15, 0009, 0053, 0051, 34, '2023-01-21 19:05:47', 'Freshwater', 6.3, 'flakes', '023-07-03 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (16, 0001, 0068, 0049, 78, '2023-09-26 19:05:47', 'Freshwater', 6.7, 'live', '2023-05-11 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (17, 0012, 0059, 0051, 42, '2023-10-08 19:05:47', 'Freshwater', 6.3, 'live', '2023-05-08 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (18, 0012, 0066, 0049, 43, '2023-05-12 19:05:47', 'Saltwater', 7.1, 'frozen', '2023-04-14 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (19, 0009, 0066, 0050, 72, '2023-07-30 19:05:47', 'Saltwater', 6.9, 'pellets', '2023-07-22 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (20, 0009, 0066, 0038, 42, '2023-04-28 19:05:47', 'Saltwater', 6.0, 'freeze-dried', '2023-09-22 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (21, 0012, 0059, 0050, 53, '2023-05-19 19:05:47', 'Saltwater', 7.7, 'freeze-dried', '2023-12-01 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (22, 0023, 0065, 0029, 63, '2023-09-24 19:05:47', 'Saltwater', 8.0, 'frozen', '2023-12-22 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (23, 0001, 0067, 0051, 62, '2023-10-11 19:05:47', 'Saltwater', 7.0, 'flakes', '2023-05-11 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (24, 0001, 0056, 0039, 86, '2023-11-20 19:05:47', 'Freshwater', 6.6, 'live', '2023-06-16 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (25, 0009, 0066, 0050, 78, '2023-08-27 19:05:47', 'Freshwater', 7.7, 'live', '2023-01-27 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (26, 0009, 0054, 0048, 47, '2023-03-11 19:05:47', 'Freshwater', 7.4, 'freeze-dried', '2023-06-22 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (27, 0012, 0069, 0050, 80, '2023-08-31 19:05:47', 'Saltwater', 7.9, 'pellets', '2023-12-06 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (28, 0001, 0057, 0049, 30, '2023-08-04 19:05:47', 'Saltwater', 7.2, 'flakes', '2023-02-11 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (29, 0012, 0069, 0050, 63, '2023-11-02 19:05:47', 'Saltwater', 6.6, 'flakes', '2023-08-08 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (30, 0045, 0057, 0048, 46, '2023-12-07 19:05:47', 'Saltwater', 6.3, 'freeze-dried', '2023-10-13 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (31, 0009, 0066, 0051, 72, '2023-07-06 19:05:47', 'Saltwater', 7.5, 'frozen', '2023-02-01 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (32, 0009, 0054, 0039, 56, '2023-09-22 19:05:47', 'Freshwater', 7.4, 'flakes', '2023-04-09 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (33, 0001, 0054, 0050, 42, '2023-08-08 19:05:47', 'Freshwater', 7.1, 'pellets', '2023-03-03 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (34, 0001, 0054, 0029, 57, '2023-08-02 19:05:47', 'Saltwater', 7.0, 'frozen', '2023-07-20 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (35, 0009, 0055, 0052, 66, '2023-06-10 19:05:47', 'Saltwater', 7.7, 'live', '2023-11-24 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (36, 0001, 0067, 0028, 30, '2023-08-10 19:05:47', 'Freshwater', 6.6, 'live', '2023-12-15 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (37, 0009, 0068, 0052, 76, '2023-02-10 19:05:47', 'Saltwater', 6.5, 'flakes', '2023-06-25 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (38, 0009, 0064, 0049, 72, '2023-03-07 19:05:47', 'Freshwater', 7.2, 'pellets', '2023-11-06 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (39, 0001, 0059, 0051, 72, '2023-10-13 19:05:47', 'Freshwater', 6.9, 'pellets', '2023-08-25 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (40, 0023, 0068, 0051, 42, '2023-03-16 19:05:47', 'Saltwater', 7.3, 'live', '2023-03-06 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (41, 0012, 0058, 0048, 44, '2023-06-01 19:05:47', 'Saltwater', 7.0, 'live', '2023-01-27 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (42, 0001, 0058, 0051, 79, '2023-10-21 19:05:47', 'Freshwater', 6.3, 'frozen', '2023-04-26 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (43, 0023, 0068, 0038, 81, '2023-04-29 19:05:47', 'Freshwater', 7.6, 'live', '2023-09-22 19:05:47', 'Active');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (44, 0012, 0058, 0051, 36, '2023-08-07 19:05:47', 'Saltwater', 6.4, 'freeze-dried', '2023-12-08 19:05:47', 'Inactive');
insert into Tanks (TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status) values (45, 0001, 0069, 0048, 34, '2023-04-22 19:05:47', 'Freshwater', 7.6, 'pellets', '2023-06-09 19:05:47', 'Active');


INSERT INTO Fish
    VALUES (1, 1000, 0050, 'Lorem Ipsum Switch', 'F', 'Sturgeon', 'Alive'),
           (2, 1000, 0029, 'Lorem Ipsum Switch', 'M', 'Sturgeon', 'Alive'),
           (3, 2000, 0052, 'Lorem Ipsum Switch', 'M', 'Tuna', 'Alive'),
           (4, 2000, 0048, 'Lorem Ipsum Switch', 'M', 'Fluke', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (5, 27, 0050, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'M', 'Sardine', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (6, 20, 0029, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'F', 'Haddock', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (7, 33, 0052, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'F', 'Tuna', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (8, 23, 0049, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'M', 'Trout', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (9, 11, 0050, 'consectetur adipiscing elit.', 'M', 'Sardine', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (10, 22, 0048, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'M', 'Haddock', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (11, 43, 0052, 'consectetur adipiscing elit.', 'F', 'Bass', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (12, 22, 0048, 'consectetur adipiscing elit.', 'M', 'Salmon', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (13, 25, 0050, 'consectetur adipiscing elit.', 'F', 'Salmon', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (14, 33, 0039, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'M', 'Salmon', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (15, 5, 0051, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'M', 'Salmon', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (16, 4, 0052, 'Ut enim ad minim veniam', 'M', 'Tuna', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (17, 3, 0049, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'M', 'Haddock', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (18, 38, 0052, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'F', 'Salmon', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (19, 11, 0051, 'Lorem ipsum dolor sit amet', 'M', 'Salmon', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (20, 41, 0049, 'consectetur adipiscing elit.', 'M', 'Trout', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (21, 11, 0048, 'Lorem ipsum dolor sit amet', 'M', 'Tuna', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (22, 10, 0039, 'consectetur adipiscing elit.', 'M', 'Tuna', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (23, 14, 0038, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'M', 'Mackerel', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (24, 7, 0038, 'Lorem ipsum dolor sit amet', 'M', 'Trout', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (25, 29, 0050, 'Ut enim ad minim veniam', 'F', 'Bass', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (26, 42, 0051, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'M', 'Salmon', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (27, 12, 0049, 'Ut enim ad minim veniam', 'M', 'Bass', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (28, 28, 0050, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'M', 'Mackerel', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (29, 41, 0049, 'Ut enim ad minim veniam', 'F', 'Trout', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (30, 20, 0038, 'Lorem ipsum dolor sit amet', 'F', 'Sardine', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (31, 36, 0048, 'Lorem ipsum dolor sit amet', 'F', 'Sardine', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (32, 35, 0048, 'Ut enim ad minim veniam', 'M', 'Haddock', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (33, 27, 0052, 'consectetur adipiscing elit.', 'M', 'Haddock', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (34, 21, 0048, 'consectetur adipiscing elit.', 'F', 'Sardine', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (35, 35, 0039, 'consectetur adipiscing elit.', 'F', 'Tuna', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (36, 6, 0039, 'Lorem ipsum dolor sit amet', 'M', 'Sardine', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (37, 14, 0029, 'consectetur adipiscing elit.', 'F', 'Tuna', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (38, 12, 0048, 'Lorem ipsum dolor sit amet', 'M', 'Bass', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (39, 36, 0038, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'M', 'Cod', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (40, 24, 0028, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'F', 'Salmon', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (41, 26, 0039, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'F', 'Salmon', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (42, 34, 0028, 'consectetur adipiscing elit.', 'M', 'Salmon', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (43, 45, 0038, 'Lorem ipsum dolor sit amet', 'F', 'Sardine', 'Alive');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (44, 4, 0049, 'consectetur adipiscing elit.', 'M', 'Cod', 'Dead');
insert into Fish (FishID, HousedIn, KeptBy, Notes, Sex, Species, Status) values (45, 23, 0029, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'M', 'Sardine', 'Alive');

INSERT INTO Procedures
    VALUES (0003, 9999, 1, 'Scale Removal', 'Invasive', 'Success'),
           (0003, 9998, 2, 'Wound Closure', 'Invasive', 'Success'),
           (0004, 9997, 4, 'Eye Check-Up', 'Non-invasive', 'Failure'),
           (0004, 9996, 4, 'Resuscitation', 'Invasive', 'Failure');
           insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0003, 1, 38, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'eye surgery', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0004, 2, 8, 'Lorem ipsum dolor sit amet', 'eye surgery', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0005, 3, 13, 'Ut enim ad minim veniam', 'eye surgery', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0006, 4, 4, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'tail reconstruction', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0007, 5, 23, 'Lorem ipsum dolor sit amet', 'scale removal', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0008, 6, 33, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'gill repair', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0009, 7, 2, 'consectetur adipiscing elit.', 'fin amputation', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0010, 8, 24, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'fin amputation', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0011, 9, 40, 'Lorem ipsum dolor sit amet', 'eye surgery', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0012, 10, 25, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'scale removal', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0013, 11, 31, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'tail reconstruction', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0014, 12, 38, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'gill repair', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0015, 13, 2, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'fin amputation', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0016, 14, 42, 'Ut enim ad minim veniam', 'eye surgery', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0017, 15, 2, 'consectetur adipiscing elit.', 'scale removal', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0018, 16, 27, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'gill repair', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0019, 17, 28, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'gill repair', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0020, 18, 30, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'scale removal', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0021, 19, 21, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'fin amputation', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0022, 20, 26, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'scale removal', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0023, 21, 6, 'consectetur adipiscing elit.', 'tail reconstruction', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0024, 22, 27, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'tail reconstruction', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0024, 23, 4, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'eye surgery', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0025, 24, 26, 'consectetur adipiscing elit.', 'fin amputation', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0026, 25, 13, 'Lorem ipsum dolor sit amet', 'eye surgery', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0027, 26, 31, 'Ut enim ad minim veniam', 'scale removal', 'Failure');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0003, 27, 29, 'consectetur adipiscing elit.', 'eye surgery', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0004, 28, 3, 'Ut enim ad minim veniam', 'gill repair', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0004, 29, 31, 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'scale removal', 'Success');
insert into Procedures (Surgeon, ProcID, Fish, Description, Type, Result) values (0005, 30, 12, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'gill repair', 'Failure');

INSERT INTO FishProcDate
    VALUES (1, CURRENT_TIMESTAMP),
           (2, CURRENT_TIMESTAMP),
           (4, CURRENT_TIMESTAMP),
           (4, '2023-03-31 19:05:47');
           insert into FishProcDate (FishID, ProcDate) values (24, '2024-04-03 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (5, '2023-10-21 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (20, '2023-07-08 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (12, '2023-10-14 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (10, '2023-04-04 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (17, '2023-06-09 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (6, '023-08-23 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (20, '2023-03-01 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (1, '2023-01-01 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (29, '2023-05-04 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (25, '2023-09-03 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (44, '2023-06-04 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (42, '2023-09-30 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (40, '2023-09-13 19:05:47');
insert into FishProcDate (FishID, ProcDate) values (20, '2023-01-22 19:05:47');

INSERT INTO Prescriptions
    VALUES (9999, 82792, 'Advil', 1.5),
           (9997, 92973, 'CPR', 1.0),
           (9996, 93898, 'Funeral', 1.0);
           insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (11, 1, 'cough syrup', 46.5);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (4, 2, 'painkiller', 14.6);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (12, 3, 'antacid', 25.0);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (29, 4, 'antihistamine', 26.3);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (30, 5, 'antihistamine', 23.1);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (19, 6, 'painkiller', 13.5);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (30, 7, 'antihistamine', 3.8);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (22, 8, 'cough syrup', 41.2);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (26, 9, 'antibiotic', 4.0);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (10, 10, 'antibiotic', 45.8);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (2, 11, 'antibiotic', 13.2);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (5, 12, 'antibiotic', 15.0);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (14, 13, 'antacid', 5.6);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (9, 14, 'antibiotic', 17.3);
insert into Prescriptions (ProcFor, MedID, Medicine, Dosage) values (19, 15, 'antacid', 19.5);

INSERT INTO Tools
    VALUES (10001, 9999, 'Scalpel', 'Clean'),
           (10002, 9999, 'Sutures', 'Used'),
           (10003, 9998, 'Sutures', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (1, 28, 'forceps', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (2, 20, 'retractor', 'Clean');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (3, 27, 'retractor', 'Clean');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (4, 14, 'scalpel', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (5, 27, 'suture needle', 'Clean');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (6, 30, 'hemostat', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (7, 14, 'forceps', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (8, 5, 'retractor', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (9, 18, 'forceps', 'Clean');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (10, 9, 'forceps', 'Clean');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (11, 6, 'scalpel', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (12, 28, 'scalpel', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (13, 18, 'retractor', 'Used');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (14, 4, 'retractor', 'Clean');
insert into Tools (ToolID, ProcUsedIn, Type, Status) values (15, 17, 'forceps', 'Used');

INSERT INTO Finances
    VALUES (20001, 0001, 8000, 5000, CURRENT_TIMESTAMP),
           (20002, 0002, 0, 10000, CURRENT_TIMESTAMP);
           insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (1, 0040, 37701, 83414, '2023-10-25 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (2, 0023, 54754, 91836, '2023-04-23 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (3, 0037, 11935, 67048, '2023-04-08 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (4, 0006, 86992, 24633, '2023-11-03 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (5, 0019, 91222, 18227, '2023-04-01 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (6, 0006, 57814, 47280, '2023-05-22 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (7, 0039, 38989, 97337, '2023-11-14 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (8, 0043, 40641, 73330, '2023-08-21 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (9, 0042, 70289, 10558, '2023-04-28 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (10, 0011, 39626, 27362, '2023-07-03 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (11, 0025, 15822, 85438, '2023-03-06 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (12, 0005, 41828, 32832, '2023-03-29 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (13, 0039, 80529, 75501, '2023-03-09 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (14, 0031, 41970, 90202, '2023-11-09 19:05:47');
insert into Finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values (15, 0016, 25609, 27104, '2023-05-011 19:05:47');

INSERT INTO Reports
    VALUES (101, 1, 0040, 0058, 'Impaled Scale', 'Lorem Ipsum Switch'),
           (102, 2, 0047, 0059, 'Bite Wound', 'Lorem Ipsum Switch'),
           (103, 4, 0028, 0060, 'Lazy Eye', 'Lorem Ipsum Switch');
           insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (1, 7, 0040, 0070, 'behavior report', 'Ut enim ad minim veniam');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (2, 44, 0041, 0066, 'habitat report', 'Ut enim ad minim veniam');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (3, 29, 0036, 0062, 'color report', 'consectetur adipiscing elit.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (4, 41, 0028, 0062, 'color report', 'Ut enim ad minim veniam');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (5, 12, 0052, 0054, 'population report', 'consectetur adipiscing elit.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (6, 4, 0044, 0061, 'behavior report', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (7, 29, 0049, 0059, 'color report', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (8, 38, 0047, 0068, 'behavior report', 'Lorem ipsum dolor sit amet');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (9, 20, 0029, 0062, 'habitat report', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (10, 23, 0028, 0054, 'size report', 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (11, 5, 0047, 0068, 'size report', 'consectetur adipiscing elit.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (12, 32, 0029, 0053, 'size report', 'Lorem ipsum dolor sit amet');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (13, 39, 0039, 0064, 'color report', 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (14, 13, 0030, 0060, 'habitat report', 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.');
insert into Reports (ReportID, FishID, MadeBy, SentTo, Type, Description) values (15, 6, 0047, 0061, 'habitat report', 'consectetur adipiscing elit.');