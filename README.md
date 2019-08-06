# HimsSoft
PC softWare
1,隔三行取数据
  SELECT D.* FROM H_Data_Detail D
  WHERE 1=1 AND D.DId = '300001|20190806130503' AND
  (SELECT COUNT(*) from H_Data_Detail WHERE createDate<=D.createDate)/3<
  (SELECT COUNT(*) from H_Data_Detail WHERE createDate<=D.createDate)/3.0;
