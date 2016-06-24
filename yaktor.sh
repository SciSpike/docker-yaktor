#!/usr/bin/env bash

# Ensures current user is the owner of /app's files
APP_UID=$(id -u)
term=/dev/console
FILE_OWNER_UID=$(stat -c '%u' .)
USER=$(id -un)
if [ ! $APP_UID == $FILE_OWNER_UID ]; then
  env | awk '{print "export " $0}' >> ~/.env
  echo "Changing ${USER}'s uid from $APP_UID to $FILE_OWNER_UID"
  #do stuff as root
  exec sudo su <<EOL
    #change user id
    sed -i.b s/yaktor:x:$APP_UID/yaktor:x:$FILE_OWNER_UID/g /etc/passwd
    #give me back my terminal or give me null
    ls $term && chown yaktor $term || ln -s /dev/null $term
    #give me back my home
    chown -R yaktor /home/yaktor
    #do stuff as $USER
    exec su - $USER <<LOE
      #go backto $PWD
      cd $PWD
      #do what every I say with my terminal
      . ~/.env
      . ~/.profile
      exec ${@-bash} <$term
LOE
EOL
  
fi
. ~/.profile
exec ${@-bash}