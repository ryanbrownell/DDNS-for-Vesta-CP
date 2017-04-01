#!/bin/bash

# Simple Dynamic DNS Script for VESTA CP.
#
#  Copyright ©2016 Ryan Brownell
#  ryan@ryanbrownell.com
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
## WARNING
# One means of executing this method involves the storing of a password in plaintext
# in the user's crontab.
# Ideally, you would use an RSA key to connect instead for better security.
# You have been warned.
#
## USAGE
# COMPUTER ATTACHED TO THE NETWORK WITH THE WAN DYNAMIC IP ADDRESS.
# Must have an ssh client installed.
# Must have sshpass installed if you are using password authentication.
# Place ddns-client.sh (this file) into ~/scripts
#
# SERVER WITH VISTA CP.
# Place index.php into /home/{username}/web/{domain name}/{public_html or public_shtml}/ip 
# (or public_shtml, dependent if you are serving SSL from a different folder)
# Place ddns-server.sh into ~/scripts of your admin user home directory.
# Edit ~/.bashrc in the admin user home directory to include the contents
# of the included .bashrc file.
#
# Add the following command to the user's cron at your frequency of choice:
# bash ddns-client.sh {URL to index.php} {server domain name} {vesta username} {domain} {subdomain} {server admin username} {server admin password} 
# You only need to include the server admin password if you did not set up an ssh key.
# See: http://www.linuxproblem.org/art_9.html for more information.

#Establish Variables
ipPingAddress=$1
remoteServer=$2
vestaUser=$3
domain=$4
subdomain=$5
recordType=$6
remoteServerUser=$7
remoteServerPass=$8

## GET WAN IP ADDRESS 
ipAddress=`curl -k -s $ipPingAddress`
#echo "IP Address: $ipAddress"

## Send WAN IP ADDRESS TO VESTA CP SERVER FOR PROCESSING
if [ -z "$remoteServerPass" ]
then
	ssh -o "StrictHostKeyChecking no" $remoteServerUser@$remoteServer "~/scripts/ddns-server.sh $ipAddress $vestaUser $domain $subdomain $recordType"
else
	sshpass -p $remoteServerPass ssh -o "StrictHostKeyChecking no" $remoteServerUser@$remoteServer "~/scripts/ddns-server.sh $ipAddress $vestaUser $domain $subdomain $recordType"
fi