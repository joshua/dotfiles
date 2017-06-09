

### Changing Directories #######################################################

# If a command is issued that can’t be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
# This option is only applicable if the option SHIN_STDIN is set, i.e. if
# commands are being read from standard input. The option is designed for
# interactive use; it is recommended that cd be used explicitly in scripts to
# avoid ambiguity.
setopt auto_cd

# If the argument to a cd command (or an implied cd with the AUTO_CD option set)
# is not a directory, and does not begin with a slash, try to expand the
# expression as if it were preceded by a ‘~’
setopt cdable_vars

# Don’t push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups


### Completion #################################################################

# Prevents aliases on the command line from being internally substituted before
# completion is attempted. The effect is to make the alias a distinct command
# for completion purposes.
setopt complete_aliases

# don't beep on an ambiguous completion
setopt no_list_beep


### Expanding and Globbing #####################################################

# treat #, ~, and ^ as part of patterns for filename generation
setopt extended_glob


### Input/Output ###############################################################

# Do not exit on end-of-file. Require the use of exit or logout instead. However,
# ten consecutive EOFs will cause the shell to exit anyway, to avoid the shell
# hanging if its tty goes away.
#
# Also, if this option is set and the Zsh Line Editor is used, widgets
# implemented by shell functions can be bound to EOF (normally Control-D)
# without printing the normal warning message. This works only for normal
# widgets, not for completion widgets.
setopt ignore_eof


### Job Control ################################################################

# don't run background jobs at a lower priority
setopt no_bg_nice

# don't send the HUP signal to running jobs when the shell exits
setopt no_hup


### Scripts and Functions ######################################################

# If this option is set when a signal trap is set inside a function, then the
# previous status of the trap for that signal will be restored when the function
# exits. Note that this option must be set prior to altering the trap behaviour
# in a function; unlike LOCAL_OPTIONS, the value on exit from the function is
# irrelevant. However, it does not need to be set before any global trap for
# that to be correctly restored by a function. For example,
#
#     unsetopt localtraps
#     trap - INT
#     fn() { setopt localtraps; trap '' INT; sleep 3; }
#
# will restore normal handling of SIGINT after the function exits.
setopt local_traps
