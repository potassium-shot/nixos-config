#!/bin/sh

/run/current-system/sw/bin/amdctl -m -p0 -v88 # default: 72
/run/current-system/sw/bin/amdctl -m -p1 -v104 # default: 88
/run/current-system/sw/bin/amdctl -m -p2 -v120 # default: 104

/run/current-system/sw/bin/nvidia-smi -i 0 -pl 100 # default: 115

