#!/bin/bash

pkill polybar

polybar top 2>&1 | tee -a /tmp/polybar.log & disown
# polybar left 2>&1 | tee -a /tmp/polybar-left.log & disown
# polybar mid 2>&1 | tee -a /tmp/polybar-mid.log & disown
# polybar right 2>&1 | tee -a /tmp/polybar-right.log & disown

echo "Polybar launched..."
