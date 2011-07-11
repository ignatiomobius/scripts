#!/bin/bash

# actual display settings
disper --displays=auto -t left -e
#if [ -f ~/.right.tmp ] ; then
#  disper --displays=auto -t left -e
#  rm ~/.right.tmp
#else
#  disper --displays=auto -t right -e
#  touch ~/.right.tmp
#fi

# count attached monitors (2 needed) 
lines=`disper -l|wc -l`

display_count=$((lines / 2))

# move panles (suppose external monitor is prefered for main display)
if [ $display_count = 1 ] ; then
   gconftool-2 \
        --set "/apps/panel/toplevels/bottom_panel_screen0/monitor" \
        --type integer "0"
   gconftool-2 \
        --set "/apps/panel/toplevels/top_panel_screen0/monitor" \
        --type integer "0"
else
   gconftool-2 \
        --set "/apps/panel/toplevels/bottom_panel_screen0/monitor" \
        --type integer "1"
   gconftool-2 \
        --set "/apps/panel/toplevels/top_panel_screen0/monitor" \
        --type integer "1"
fi
