DROP TABLE purchase_ext_s3 ; 

CREATE EXTERNAL TABLE purchase_ext_s3 (
customerid string,
orderid    string,
productid  string,
quantity   bigint ) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
LOCATION 's3://<your bucket name>/purchase/';

DROP TABLE purchase_ext_dynamodb ; 

CREATE EXTERNAL TABLE purchase_ext_dynamodb(
      customerid STRING, orderid STRING,
product1  bigint, product2  bigint, product3  bigint, product4  bigint, 
product5  bigint, product6  bigint, product7  bigint, product8  bigint, 
product9  bigint, product10 bigint  )
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler' 
TBLPROPERTIES ("dynamodb.table.name" = "purchase", 
"dynamodb.column.mapping" = "customerid:customerid,orderid:orderid,product1:product1,product2:product2,product3:product3,product4:product4,product5:product5,product6:product6,product7:product7,product8:product8,product9:product9,product10:product10");

INSERT INTO purchase_ext_dynamodb
select customerid as customerid , orderid as orderid 
     , max(CASE WHEN productid = 'productid1' THEN quantity END  ) as product1 
     , max(CASE WHEN productid = 'productid2' THEN quantity END  ) as product2 
     , max(CASE WHEN productid = 'productid3' THEN quantity END  ) as product3 
     , max(CASE WHEN productid = 'productid4' THEN quantity END  ) as product4 
     , max(CASE WHEN productid = 'productid5' THEN quantity END  ) as product5 
     , max(CASE WHEN productid = 'productid6' THEN quantity END  ) as product6 
     , max(CASE WHEN productid = 'productid7' THEN quantity END  ) as product7 
     , max(CASE WHEN productid = 'productid8' THEN quantity END  ) as product8 
     , max(CASE WHEN productid = 'productid9' THEN quantity END  ) as product9 
     , max(case WHEN productid = 'productid10' THEN quantity END )  as product10 
from purchase_ext_s3 
group by customerid, orderid
;
