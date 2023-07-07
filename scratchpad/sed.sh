

# find a string, and comment out the next two lines
sed -e '/syncopated/,+2 s/^/#/'
