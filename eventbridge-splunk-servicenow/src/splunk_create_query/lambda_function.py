import json

def lambda_handler(event, context):
    """
    Simple Lambda function that returns a test Splunk query
    """
    queries = [
        {
            "query_id": "test_query",
            "search": "search index=test status=failed",
            "description": "Test query for failed status"
        }
    ]
    
    return {
        'statusCode': 200,
        'queries': queries
    }