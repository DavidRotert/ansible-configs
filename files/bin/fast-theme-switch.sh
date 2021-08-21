#!/bin/bash

if [[ -e $1 ]]
then
    source $1
else
    source ~/.theme-profiles/$1
fi

# Change Xfce theme
[[ -n "$GTK_Theme" ]] && xfconf-query -c xsettings -p /Net/ThemeName -s "$GTK_Theme"
# Change icon theme 2 times because else it is not properly set
[[ -n "$Icon_Theme" ]] && xfconf-query -c xsettings -p /Net/IconThemeName -s "$Icon_Theme"
[[ -n "$Icon_Theme" ]] && xfconf-query -c xsettings -p /Net/IconThemeName -s "$Icon_Theme"
[[ -n "$WM_Theme" ]] && xfconf-query -c xfwm4 -p /general/theme -s "$WM_Theme"
[[ -n "$WM_Button_Layout" ]] && xfconf-query -c xfwm4 -p /general/button_layout -s "$WM_Button_Layout"

[[ -n "$QT_Icon_Theme" ]] && sed -i "s/icon_theme=[a-zA-Z_\-]*/icon_theme=$QT_Icon_Theme/g" ~/.config/qt5ct/qt5ct.conf

[[ -n "$Kvantum_Theme" ]] && sed -i "s/theme=[a-zA-Z_\-]*/theme=$Kvantum_Theme/g" ~/.config/Kvantum/kvantum.kvconfig

[[ -n "$Plank_Theme" ]] && dconf write "/net/launchpad/plank/docks/dock1/theme" "'$Plank_Theme'"

if [[ -n "$Wallpaper" ]]
then
    for monitor in $(xfconf-query -c xfce4-desktop -p /backdrop -l | egrep -e "screen.*/monitor.*/last-image")
    do
        xfconf-query -c xfce4-desktop -p $monitor -s "$Wallpaper"
    done
fi

