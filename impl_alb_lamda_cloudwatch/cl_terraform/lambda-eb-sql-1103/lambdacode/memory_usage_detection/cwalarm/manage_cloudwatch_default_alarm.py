#!/usr/bin/python

import boto3
from botocore.exceptions import ClientError
from utils.logger import log
from utils.cloudwatch_helper import *
#from utils.s3_helper import get_json_properties
#from utils.dynamo_db_helper import add_or_update_alarm
import sys
import time
import json

aws_region = "us-east-1"
treatMissingDataProd='breaching'
treatMissingDataNoProd='breaching' #missing data means alarm
property_file="default_cloudwatch_alarms.json"
alarms_to_delete=[]
cloudwatch = boto3.client('cloudwatch', region_name=aws_region)
ec2_client = boto3.client('ec2', region_name=aws_region)

dynamo_db=boto3.resource('dynamodb')
table_name=dynamo_db.Table('alarm_manage_config_lab')

response = table_name.get_item(Key={'name': 'default_cloudwatch_alarms', 'id': '2'})
configuration=json.loads(response['Item']['config'])

def manage_default_alarm(event, context):
    
    default_cloudwatch_alarms = configuration
    print(default_cloudwatch_alarms)
    
    if default_cloudwatch_alarms is None:
        log(0,"No default alarms found")
        return
    Asg_name = event['detail']['AutoScalingGroupName']
    initial_name = Asg_name.split("-asg-")[0]
    
    if event['id'] is not None:
        event['id']="all"
        
    ec2_instance_id = event['id']
    
    #Id id = all, get all the instance with monitoring tag to true of false
    
    reservations=[]
    instanceFilter = [
        {
            'Name': 'tag:monitoring',
            'Values': ['true','false']
        },
        {
            'Name': 'instance-state-name',
            'Values': ['running']
        }
    ]
    if event['id'] == "all":
        instanceFilter.append(
            {
                'Name': 'instance-id',
                'Values': [event['id']]
            }
        )
        
    next_token = "" 
    while True:
        response = ec2_client.describe_instances(
            Filters=instanceFilter, 
            MaxResults=50,
            NextToken=next_token
            )
        reservations += response['Reservations']  
        
        try:
            next_token = response['NextToken']
        except KeyError:
            break
        
    for reservation in reservations:
        for ec2_instance in reservation['Instances']:
            tags = ec2_instance['Tags']
            
            monitoring = None
            enviroment = ""
            autoScalingGroupName = None
            component = None
            
            alarm_tags=[]
            print(tags)
            
            i = 0
            
            for tag in tags:
                if tag.get('Key') == 'Name':
                    instance_name = tag.get('Value').replace("_ec2",'').replace("_asg",'')
                    print(instance_name)
                elif tag.get('Key') == 'monitoring':
                    monitoring = tag.get('Value')
                    print(monitoring)
                elif tag.get('Key') == 'environment':
                    enviroment = tag.get('Value')
                    alarm_tags.append({'Key': 'Environment', 'Value': enviroment})   
                    print(enviroment) 
                elif tag.get('Key') == 'aws:autoscaling:groupName':
                    autoScalingGroupName = tag.get('Value')
                    print(autoScalingGroupName)
                elif tag.get('Key') == 'component':
                    component = tag.get('Value')
                elif tag.get('Key') == 'application':
                    application = tag.get('Value')
                    alarm_tags.append({'Key': 'Application', 'Value': application}) 
                elif tag.get('Key') == 'CostCenter':
                    cost_center = tag.get('Value')
                    alarm_tags.append({'Key': 'CostCenter', 'Value': cost_center})
                    
            if enviroment == "prod":
                treatMissingData=treatMissingDataProd
            else:
                treatMissingData=treatMissingDataNoProd
            if instance_name == initial_name:
                if ec2_instance['State']['Name'] != "terminated":
                    
                    device_name=""
                    flag_rootfs = False
                    flag_xfs = False
                    
                    for disk_alarn_level in default_cloudwatch_alarms['disk_used_percent'].keys():
                       if component is None:
                           continue
                       if "gogw" in component:
                           continue
                       
                       for current_disk in default_cloudwatch_alarms['resouces_to_monitor']['disk'].keys():
                            disk_to_monitor = default_cloudwatch_alarms['resouces_to_monitor']['disk'][current_disk]
                            cloudwatch_alarm = default_cloudwatch_alarms['disk_used_percent'][disk_alarn_level]
                            alarm_name = instance_name + "-" + cloudwatch_alarm['Name'] + "-" + disk_to_monitor['path']
                          
                            if monitoring and monitoring == 'true':
                              
                                dimensions = [
                                    {'Name': 'InstanceId','Value': ec2_instance['InstanceId']},
                                    {'Name': 'path','Value': disk_to_monitor['path']},
                                    {'Name':'ImageId','Value': ec2_instance['ImageId']},
                                    {'Name':'InstanceType','Value': ec2_instance['InstanceType']},
                                    {'Name':'device','Value': disk_to_monitor['device']},
                                    {'Name':'fstype','Value': disk_to_monitor['fstype']} 
                                ]
                                if autoScalingGroupName:
                                    dimensions.append({'Name':'AutoScalingGroupName','Value': autoScalingGroupName})
                                
                                cloudwatch_alarm['TreatMissingData'] = treatMissingData
                                
                                alarm_data = {
                                    'alarm_name': alarm_name,
                                    'alarm_type': 'default',
                                    'status': 'created',
                                    'alarm_state': 'INSUFFICIENT_DATA',
                                    'ASG_name': Asg_name,
                                    'Instance_ID': ec2_instance_id
                                }
                                put_metric_alarm(alarm_name, dimensions, cloudwatch_alarm,alarm_tags)
                            
                            elif monitoring and monitoring == 'false':
                               log(2,"Monitoring tag set to false")
                            else:
                                log(1,"No monitoring tag found")       
                               
                           
                        
                  