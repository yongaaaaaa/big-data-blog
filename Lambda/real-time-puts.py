from __future__ import print_function

import base64
import json
import boto3

print('Loading function')
client = boto3.client('dynamodb')

def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    for record in event['Records']:
        # Kinesis data is base64 encoded so decode here
        payload = base64.b64decode(record['kinesis']['data'])
        print("Decoded payload: " + payload)
        data = json.loads(payload)
        
        # user logic for data triggered by WriteRowsEvent
        if data["type"] == "WriteRowsEvent":
            my_table = data["table"]
            my_hashkey = data["row"]["values"]["customerid"]
            my_rangekey = data["row"]["values"]["orderid"]
            my_productid = data["row"]["values"]["productid"]
            my_quantity = str( data["row"]["values"]["quantity"] )
            # print( my_table ,my_hashkey, my_rangekey, my_productid  )  # for debug 
            try:
                response = client.get_item( Key={'customerid':{'S':my_hashkey} , 'orderid':{'S':my_rangekey}} ,TableName = my_table )
                if 'Item' in response:
                    item = response['Item']
                    item[data["row"]["values"]["productid"]] = {"S":my_quantity}
                    result1 = client.put_item(Item = item , TableName = my_table )
                    # print( 'result1 ==> ' , result1  )  # for debug 
                else:
                    item = { 'customerid':{'S':my_hashkey} , 'orderid':{'S':my_rangekey} , my_productid :{"S":my_quantity}  }
                    result2 = client.put_item( Item = item , TableName = my_table )
                    # print ( 'result2 ==> ' ,  result2    ) # for debug 
            except Exception, e:
                print( 'WriteRowsEvent Exception ! :', e.message  , '==> Data:' ,data["row"]["values"]["customerid"]  , data["row"]["values"]["orderid"] )
        
        # user logic for data triggered by UpdateRowsEvent
        if data["type"] == "UpdateRowsEvent":
            my_table = data["table"]
            
        # user logic for data triggered by DeleteRowsEvent    
        if data["type"] == "DeleteRowsEvent":
            my_table = data["table"]
            
            
    return 'Successfully processed {} records.'.format(len(event['Records']))
