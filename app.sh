#!/bin/ash

CONFEXT="ssl"

bail()
{
  echo $1
  exit 1
}

# Make sure /profiles exists
if [ -d "/profiles" ]; then
  cd /profiles
else
  bail "/profiles does not exist!"
fi

# If we dont supply a config, then pick one at random
if [ -z "${CONFIGFILE}" ]; then
#  CONFIGFILE=$(find . -maxdepth 1 -type f -name "*.ssl" | shuf -n 1)
  CONFIGFILE=$(ls -1 *.${CONFEXT} | shuf -n 1)
fi

echo "Using Config: ${CONFIGFILE}"
if [ ! -r ${CONFIGFILE} ]; then
  bail "${CONFIGFILE} is not readable under /profiles!"
fi

exec stunnel ${CONFIGFILE}
