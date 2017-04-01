#Add the following to your admin user's ~/.bashrc file to import the required environment variables that allows vesta's commands to function properly.

!! REMOVE OR COMMENT OUT " [ -z "$PS1" ] && return " FROM YOUR VERSION OF THIS FILE !!

PATH=$PATH:/usr/local/vesta/bin
export PATH

export VESTA="/usr/local/vesta"
