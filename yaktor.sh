#!/usr/bin/env bash

# Ensures current user is the owner of /app's files
APP_UID=$(id -u)
term=/dev/console
FILE_OWNER_UID=$(stat -c '%u' /app)
USER=$(id -un)
if [ ! $APP_UID == $FILE_OWNER_UID ]; then
  env | awk '{print "export " $0}' >> ~/.env
  echo "Changing ${USER}'s uid from $APP_UID to $FILE_OWNER_UID"
  #do stuff as root
  exec sudo su <<EOL
    #change user id
    sed -i.b s/node:x:$APP_UID/node:x:$FILE_OWNER_UID/g /etc/passwd
    #give me back my terminal or give me null
    ls $term && chown node $term || ln -s /dev/null $term
    #give me back my home
    chown -R node /home/node
    #do stuff as $USER
    exec su - $USER <<LOE
      #go back to $PWD
      cd $PWD
      #do what ever I say with my terminal
      . ~/.env
      . ~/.profile
      exec ${@-bash} <$term
LOE
EOL
fi

. ~/.profile
exec ${@-bash}
