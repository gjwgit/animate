#!/bin/bash

MODEL="animate"

date +"%Y-%m-%d %H:%M:%S"

time /usr/bin/expect <<EOD
set timeout 300

spawn ml install ${MODEL}
expect "*${MODEL}*Y/n*"
send "Y\n"
expect eof

spawn ml readme ${MODEL}
expect eof

spawn ml configure ${MODEL}
expect eof

spawn ml demo ${MODEL}
expect "Press Enter to continue on to a sports analytics example: "
send "\n"
expect "Press Enter to view the generated animation: "
send "\n"
expect "Press Enter to continue on to view a smoother animation: "
send "\n"
expect "Press Enter to display the animation: "
send "\n"
expect "Press Enter to finish this demonstration: "
send "\n"
expect eof

EOD

echo
ls -lht ~/.mlhub/${MODEL}/animate*.gif
echo
date +"%Y-%m-%d %H:%M:%S"
