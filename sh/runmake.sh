#!/bin/bash

# some settings
[ $TERM ] || TERM=xterm
MAKE="$1"
MAKE_ARG="$2"
NOPASTE=nopaste
TEMP_FILE="/tmp/runmake.tmp"

APP_PATH=`echo $2 | sed -e 's@\(.*\)\/.*@\1@'`
cd $APP_PATH

if [ "$MAKE" == 'make' ]
then
    if ! [ -f 'Makefile' ] 
    then
        # not C source file - exit
        [[ $MAKE_ARG_NAME = *.c ]] || exit 2
        # cut .c extension from MAKE_ARG
        MAKE_ARG_NAME=`echo $MAKE_ARG | sed "s/\(.*\)\.c/\1/"`
        MAKE="cc $MAKE_ARG -o $MAKE_ARG_NAME"
    fi
    MAKE_ARG=""
fi

function info()
{
    echo -en "\e[1;31m$@\e[0m"
}


function runmake_end()
{
    info "out> "
    echo "quit"
    [ -f $TEMP_FILE ] && rm $TEMP_FILE
    sleep 0.5
    exit 0
}

function runmake_make()
{
    info "command: "
    echo "$MAKE $MAKE_ARG"
    info "out>"
    $MAKE $MAKE_ARG &> $TEMP_FILE
    cat $TEMP_FILE
    echo
}

function runmake_info()
{
    echo -en "
 m - make
 p - paste make output
 s - shell commad
 q - quit

"
}

function runmake_loop()
{
    info " in> "
    read -n 1 next_action
    echo ""
    case "$next_action" in
        m)
            runmake_make
            ;;
        p)
            info "\nout> nopaste url:  "
            $NOPASTE < $TEMP_FILE
            echo -ne "\n"
            ;;
        s)
            info " sh> "
            read shell_command
            $shell_command
            ;;
        *)
            runmake_end
            ;;
    esac
    runmake_loop
}

function runmake_start()
{
    runmake_info
    runmake_make
    runmake_loop
}

runmake_start
runmake_end
