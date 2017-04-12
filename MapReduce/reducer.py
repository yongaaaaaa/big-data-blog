#!/usr/bin/env python
import sys
import boto.dynamodb
 
# create connection to DynamoDB
current_keys = None
conn = boto.dynamodb.connect_to_region( '<region>', aws_access_key_id='<access key>', aws_secret_access_key='<secret key>')
table = conn.get_table('<dynamoDB table name>')
item_data = {}

# input comes from STDIN emitted by Mapper
for line in sys.stdin:
    line = line.strip()
    dickeys, items  = line.split('\t')
    products = items.split(',')
    #print dickeys , products 
    if current_keys == dickeys:
       item_data[products[0]]=products[1]  
       #print current_keys
    else:
        if current_keys:
          # print 'current keys:' , current_keys , ' dickeys:' , dickeys , item_data # for dubug
          try:
              mykeys = current_keys.split(',') 
              item = table.new_item(hash_key=mykeys[0] , range_key=mykeys[1], attrs=item_data )
              item.put() 
          except Exception ,e:
              print 'Exeption occurred! :', e.message, '==> Data:' , mykeys
        item_data = {}
        item_data[products[0]]=products[1]
        current_keys = dickeys

# put last data
if current_keys == dickeys:
   #print 'Last one:' , current_keys #, item_data
   try:
       mykeys = dickeys.split(',')
       item = table.new_item(hash_key=mykeys[0] , range_key=mykeys[1], attrs=item_data )
       item.put()
   except Exception ,e:
       print 'Exeption occurred! :', e.message, '==> Data:' , mykeys