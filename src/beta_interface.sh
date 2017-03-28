#!/bin/bash

# $>erl -pa ./<path to source> -run mymodule myfunc -run init stop -noshell

display_help()
{
	echo "start		start system"
	echo "stop 		stop system"
}

start_knk()
{
	echo "start knk system"
	erl_status=`which erl`
	if [[ -z "$erl_status" ]]
	then
		echo "Erlang is not installed"
		exit 0
	else
		echo "Compiling...."
		# Compile source code
		make
		echo "Starting knk system...."
		
	fi
}

stop_knk()
{
	echo "stop knk system"
	
}

case "$1" in
	-h | --help)
		display_help
	;;
	start)
		start_knk
	;;
	stop)
		stop_knk
	;;
esac

