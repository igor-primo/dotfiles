#!/bin/bash

main() {
  notify-send -u normal "Please, breathe."
  sleep $((5 * 60))
  main
}

main
