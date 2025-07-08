import boto3
import os
import json

def lambda_handler(event, context):
    client = boto3.client('lambda')
    payload = {"message": "Hello from Lambda A!"}
    response = client.invoke(
        FunctionName="lambda-b",  # Use the function name directly
        InvocationType='Event',
        Payload=json.dumps(payload)
    )
    return {"status": "invoked", "response": str(response)} 
