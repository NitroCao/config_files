export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &
xcompmgr &
volumeicon &
xrdb .Xresources
setxkbmap -option ctrl:nocaps
feh --bg-fill ~/Pictures/wallpaper.png
exec i3
