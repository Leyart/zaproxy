#!/bin/bash
# Script for testing Automation Framework features

RES=0

mkdir -p /zap/wrk/output

echo "Automation Framework integration tests"
echo

cd /zap/wrk/configs/plans/

export JIGSAW_USER="guest"
export JIGSAW_PWORD="guest"

summary="\nSummary:\n"

for file in *.yaml
do
	echo
	echo "Plan: $file"

    /zap/zap.sh -cmd -autorun /zap/wrk/configs/plans/$file -dev
    RET=$?
    
	if [ "$RET" != 0 ] 
	then
	    echo "ERROR"
		summary="${summary}  Plan: $file\tERROR\n"
		RES=1
	else
    	echo "PASS"
		summary="${summary}  Plan: $file\tPASS\n"
	fi
    sleep 2
    # Tidy up
    rm ~/.ZAP_D/config.xml
done

echo -e $summary
echo "Exit Code: $RES"
exit $RES