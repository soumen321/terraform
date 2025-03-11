#!/usr/bin/python

import time

def log(level, message):
    current_time = time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())
    log_level = ["INFO", "ERROR", "DEBUG","WARN"]
    print(current_time + " " + log_level[level] + " " + message)