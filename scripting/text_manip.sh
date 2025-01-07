#!/bin/bash

# Sample text to manipulate
TEXT="Hello,World! This is a SAMPLE text with numbers 123 and special chars @#$."
echo "Original text: $TEXT"
echo "===================="

# use tr to convert lowercase to upper case and vice versa
echo "$TEXT" | tr '[:lower:]' '[:upper:]'
echo "$TEXT" | tr '[:upper:]' '[:lower:]'

# use sed to replace a substring with another
echo "$TEXT" | sed 's/World/Universe/'
#  remove a substring numbers per say
echo "$TEXT" | sed 's/[0-9]//g'
#add a prefix to each line
echo "$TEXT" | sed 's/^/>> /'

# use grep to search for a pattern
echo "$TEXT" | grep "is"

# search for a pattern in a file or multiple files
grep -i "is" file1.txt file2.txt # case insensitive
grep -w "is" file1.txt file2.txt # whole word only
# recursively search for a pattern in a directory
find . -type f -exec grep -i "is" {} \;

# invert grep results
echo "$TEXT" | grep -v "is"


# use awk to fetch log file data between two dates
awk '/Aug 23 12:51:16/,/Aug 23 12:56:16/' /var/log/messages

# awk to print speficic columns from a file
awk '{print $1,$2}' file.txt
