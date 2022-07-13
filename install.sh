#!/bin/bash
#lsb_release -a ... returns system information
#sed -e '/^#/d' ... delete line with sign: #

rm /tmp/package_list &> /dev/null

cat <<EOF> package
#programming language
python3

#aplication return path to the file
which

#returns system information
lsb_release
EOF

echo $@ >> $PWD/'package'

os_ubuntu(){
    #Ubuntu, Linux Mint, Elementary OS
    [ -f '/tmp/package_list' ] \
        && sudo apt-get install -y $(cat /tmp/package_list)
}

echo -e 'OS:' $(lsb_release -sd) '\n... ... ... ...'

sed -e '/^$/d' -e '/^#/d' package |\
while read line_of_text;
do
    which $line_of_text 1> /dev/null \
        && echo 'PATH:' $(which $line_of_text) \
        || echo $line_of_text >> /tmp/package_list
done

case $(lsb_release -sd) in
    'Ubuntu 21.10') os_ubuntu ;;
                 *) echo 'Nie można rozpoznać systemu...'
esac
