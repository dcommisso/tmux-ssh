#!/bin/bash

HOSTS=$@
SESSION_NAME=tmux-ssh-$(date -u '+%Y%m%d%H%M%S')

# open new detached session
tmux new -d -s $SESSION_NAME

# open a new pane for each ssh host to connect
for host in $HOSTS
do
    tmux split-window -t $SESSION_NAME "ssh $host"
done
tmux select-layout -t $SESSION_NAME tiled

# enable mouse
tmux set-option mouse on

# set synchronize keybindings
tmux bind-key -T prefix "C-s" set-option synchronize-panes on
tmux bind-key -T prefix "C-u" set-option synchronize-panes off

# attach to created session
tmux attach -t $SESSION_NAME
