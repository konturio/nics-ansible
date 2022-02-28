#!/bin/bash
 
if [ "x$JBOSS_HOME" = "x" ]; then
    JBOSS_HOME="{{nics_keycloak_home}}"
fi
 
if [[ "$1" == "domain" ]]; then
    $JBOSS_HOME/bin/domain.sh -c $2 -b $3 $JBOSS_OPTS
else
    $JBOSS_HOME/bin/standalone.sh -c $2 -b $3 $JBOSS_OPTS
fi