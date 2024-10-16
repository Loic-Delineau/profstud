#!/bin/bash
# HEADER =========================================================================
# Author:       Loïc Delineau
# Date:         16/10/2024
# Platform :    WSL2 & Linux (Ubuntu 24.04)
# Description:  Plots data

# GLOBAL VARIABLES ===============================================================
# tput setaf colours
#
# Color       #define       Value       RGB
# black     COLOR_BLACK       0     0, 0, 0
# red       COLOR_RED         1     max,0,0
# green     COLOR_GREEN       2     0,max,0
# yellow    COLOR_YELLOW      3     max,max,0
# blue      COLOR_BLUE        4     0,0,max
# magenta   COLOR_MAGENTA     5     max,0,max
# cyan      COLOR_CYAN        6     0,max,max
# white     COLOR_WHITE       7     max,max,max

black=0
red=1
green=2
yellow=3
blue=4
magenta=5
cyan=6
white=7

# FUNCTIONS ======================================================================
# Wait for user confirmation (y) to continue or (n) to quit
prompt() {
	
	echo "Continue by entering 'y', stop the script by pressing 'n'"

	# Failsafe for wrong value inputted
	fail="1"

	while [[ "$fail" == "1" ]]; do
		
		# Read 1 input char
		echo -n "> "
		read -n 1 -r cmd < /dev/tty

		# Keyboard input checking
		if [[ "$cmd" == "y" ]]; then
			fail="0"
			echo ""
		elif [[ "$cmd" == "n" ]]; then
			echo ""
			exit
		else
			echo -e "\nUnknown key..."
		fi
done
}

# USER SYSTEM IDENTIFICATION =====================================================
# Checking if you are running this in Linux or WSL2
if `uname -r | grep -q WSL2`; then
	echo "You are running WSL2"
	OS=WSL2
elif `uname -r | grep -q generic`; then
	echo "You are running Bare Metal Linux"
	echo "This script doesn't yet work for Linux, exiting..."
	exit
	OS=LINUX
else 
	echo "You are not running Linux, this script won't work"
	echo "Killing script, please get off your proprietary OS"
	exit
fi

echo ""

 
# GENERATING GRAPH ==============================================================
echo "Reading input.txt and generating a line graph"
echo "Saving it as graph.png in this repo"
echo "Viewing it with wslview"
echo ""

gnuplot -e 'set terminal png; plot "input.txt" with lines' > graph.png
wslview graph.png

echo "Success! Now Exiting..."
echo ""





