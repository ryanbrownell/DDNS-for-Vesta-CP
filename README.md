## Abandoned ##
This project is likely going to be abandoned with the approval of a pull request to add the same functionality to Vesta Control Panel itself. If you would help get this pushed into Vesta, please check out the pull request found at https://github.com/serghey-rodin/vesta/pull/1477 and test and add comments indicating that you would use such a feature.

# Dynamic DNS for Vista Control Panel #

## Requirements ##

1. A server with a static public IP address running [Vesta Control Panel](http://vestacp.com)
2. A Linux machine on a network with a dynamic public IP address. (E.g. Raspberry Pi)
3. A domain name.

## Usage ##

### System with the dynamic public IP address ###
- Must have an ssh client installed.
- Must have sshpass installed if you are using password authentication.
- Place ddns-client.sh (this file) into ~/scripts
- Add the following command to the user's cron at your frequency of choice: 
```
bash ddns-client.sh {URL to index.php} {server domain name} {vesta username} {domain} {subdomain} {record type} {OPTIONAL server admin username} {OPTIONAL server admin password}
```
- The optional fields and highly discouraged. **SSH key authentication is strongly recommended.**

### System with the static public IP address ###
- An installation Vesta Control Panel configured with the domain name you wish to use.
- Place index.php into /home/{username}/web/{domain name}/{public_html or public_shtml}/ip (or public_shtml, dependent if you are serving SSL from a different folder)
- Place ddns-server.sh into ~/scripts of your admin user home directory.
- Edit ~/.bashrc in the admin user home directory to include the contents of the included .bashrc file.

### Both Systems ###
- OPTIONAL BUT RECOMMENDED: Set up SSH key for ssh authentication between the two systems. See http://www.linuxproblem.org/art_9.html for more information.

## Warning ##
One means of using this script involves the storing of a password in plaintext in the user's crontab. This practice is generally seen as insecure.
Ideally, you would use an RSA key to connect instead for better security.

## To Do ##
- Reduce the requirements on the client side. Such that all that would be required to call is a simple CURL command to a specific URL accompanied with a token.
