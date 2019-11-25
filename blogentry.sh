#!/bin/bash
date=$1
title=$2
body=$3
sed -i '21 a\
	' index.html
sed -i "22s|\(.*\)|<div class=\"main_top\"><h1>$date</h1></div><div class=\"main_body\"><p>$title</p><p>$body</p>\1|" index.html


#sed -i '21 = returns after line 21, making line 22 blank.
#sed '22s = edits the now blank line 22 with our new blog entry
#put script in /var/www/html      syntax will be "sudo bash blogentry.sh "date-here" "title-here" "body-here"
