#!/bin/bash
#Author: D Chiranjeevi Rao
#Date Creation: 25/08/2023
#Descriptuion: This script will send a mail to your mailI'D if the server is down (Using ping command)
#Date Modification: 25/08/2023
 

# Server to ping
SERVER="your_server_ip_or_hostname"

# Email configuration
EMAIL="recipient_email_address"
SUBJECT="Server Ping Alert"
MESSAGE="/tmp/server_ping_alert.txt"

# Time duration: 24 hours = 86400 seconds
ENDTIME=$(( $(date +%s) + 86400 ))

while [[ $(date +%s) -lt $ENDTIME ]]; do
    # Try pinging the server
    ping -c 1 $SERVER > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        # If ping fails, send an email using sendmail
        echo "The server $SERVER is not responding to ping." > $MESSAGE
        cat $MESSAGE | sendmail -s "$SUBJECT" $EMAIL
    fi

# Wait for 60 seconds before checking again
    sleep 60
done
# Clean up
rm -f $MESSAGE