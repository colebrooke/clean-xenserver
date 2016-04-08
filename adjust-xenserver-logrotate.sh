#!/bin/bash

# To be run on xenservers to adjust logrotate for system logs and xen related logs
# to maximise root disk space.

# Firstly change system log retention from 4 weeks down to 1 week:
sed -i 's/rotate 4/rotate 1/g' /etc/logrotate.conf

# Secondly change xenserver related log rotation retention from 9999 down to 7 days:
sed -i 's/rotate 9999/rotate 7/g' /etc/logrotate-xenserver.conf

# Now clean up compressed logs older than one week:
find /var/log -iname \*.gz -delete

