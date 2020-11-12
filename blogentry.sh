#!/bin/bash

#runs from just outside github path, my case m00-git.github.io

#take input from user
echo "Input Date, Format=YY-MM-DD"
read date

echo "Input Title"
read title

half_file_title=$( echo "${title// /_}" ) 
full_title="${date} ${half_file_title}"
full_file_title="${date}_${half_file_title}"

echo "Input path to assets (images, etc.), Format=/absolute/path/*"
read path #assets will be copied to relevant post folder to be referenced in markdown document & html

mkdir m00-git.github.io/blog/posts/$full_file_title #makes folder in style of YY-MM-DD_Post_Title
cp $path m00-git.github.io/blog/posts/$full_file_title #ports assets into post folder

cp m00-git.github.io/blog/posts/template.md m00-git.github.io/blog/posts/$full_file_title/$full_file_title.md      
#makes new md file from stored template

remarkable m00-git.github.io/blog/posts/$full_file_title/$full_file_title.md 
#opens markdown document for manual making.

#############FUNCTION TO SANDWICH TOGETHER POST HTML#############
pandoc -o temp.html m00-git.github.io/blog/posts/$full_file_title/$full_file_title.md

cp m00-git.github.io/blog/posts/source-top.txt bread-top.txt
cp m00-git.github.io/blog/posts/source-bottom.txt bread-bottom.txt

sed -i "4s|\(.*\)|$title\1|" bread-top.txt
cat temp.html >> bread-top.txt
cat bread-bottom.txt >> bread-top.txt

cp bread-top.txt m00-git.github.io/blog/posts/$full_file_title/$full_file_title.html

#cleanup
rm bread-top.txt
rm bread-bottom.txt
rm temp.html
######################END SANDWICH FUNCTION######################


#return line 38 3times to make space for new entries on blog.html, and a divider between the previous entry
sed -i '38 a\
    ' m00-git.github.io/blog/blog.html
sed -i '38 a\
	' m00-git.github.io/blog/blog.html


#############GENERATE DYNAMIC LINE FUNCTION#############
dynamicline=$full_title
echo $full_title > dynamicline.txt
dynamiclength=$( cat dynamicline.txt | wc -m )
cat dynamicline.txt | wc -m
dynamicoutput=$( cat dynamicline.txt )

while [ $dynamiclength -lt 83 ]
do	
	sed -i 's/$/ /' dynamicline.txt
	#adds an extra space to the dynamic line
	cat dynamicline.txt | wc -m
        dynamiclength=$( cat dynamicline.txt | wc -m )
done

dynamicoutput=$( cat dynamicline.txt )
sed -i "39s|\(.*\)|<inv><a href=\"posts/$full_file_title/$full_file_title.html\">$dynamicoutput</a></inv>\1|" m00-git.github.io/blog/blog.html #place fitted index

#clean up files
rm dynamicline.txt
######################END FUNCTION#######################
#preview new changes
firefox m00-git.github.io/blog/blog.html &

#uhh then I think its done
