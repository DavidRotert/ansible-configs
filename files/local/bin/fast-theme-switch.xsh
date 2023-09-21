#!/usr/bin/xonsh

import sys
import os

from configparser import ConfigParser


def replace_tilde(path):
    if path.startswith("~/"):
        path = path.replace("~", $HOME, 1)

    return path


def set_xfconf(section, setting, value):
    # TODO: set type flag
    $[xfconf-query -c @(section) -p @(setting) -s @(value)]

def sed_inifile(key, value, file):
    $[sed -i @(f"s/{key}=[ a-zA-Z_\\-]*/{key}={value}/g") @(file)]


def apply_themes(styles):
    if "GTK_Theme" in styles:
        set_xfconf("xsettings", "/Net/ThemeName", styles["GTK_Theme"])

    if "WM_Theme" in styles:
        set_xfconf("xfwm4", "/general/theme", styles["WM_Theme"])

    if "Kvantum_Theme" in styles:
        sed_inifile("theme", styles["Kvantum_Theme"], f"{$HOME}/.config/Kvantum/kvantum.kvconfig")
    
    if "Plank_Theme" in styles:
        $[dconf write "/net/launchpad/plank/docks/dock1/theme" @("'" + styles["Plank_Theme"] + "'")]

    if "Albert_Theme" in styles:
        sed_inifile("theme", styles["Albert_Theme"], f"{$HOME}/.config/albert.conf")


def apply_wm(wm):
    if "WM_Button_Layout" in wm:
        set_xfconf("xfwm4", "/general/button_layout", wm["WM_Button_Layout"])


def apply_icon_themes(icons):
    if "Icon_Theme" in icons:
        set_xfconf("xsettings", "/Net/IconThemeName", icons["Icon_Theme"])
        set_xfconf("xsettings", "/Net/IconThemeName", icons["Icon_Theme"])

    if "QT_Icon_Theme" in icons:
        sed_inifile("icon_theme", icons["QT_Icon_Theme"], f"{$HOME}/.config/qt5ct/qt5ct.conf")


def apply_wallpaper(wallpaper):
    if "Wallpaper" in wallpaper:
        image = replace_tilde(wallpaper["Wallpaper"])

        if image == "variety":
            sed_inifile("Hidden", "false", f"{$HOME}/.config/autostart/variety.desktop")
            $[variety --next]
        else:
            for monitor in $(xfconf-query -c xfce4-desktop -p /backdrop -l | grep -E "screen.*/monitor.*/last-image").rstrip().split("\n"):
                $[xfconf-query -c xfce4-desktop -p @(monitor) -n -t string -s ""]
                $[xfconf-query -c xfce4-desktop -p @(monitor) -s ""]
                set_xfconf("xfce4-desktop", monitor, image)
            sed_inifile("Hidden", "true", f"{$HOME}/.config/autostart/variety.desktop")


def apply_theme_profile(theme_profile):
    if "themes" in theme_profile:
        apply_themes(theme_profile["themes"])

    if "xfwm" in theme_profile:
        apply_wm(theme_profile["xfwm"])

    if "icons" in theme_profile:
        apply_icon_themes(theme_profile["icons"])

    if "wallpaper" in theme_profile:
        apply_wallpaper(theme_profile["wallpaper"])

    $[sleep 2]
    $[albert restart &]


def apply_theme_profile_file(profile_file):
    theme_profile = ConfigParser()
    theme_profile.read(profile_file)

    apply_theme_profile(theme_profile)


def main():
    theme_profile_file = None
    if (len(sys.argv) <= 1):
        theme_profiles_list = $(ls ~/.theme-profiles/).rstrip().split("\n")
        if "wallpaper-night" in theme_profiles_list:
            theme_profiles_list.remove("wallpaper-night")
        if "wallpaper-day" in theme_profiles_list:
            theme_profiles_list.remove("wallpaper-day")

        # yad seems to append ""\n so selection in Xonsh, so we ignore the last three chars
        yad_selected_theme = $(yad --title="Select theme preset" --height=300 --separator="" --list --column="" --no-headers @(theme_profiles_list) )
        if yad_selected_theme == "":
            exit(0)
        selected_theme = yad_selected_theme[:-3]
        theme_profile_file = f"{$HOME}/.theme-profiles/{selected_theme}"
    else:
        name_or_path = sys.argv[1]
        if os.path.exists(name_or_path):
            theme_profile_file = name_or_path
        else:
            theme_profile_file = f"{$HOME}/.theme-profiles/{name_or_path}"

    apply_theme_profile_file(theme_profile_file)


if __name__ == "__main__":
    main()
