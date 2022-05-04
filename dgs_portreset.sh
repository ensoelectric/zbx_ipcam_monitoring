#!/bin/bash

if [[ $# -ne 3 ]] ; then
    echo 'Usage:'
    echo '	./dgs_portreset.sh host community oid'
    exit 1 
fi

snmp_poe_set()
{
    snmpset -c $2 -v 2c $1 $3 i $4
}

if [[ $(snmpwalk -c $2 -v 2c $1 $3  | awk -F ": " '{print $2}') -eq 1 ]]
then
    snmp_poe_set $1 $2 $3 2 #disable PoE
    sleep 10
    snmp_poe_set $1 $2 $3 1 #enable PoE
fi
