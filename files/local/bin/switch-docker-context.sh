docker context use $(\
    yad \
    --title="Select Docker Context" \
    --height=300 \
    --separator="" \
    --list \
    --column="" \
    --no-headers \
    $(docker context ls -q) \
)
