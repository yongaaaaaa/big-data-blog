DROP TABLE purchase_ext_s3; 

-- To read data from S3  
CREATE EXTERNAL TABLE purchase_ext_s3 (
customerid string,
orderid    string,
productid  string,
quantity   string) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
LOCATION 's3://<your bucket name>/purchase/';



-- To connect to DynamoDB table  
DROP table purchase_ext_dynamodb ; 
CREATE EXTERNAL TABLE purchase_ext_dynamodb (
      customerid STRING, orderid STRING, products ARRAY<STRING>)
      STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler' 
      TBLPROPERTIES ("dynamodb.table.name" = "purchase", 
      "dynamodb.column.mapping" = "customerid:customerid,orderid:orderid,products:products");


-- Batch-puts to DynamoDB using Brickhouse 
add jar /<jar file path>/brickhouse-0.7.1-SNAPSHOT.jar ; 
create temporary function collect as 'brickhouse.udf.collect.CollectUDAF';
INSERT INTO purchase_ext_dynamodb 
select customerid as customerid , orderid as orderid
       ,collect(concat(productid,':' ,quantity)) as products
      from purchase_ext_s3
      group by customerid, orderid; 
