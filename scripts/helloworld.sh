#!/bin/bash
taskset -c 2 q /home/dcrossey/script-demo/helloworld.q -q -name $1
exit 0;
