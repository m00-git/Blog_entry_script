#!/bin/bash
date=$1
shorttitle=$2
fulltitle=$3
body=$4
postname="${date}_${shorttitle}"
filename="${date}_${shorttitle}.html"
sed -i '48 a\
	' index.html
sed -i "49s|\(.*\)|<p class=\"mt-5 text-green text-spacey\"><p>----------------==========###########==========----------------<h3>$date</h3><h4>$fulltitle</h4><p>$body</p>\1|" index.html
#puts new post in main homepage
cp ./posts/template.html  ./posts/$filename
sed -i '46 a\
	' ./posts/$filename
sed -i "47s|\(.*\)|<p class=\"mt-5 text-green text-spacey\"><p>----------------==========###########==========----------------<h3>$date</h3><h4>$fulltitle</h4><p>$body</p>\1|" ./posts/$filename
#makes new post its own linkable post
sed -i '89 a\
	' ./posts/posts.html
sed -i "90s|\(.*\)|<TR><TD BACKGROUND=\"fade.gif\"><A HREF="$filename">$postname</A></TR>\1|" ./posts/posts.html
#uploads new post to the sorted POSTS page




#sed -i '48 = returns after line 48, making line 48 blank.
#sed '49s = edits the now blank line 49 with our new blog entry
#then it copies over our template.html, and does the same thing. Creating an entry to the homepage, and its own linkable entry. 
#put script in /var/www/html      syntax will be "sudo bash blogentry.sh "date-here" "title-here" "body-here"
#<p class="mt-5 text-green text-spacey"><p>----------------==========###########==========----------------<h3>DATE</h3><h4>TITLE</h4>BODY</p>

