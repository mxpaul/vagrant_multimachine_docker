#####################################################################################
#### This file is managed via dotfiles repo
#####################################################################################
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1='\[\e[1;$(if [ $UID = 0 ]; then echo 31; else echo 32; fi)m\]\u\[\e[1;34m\]@\[\e[1;31m\]${HOSTNAME:0:1}\[\e[1;37m\]$(h=${HOSTNAME:1}; echo ${h%%.*})\[\e[1;0m\]:\[\e[1;34m\]\w\[\e[1;0m\]\$ '
export LANG=en_US.UTF-8
export EDITOR=vim

# User specific aliases and functions
#export SSH_AUTH_SOCK=~/.ssh-agent.sock

#alias myscreen="screen -AadRRS project_screen -c $HOME/dotfiles/.screenrc_myscreen"
#alias projzip="screen -AadRRS project_screen -c $HOME/screen/.screenrc_projzip"
alias tree='tree -FChp'
alias t1='tree -L 1'
alias t='t1'
alias t2='tree -L 2'
alias tt='t2'
alias gti=git
alias fuck='export SSH_AUTH_SOCK=$(ls -1 /tmp/ssh*/*)'
#chkinodes() { local MP="${1:-/}"; find "$MP" -xdev -printf '%h\n' | sort | uniq -c | sort -k 1 -n; };
topinode() { 
	local DIR=$1;
	[ "$DIR" = "" ] && DIR=/
	if [ $DIR = '/' ]; then local RE=''; else local RE="$DIR"; fi
	find "$DIR" -xdev | perl -lnE '$s++,$h{$1}++ if m{^(\Q'"$RE"'\E/[^/]+)}; END { say "$h{$_} $_" for sort {$h{$a}<=>$h{$b}} keys %h; printf("%d Total %s", $s, '"'$DIR'"') }'
}

# Tmux alias
if [ -f ~/dotfiles/tmux/cloud.session.sh ]; then
	. ~/dotfiles/tmux/cloud.session.sh
fi


if [ -f ~/dotfiles/bash_functions.sh ]; then
	. ~/dotfiles/bash_functions.sh
fi


if [ -f "$HOME/.asdf/asdf.sh" ]; then
	. "$HOME/.asdf/asdf.sh"
fi

if [ -f "$HOME/completions/asdf.bash" ]; then
	. "$HOME/.asdf/completions/asdf.bash"
fi

if [ -d "$HOME/.asdf/bin" ]; then
	export PATH="$PATH:$HOME/.asdf/bin"
fi
