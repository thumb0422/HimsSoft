CREATE TABLE IF NOT EXISTS H_BedInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MBedId varchar(10) UNIQUE,
MRoomId varchar(10),
MBedDesc varchar(50),
MUsed Integer,
isValid Integer );


CREATE TABLE IF NOT EXISTS H_MechineInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MMechineId varchar(10) UNIQUE,
MMechineDesc varchar(50),
MCom Integer,
MNet Integer,
MHDBox Integer,
MUsed Integer,
isValid Integer );


CREATE TABLE IF NOT EXISTS H_CustomerInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MCustId varchar(10) UNIQUE,
MCustName varchar(50),
MCustEId varchar(30),
MUsed Integer,
isValid Integer);

CREATE TABLE IF NOT EXISTS H_CBMData (MID INTEGER PRIMARY KEY AUTOINCREMENT,MCustId varchar(10),
MBedId varchar(10),MMechineId varchar(10),
MDesc varchar(50),isValid INTEGER,
createDate datetime DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')));