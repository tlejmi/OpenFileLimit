
#!/bin/bash

function updateLine {
  CheckArgument "$1" "No String Pattern";
  CheckArgument "$2" "No String To Update";
  CheckArgument "$3" "No File Provided";  
  if grep -Fq $1 $3; then
    # code if found
    echo sudo sed -i "/^$1/c $2" "$3" ;
    echo "$2 updated in $3 "
  else
     sudo echo $2 >> $3 ;
     echo "$2 added to $3"
  fi
}

function updateNoFileSystem() {
   updateLine "fs.file-max" "fs.file-max = 500000" "/etc/sysctl.conf"
   updateLine "fs.inotify.max_user_instances" "fs.inotify.max_user_instances=524288" "/etc/sysctl.conf"
   updateLine "fs.inotify.max_user_watches" "fs.inotify.max_user_watches=524288" "/etc/sysctl.conf"
   sudo sysctl -p
    echo "/etc/sysctl.conf updated"
}
 function updatelimit() {
     sudo cp ./Security/common-session /etc/pam.d/common-session
     sudo cp ./Security/limits.conf /etc/security/limits.conf
     ulimit -n 500000
     echo "Common-session and Limit Config Updated"
 }