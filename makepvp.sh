#!/bin/bash
# makepvp.sh
# (c) 2023 Tom Hansen <tomh@uwm.edu>
# License: MIT
# The MIT License (MIT) may be found at http://opensource.org/licenses/MIT
# 
# makepvp: make preview images for all nvim colorschemes
# (from ~/.config/nvim/colors/*.vim)
# requires: neovim, google-chrome, imagemagick `convert' command
# usage: ./makepvp.sh
# output: python/*.png, python/*.jpg
mkdir -p python/{big,med,thumb}
for i in ~/.config/nvim/colors/*.vim; do 
    bn=`basename $i .vim`
    echo == $bn ==
    nvim --headless +"colorscheme $bn" +'TOhtml' +"w! python/$bn.html" +'qa!' preview.py 2> /dev/null
    google-chrome --headless --no-gpu --force-device-scale-factor=2 --screenshot="python/$bn-ss.png" "python/$bn.html" 2> /dev/null
    convert python/$bn-ss.png -crop 800x400+0+0 -filter Gaussian  -resample 300x300 python/big/$bn-big.png
    convert python/$bn-ss.png -crop 400x200+0+0 -filter Gaussian  -resample 300x300 python/med/$bn-med.png
    convert python/$bn-ss.png -crop 200x200+0+0 -resample 64x64 python/thumb/$bn.jpg
done

# TODO: make a user interface for selecting colorschemes and previewing them
#       using a simple web js framework like bootstrap or jquery.
#       (or maybe just use a simple python script to generate a static html page)
#
# TODO: maybe a script to classify colorschemes as light or dark
