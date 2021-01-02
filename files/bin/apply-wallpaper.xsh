#!/usr/bin/env xonsh

import random, time

def applyImage(img):
    for monitor in $(xfconf-query -c xfce4-desktop -p /backdrop -l | egrep -e @("screen.*/monitor" + ${...}.get("CM", "") + ".*/last-image")).split("\n"):
        if (monitor == ""):
            continue
        ![xfconf-query -c xfce4-desktop -p @(monitor) -n -t string -s ""]
        ![xfconf-query -c xfce4-desktop -p @(monitor) -s ""]
        ![xfconf-query -c xfce4-desktop -p @(monitor) -s @(img)]
        print(monitor, img)
 
def pickKeyword():
    keywords = [
        "library",
        "office",
        "nature",
        "architecture",
        "building",
        "interior",
        "stars",
        "mountains",
        "forest",
        "tree",
        "modern",
        "animal",
        "structure",
        "pattern",
        "city",
        "wild",
        "flower",
        "dark%20forest"
    ]
    return random.choice(keywords)

def pickSize():
    keywords = [
        "hd%20",
        "high%20definition%20",
        "wallpaper%20",
        "4k%20",
        "8k%20",
        ""
    ]
    return random.choice(keywords)

def downloadImage():
    return !(wget --no-check-certificate -O ~/.cache/wallpaper-download.jpg @("https://source.unsplash.com/random/?{}{}".format(pickSize(), pickKeyword())))
      
if __name__ == "__main__":
    max_retries = 5
    for i in range(0, max_retries):
        result = downloadImage()
        if result.returncode == 0:
            !(cp -f "~/.cache/wallpaper-download.jpg" "~/.cache/wallpaper.jpg")
            applyImage(${"HOME"} + "/.cache/wallpaper.jpg")
            break
        time.sleep(2)
