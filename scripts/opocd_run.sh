#!/bin/bash

cfg_dir="./openocd_scripts"
openocd -f $cfg_dir/jtag_vpi.cfg -f $cfg_dir/syntacore_example.cfg