#!/bin/bash

for i in {1..9}    # product id 
do 
  for j in {1..100}  # order  id 
  do 
    for k in {1..1000000}   # customer id 
    do 
       echo inserting....  customeridA$k , orderidA$j , productid$i 
       mysql test  -u root -e "insert into test.purchase values( 'customeridA$k' , 'orderidA$j', 'productid$i' ,100  )"
       echo updating....  customerid$k , orderid$j ,  productid$i 
       mysql test  -u root -e "update test.purchase set quantity = 99  where customerid = 'customerid$k' and orderid = 'orderid$j' and productid ='productid$i' "
       echo deleting....  customerid$k , orderid$j ,  productid20
       mysql test  -u root -e "delete from test.purchase where productid = 'productid10' and   customerid = 'customerid$k' and orderid = 'orderid$j'  "
    done
  done
done