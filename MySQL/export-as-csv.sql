SELECT * FROM purchase WHERE <condition_1>
INTO OUTFILE '/data/export/purchase/1.csv' FIELDS TERMINATED BY ',' ESCAPED BY '\\' LINES TERMINATED BY '\n';
SELECT * FROM purchase WHERE <condition_2>
INTO OUTFILE '/data/export/purchase/2.csv' FIELDS TERMINATED BY ',' ESCAPED BY '\\' LINES TERMINATED BY '\n';
...
SELECT * FROM purchase WHERE <condition_n>
INTO OUTFILE '/data/export/purchase/n.csv' FIELDS TERMINATED BY ',' ESCAPED BY '\\' LINES TERMINATED BY '\n';