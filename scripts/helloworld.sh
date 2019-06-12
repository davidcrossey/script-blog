#!/bin/bash
taskset -c 2 q ./helloworld.q -q -name $1
exit 0;
