import json

def lambda_handler(event, context):
    print("Received event:", json.dumps(event))
    return {"status": "received"} 