#!/bin/bash
#
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
# Place ddns-server.sh (this file) into ~/scripts
# bash ddns-server.sh {desired record ip address} {vesta username} {domain} {subdomain}

#Establish Variables
ipAddress=$1
VestaUser=$2
Domain=$3
Subdomain=$4
#VESTA="/usr/local/vesta"

#echo $ipAddress
#echo $VestaUser
#echo $Domain
#echo $Subdomain

## FIND ID OF DNS RECORD
dnsID=`$VESTA/bin/v-list-dns-records $VestaUser $Domain | awk '\$2 == "'"$Subdomain"'" { print \$1 }'`
#echo "DNS ID: $dnsID"

## CHECK IF RECORD EXISTS
if [ -z "$dnsID" ]
then
	## Create new record
	#echo "No Record Was Found... Created a New One"
	$VESTA/bin/v-add-dns-record $VestaUser $Domain $Subdomain A $ipAddress
else
	curVal=`$VESTA/bin/v-list-dns-records $VestaUser $Domain | awk '\$2 == "'"$Subdomain"'" { print \$4 }'`
	#echo "Current DNS Value: $curVal"
	#echo "Current IP Address: $ipAddress"
	if [ "$curVal" == "$ipAddress" ]
	then
		#echo "Current IP Matches the current DNS Record. No update required"
		:
	else
		#echo "Old Record Found... Updating"
		## Delete record
		$VESTA/bin/v-delete-dns-record $VestaUser $Domain $dnsID
		## Create new record
		$VESTA/bin/v-add-dns-record $VestaUser $Domain $Subdomain A $ipAddress
		#echo "Record updated"
	fi
fi
#echo "Update Complete"