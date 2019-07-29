CREATE TABLE IF NOT EXISTS H_BedInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MBedId varchar(10) UNIQUE,
MRoomId varchar(10),
MBedDesc varchar(50),
isValid Integer );

CREATE TABLE IF NOT EXISTS H_Bed_States (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MBedId varchar(10),
MUsedDate date);

CREATE TABLE IF NOT EXISTS H_MechineInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MMechineId varchar(10) UNIQUE,
MMechineDesc varchar(50),
MLink varchar(8),
MAddress varchar(30),
MPort varchar(10),
isValid Integer );

CREATE TABLE IF NOT EXISTS H_Mechine_States (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MMechineId varchar(10),
MUsedDate date);

CREATE TABLE IF NOT EXISTS H_CustomerInfo (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MCustId varchar(10) UNIQUE,
MCustName varchar(50),
MCustEId varchar(30),
isValid Integer);

CREATE TABLE IF NOT EXISTS H_Customer_States (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
MCustId varchar(10),
MUsedDate date);

CREATE TABLE IF NOT EXISTS H_CBMData (
MID INTEGER PRIMARY KEY AUTOINCREMENT,
MCustId varchar(10),
MBedId varchar(10),
MMechineId varchar(10),
MDesc varchar(50),
MCureDate datetime,
isValid INTEGER,
createDate datetime DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')));

CREATE TABLE if NOT EXISTS H_Data_Main (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
DId varchar(50) UNIQUE,
MCustId varchar(10),
MCureDate varchar(10),
startTime datetime,
endTime datetime,
createDate datetime DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')));

CREATE TABLE if NOT EXISTS H_Data_Detail (
MId INTEGER PRIMARY KEY AUTOINCREMENT,
DId varchar(50),
VenousPressure NUMERIC(10,2),
DialysisPressure NUMERIC(10,2),
TMP NUMERIC(10,2),
BloodFlow NUMERIC(10,2),
UFFlow NUMERIC(10,2),
BloodPressure NUMERIC(10,2),
TotalBlood NUMERIC(10,2),
Temperature NUMERIC(10,2),
createDate datetime DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')));

CREATE TABLE if NOT EXISTS H_Const (
MId INTEGER PRIMARY KEY AUTOINCREMENT,MType varchar(4),MCode varchar(8) UNIQUE,MDesc varchar(50));

INSERT INTO H_Const (MType,MCode,MDesc) VALUES
('1000','10001001','串口'),
('1000','10001002','网口'),
('1000','10001003','HD-BOX'),
('1000','10001004','不支持');