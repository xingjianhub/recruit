#!/bin/bash
#git clone git@139.196.31.47:cib-order-group/order-center.git -b dev
git pull
/mnt/sonar/sonar-runner-2.4/bin/sonar-runner
echo "done"
