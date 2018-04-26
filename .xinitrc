
if [ -s ~/.Xmodmap ]; then
    # Load custom keyboard key bindings
	xmodmap ~/.Xmodmap
fi;

redshift &

nm-applet &

# lock screen after 5 minutes inactivity or when mouse in bottom right corner for 1 second
xautolock -time 5 -locker slock -nowlocker slock -detectsleep -corners 000+ -cornerdelay 1 &

# # mostly copied from default
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

 # merge in defaults and keymaps

 if [ -f $sysresources ]; then

     xrdb -merge $sysresources

 fi

 if [ -f $sysmodmap ]; then
     xmodmap $sysmodmap
 fi

 if [ -f "$userresources" ]; then

     xrdb -merge "$userresources"

 fi

 if [ -f "$usermodmap" ]; then
     xmodmap "$usermodmap"
 fi

 # start some nice programs

 if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
   [ -x "$f" ] && . "$f"
  done
  unset f
 fi

xbindkeys

# exec awesome
exec i3 -V # >> ~/i3log/$(date +'%F-%k-%M-%S') 2>&1
