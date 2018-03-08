#!/bin/bash

# Configures IRODS to user
# Need to have existing IDA account
# USAGE:
# sh configure_irods.sh <ida_account>
# Tapio Vuorenmaa 2016

USR=$(whoami)
IRODDIR=~/.irods
#IRODDIR=~/.itest
ENVFILE=.irodsEnv
NEWENV=irods_environment.json

if [ ! -d "$IRODDIR" ]; then
  mkdir $IRODDIR
fi

if [ -n "$1" ]; then

cat > $IRODDIR"/"$ENVFILE << EOF
irodsHost ida.csc.fi
irodsPort 1247
irodsUserName $1
irodsZone ida
irodsHome /ida/uef/sysgen
EOF

cat > ${IRODDIR}/${NEWENV} << EOF
{ 
	"irods_home": "/ida/uef/sysgen",
	"irods_user_name": "${1}", 
	"irods_host": "ida.csc.fi", 
	"irods_zone_name": "ida", 
	"irods_port": 1247, 
	"irods_authentication_scheme": "native" 
}
EOF
echo "Config file set."
echo "Start using iRods:"
iinit

else
echo "No CSC username given."
echo "> sh script.sh <username>"

fi
