#!/bin/bash

USER_ID=${USER_ID:-1000}
echo "$0 - setting mysql user to UID $USER_ID"

# if [ ! -z "$USER_ID" ]; then
#   echo "entrypoint-mysql.sh - adding user id $USER_ID"
#   # add groups - assume the same id as userid
#   if [ -z "$GROUP_ID" ]; then
#     GROUP_ID=$USER_ID
#   fi
#   groupadd --gid $GROUP_ID local_name
#   useradd --shell /bin/bash --gid $GROUP_ID --uid $USER_ID --non-unique --comment "" --create-home local_name
#   # modify positional args
#   set -- --user=local_name --log_error_verbosity=1 $@
# fi

usermod -u $USER_ID mysql
groupmod -g $USER_ID mysql

exec /entrypoint.sh --user=mysql $@
