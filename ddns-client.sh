#!/bin/bash
#
# Simple Dynamic DNS Script for VESTA CP.
#
#  Copyright © 2016 Ryan Brownell
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
# This method involves the storing of a password in plaintext in the root user's crontab.
# Ideally, you would use an RSA key to connect instead for better security.
# To do this, you will need to modify the script below.
# You have been warned.
#
## USAGE
# COMPUTER ATTACHED TO THE NETWORK WITH THE WAN DYNAMIC IP ADDRESS.
# Must have an ssh client installed.
# Must have sshpass installed. (Required for password authentication.)
# Place ddns-client.sh (this file) into ~/scripts
# Place ddns-server.sh into ~/scripts
#
# SERVER WITH VISTA CP.
# Place index.php into /home/{username}/web/{domain name}/{public_html or public_shtml}/ip (or public_shtml, dependent if you are serving SSL from a different folder)
#
# Add the following command to the root user's cron at your frequency of choice:
# bash ddns-client.sh {URL to index.php} {server domain name} {server root username} {server root password} {vesta username} {domain} {subdomain}

#Establish Variables
ipPingAddress=$1
remoteServer=$2
remoteServerUser=$3
remoteServerPass=$4
vestaUser=$5
domain=$6
subdomain=$7


## GET WAN IP ADDRESS 
ipAddress=`curl -k -s $ipPingAddress`

## Send WAN IP ADDRESS TO VESTA CP SERVER FOR PROCESSING
sshpass -p $remoteServerPass ssh -o "StrictHostKeyChecking no" $remoteServerUser@$remoteServer 'bash -s' < ~/scripts/ddns-server.sh $ipAddress $vestaUser $domain $subdomain
