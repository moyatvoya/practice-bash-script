# check if the text file was passed
((!$#)) && { echo "No arguments supplied" ; exit 1; }

# take arguments from file and read line by line
# read line using splitter " " (space)
# there should be 4 arguments f1 f2 f3 f4 (user group hash folder)
# if one argument is empty the message of empty argument appears
while IFS=" " read -r f1 f2 f3 f4
do
        [ ! -z $f1 ] && [ ! -z $f2 ] && [ ! -z $f3 ] && [ ! -z $f4 ] && \
			      grep -q "^$f2" /etc/group && \
                useradd -g $f2 -m -d /home/"$f4" -p $f3 -c "User $f1 created" $f1 && \
                  printf 'Group:%s; home folder: %s; ' $f2 $f4 && \
                    printf '%s\n' "" && \
                      printf 'Hashsum:%s\n\n' $f3 || \
                        printf "User:%s hasn't been added\nCheck if the arguments match\n\n" $f1
done < $1
