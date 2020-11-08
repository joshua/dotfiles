# set SHELL to an absolute path
export SHELL=/usr/local/bin/zsh

# Enable color
export CLICOLOR=true

# C/C++ settings
export CPPFLAGS=-I/opt/X11/include
# export CC=/usr/local/bin/gcc-4.2

# Make atom the default editor
# export VISUAL='atom'
# export EDITOR='atom'

# Make vscode the default editor
export VISUAL='code'
export EDITOR='code'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';
