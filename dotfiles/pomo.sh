#!/usr/bin/env sh

cycle () {
    notify-send "Starting pomodoro cycle $1 at 0 min."
    for i in {1..25}; do
        sleep 60
        notify-send "Pomodoro at $i min."
    done
    sleep 10
    if [ "$1" != "4" ]; then
        notify-send -u critical "End of one cycle. Rest 5 min."
        sleep 300
    else
        notify-send -u critical "End of 4 cycles. Rest 15 min."
        sleep 900
    fi
}

main () {
    for i in {1..4}; do
        cycle "$i"
    done
    main
}

main
