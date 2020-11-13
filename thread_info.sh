#!/bin/bash

if [ -z "$1" ]
  then
    echo -e "\033[1;31mThe process name not supplied\033[0m"
    exit 1
fi

PID=$(ps -fC $1 | awk '{print $2}' | sed -n 2p)
if [ -z "$PID" ]
  then
    echo -e "\033[1;31mProcess not found\033[0m"
    exit 1
fi

THREAD_NUM=$(cat /proc/${PID}/status | grep "Threads" | awk '{print $2}')

echo -e "Process name: \033[1;32m$1\033[0m"
echo -e "Process id: \033[1;32m$PID\033[0m"
echo -e "Total thread number: \033[1;32m$THREAD_NUM\033[0m\n"

echo "Thread list:"
echo -e "\033[1;32m$(cat /proc/${PID}/task/*/status | grep "Name" | awk '{print $2}')\033[0m\n"
