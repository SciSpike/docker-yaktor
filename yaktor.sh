#!/usr/bin/env bash

# Ensures current user is the owner of /app's files
APP_UID=$(id -u)
term=$(tty)
FILE_OWNER_UID=$(stat -c '%u' .)
USER=$(id -un)
if [ ! $APP_UID == $FILE_OWNER_UID ]; then
  echo "Changing ${USER}'s uid from $APP_UID to $FILE_OWNER_UID"
  export >> ~/.bashrc
  #do stuff as root
  exec sudo su <<EOL
    #change user id
    usermod -u $FILE_OWNER_UID $USER
    #give me bach my terminal
    chown yaktor $term
    #do stuff as $USER
    exec su - $USER <<LOE
      #go backto $PWD
      cd $PWD
      #do what every I say with my terminal 
      exec ${@-bash} <$term
LOE
EOL
  
fi
exec ${@-bash}