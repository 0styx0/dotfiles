[[ $TERM != "screen" ]] && exec tmux

infoWithLess() {
	info $1 | less;
}

alias info=infoWithLess;

learn() {

	file="$(find $1 -maxdepth 1 -regex '.*test[0-9].txt' | sort | tail -1)";

	if [ -r "${file}" ]; then
		vim "${file}" < `tty` > `tty`
	fi

}

alias learn=learn;

alias search="w3m duckduckgo.com";

alias wifi-test="ping archlinux.org";

export VISUAL=vim
export EDITOR="$VISUAL"

source /etc/profile.d/undistract-me.sh

source ~/.bash_profile

