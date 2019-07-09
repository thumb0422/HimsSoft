DROP TABLE IF EXISTS "H_BedInfo";
CREATE TABLE H_BedInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MBedId varchar(10) UNIQUE,
MRoomId varchar(10),
MBedDesc varchar(50),
MUsed bool,
isValid bool);


DROP TABLE IF EXISTS "H_MechineInfo";
CREATE TABLE H_MechineInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MMechineId varchar(10) UNIQUE,
MMechineDesc varchar(50),
MType varchar(10),
MUsed bool,
isValid bool);


DROP TABLE IF EXISTS "H_CustomerInfo";
CREATE TABLE H_CustomerInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MCustId varchar(10) UNIQUE,
MCustName varchar(50),
MCustEId varchar(30),
MUsed bool,
isValid bool);