#!/bin/bash

# File to process
FILE="sample.txt"

# Use sed to perform the replacement
# From line 5 to till the end, Where the word starts with "welcome" 
# Replace the word "give" to "learning"
sed -i '5,$ { /welcome/ s/give/learning/g }' "$FILE"

