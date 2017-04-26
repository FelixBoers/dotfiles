#!/bin/bash

shopt -s extglob

PATH=$PATH:$HOME/bin

alias git='LANG=en_US.UTF-8 git'
alias g='git'
__git_complete g _git

alias gs='g status'
__git_complete gs _git_status
alias gsb='g status -sb'
__git_complete gsb _git_status

alias gb='g branch'
__git_complete gb _git_branch
alias gbr='g branch -r'
__git_complete gbr _git_branch
alias gba='g branch -a'
__git_complete gba _git_branch
alias gbav='g branch -av'
__git_complete gbav _git_branch

alias gco='g checkout'
__git_complete gco _git_checkout
alias gcom='g checkout master'
__git_complete gcom _git_checkout
alias gcob='g checkout -b'
__git_complete gcob _git_checkout

alias gm='g merge'
__git_complete gm _git_merge
alias gma='g merge --abort'
__git_complete gma _git_merge

alias grb='g rebase'
__git_complete grb _git_rebase
alias grbm='g rebase master'
__git_complete grbm _git_rebase
alias grbom='g rebase origin/master'
__git_complete grbom _git_rebase
alias grbi='g rebase -i'
__git_complete grbi _git_rebase
alias grbc='g rebase --continue'
__git_complete grbc _git_rebase
alias grba='g rebase --abort'
__git_complete grba _git_rebase
alias grbs='g rebase --skip'
__git_complete grbs _git_rebase

alias gf='g fetch'
__git_complete gf _git_fetch
alias gfa='g fetch --all --tags --prune'
__git_complete gfa _git_fetch

alias gl='git pull'
__git_complete gl _git_pull
alias glr='git pull --rebase'
__git_complete glr _git_pull
alias gp='git push'
__git_complete gp _git_push

alias gc='g commit'
__git_complete gc _git_commit
alias gca='g commit -a'
__git_complete gca _git_commit

alias ga='g add'
__git_complete ga _git_add
alias gap='g add -p'
__git_complete gap _git_add
alias gaa='g add .'
__git_complete gaa _git_add
alias gaap='g add -p .'
__git_complete gaap _git_add

alias gd='g diff'
__git_complete gd _git_diff

alias glg='g log --oneline --decorate --graph'
__git_complete glg _git_log
alias glga='g log --oneline --decorate --graph --all'
__git_complete glga _git_log

alias gcp='g cherry-pick'
__git_complete gcp _git_cherry_pick
alias gcpc='g cherry-pick --continue'
__git_complete gcpc _git_cherry_pick
alias gcpa='g cherry-pick --abort'
__git_complete gcpa _git_cherry_pick
alias gcpq='g cherry-pick --quit'
__git_complete gcpq _git_cherry_pick

alias gsvn='g svn'
__git_complete gsvn _git_svn
alias gsvnr='g svn rebase'
__git_complete gsvnr _git_svn
alias gsvnf='g svn fetch'
__git_complete gsvnf _git_svn
alias gsvnc='g svn dcommit'
__git_complete gsvnc _git_svn
alias gsvnb='g svn branch'
__git_complete gsvnb _git_svn
alias gsvnm='g merge-svn'

alias gui='gitk --all &'
alias gex='gitextensions browse ${pwd} &'
alias sln='findAndOpenSln'

alias e='explorer .'

alias vim='/c/Program\ Files\ \(x86\)/vim/vim80/vim.exe'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'                  # list all files in detailed list
alias la='ls -A'                    # list all files excluding . and .. in columns
alias ld='ls -d .*/ */'             # list only directories - include hidden directories
alias l='ls -CF'

function findAndOpenSln {
	files=(); opt=; count=;
	while IFS= read -r -d $'\0'; do
		files+=("$REPLY")
	done < <(find . -name '*.sln' -print0)

	count=${#files[@]}

	if [ $count -eq 0 ]; then
		echo 'No solution file found found'
		return
	fi

	if [ $count -eq 1 ]; then
		opt=${files[0]}
		return
	fi

	if [ $count -gt 1 ]; then
		echo "Multiple solutions found"
		PS3="Pick a solution: "
		select opt in "${files[@]}"; do
			case $REPLY in
				+([0-9]))
					if (( $REPLY > 0 && $REPLY <= $count )); then
						break
					fi;;
			esac
		done
	fi

	echo "Open solution: $opt"
	start "$opt"
}
