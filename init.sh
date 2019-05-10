#!/bin/sh

ROOT_DIR=`pwd`
rm -rf typecho
git clone -b nanodm --recurse-submodules https://github.com/ttys3/typecho.git && \
cd typecho/usr/themes && \
git clone https://github.com/Dreamer-Paul/Single.git single  && \
git clone https://github.com/ttys3/typecho-theme-amaze.git amaze && \
git clone https://github.com/shiyiya/typecho-theme-sagiri.git Sagiri && \
git clone https://github.com/Siphils/Typecho-Theme-Aria.git Aria && \
git clone https://github.com/Seevil/fantasy.git fantasy

cd $ROOT_DIR/typecho/usr/plugins && \
git clone https://github.com/ayangyuan/Youtube-Typecho-Plugin Youtube && \
git clone https://github.com/Dreamer-Paul/Pio.git Pio && \
git clone https://github.com/Copterfly/CodeHighlighter-for-Typecho.git CodeHighlighter
git clone https://github.com/ttys3/typecho-AceThemeEditor.git AceThemeEditor

# find . -type d -name Tests -o -name tests -o -name doc -o -name docs | xargs rm -rf
cd $ROOT_DIR