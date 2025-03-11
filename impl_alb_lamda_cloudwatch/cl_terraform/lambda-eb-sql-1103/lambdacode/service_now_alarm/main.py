#!/usr/bin/python

from cwalarm.manage_cloudwatch_default_alarm import manage_default_alarm
from utils.logger import log
from datetime import datetime
from zoneinfo import ZoneInfo

import json
import sys


def main(event, context):

    print(event)

    if 'report_alarm state' in event and event['report_alarm_state'] is not None:
        #alarm_reporting(event,context)
        log(0,"No report_alarm")

    if 'detail-type' in event and 'detail' in event and event["detail-type"] == "EC2 Instance Launch Successful":
        ec2_id= event["detail"]["EC2InstanceId"]
        event['add_default'] = True
        event['add_process'] = True
        event['add_elb_healthy'] = True
        event['id'] = ec2_id
        event['action'] = 'create'
        
    if 'add_default' in event and event['add_default'] is not None:
        manage_default_alarm(event, context)

