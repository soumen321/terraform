import json
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    """
    Lambda function handler.
    Logs the incoming event and returns a response.
    """
    # Log the incoming event
    logger.info("Received event: " + json.dumps(event, indent=2))

    # Add your custom logic here
    # For example, you can process the Auto Scaling Group event
    if "detail-type" in event and event["detail-type"] == "EC2 Instance Launch Successful":
        logger.info("New EC2 instance launched in the Auto Scaling Group.")
    elif "detail-type" in event and event["detail-type"] == "EC2 Instance Terminate Successful":
        logger.info("EC2 instance terminated in the Auto Scaling Group.")

    # Return a response
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Lambda!',
            'event': event
        })
    }