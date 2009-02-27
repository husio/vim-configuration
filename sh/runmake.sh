#!/bin/bash

# begin settings

[ $TERM ] || TERM=xterm
NOPASTE=nopaste

# end settings

# $1 => make app
MAKE="$1"
# $2 => file name
MAKE_ARG="$2"

LOG_FILE="/tmp/runmake.tmp"

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
    [ -f $LOG_FILE ] && rm $LOG_FILE
    sleep 0.5
    exit 0
}

function runmake_make()
{
    info "command: "
    echo "$MAKE $MAKE_ARG"
    info "out>"
    $MAKE $MAKE_ARG &> $LOG_FILE
    cat $LOG_FILE
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
            $NOPASTE < $LOG_FILE
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
