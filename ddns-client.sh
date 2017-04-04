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
## USAGE
# ddns-client.sh {URL to index.php} {server domain name} {vesta username} {domain} {subdomain} {record type} {OPTIONAL server admin username} {OPTIONAL server admin password}

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