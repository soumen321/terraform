import json

def lambda_handler(event, context):
    """
    Simple Lambda function that simulates checking Splunk query results
    """
    # Always return KO status for testing
    result = {
        "status": "KO",
        "query_id": event["query_id"],
        "description": event["description"],
        "ticket_info": {
            "title": f"Test Alert: {event['description']}",
            "description": "This is a test alert",
            "severity": "HIGH",
            "component": "test-component"
        }
    }
    
    return result