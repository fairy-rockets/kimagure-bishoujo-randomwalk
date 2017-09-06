#! /bin/bash

set -eu

CHROME=google-chrome
MAX=14400

for ((i=0; i < 15; i++)); do
  {
    set -x
    ${CHROME} --headless --disable-gpu --remote-debugging-port=$((10000 + $i)) 'http://localhost:8080' &
    sleep 5
    mkdir -p $(printf "img%04d" $i)
    node main.js $i $((10000 + $i)) ${MAX} &
    wait
    set +x
  } &
done

wait