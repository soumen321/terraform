import json

def lambda_handler(event, context):
    """
    Simple Lambda function that simulates creating a ServiceNow ticket
    """
    # Get ticket info from the event
    ticket_info = event['ticket_info']
    
    # Simulate ticket creation with a mock response
    return {
        'statusCode': 200,
        'ticket_number': 'INC0010001',
        'ticket_sys_id': 'test123'
    }