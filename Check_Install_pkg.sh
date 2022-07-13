#!/bin/bash
REQUIRED_PKG=('python3' 'git' 'docker')
echo ${REQUIRED_PKG[@]}
if [ "" = grep '$USER ALL=(ALL) NOPASSWD:ALL' ]; then
  echo "Permissionless sudo is unabled. Activating mode..."
  sudo bash -c 'echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoer.d/99_sudo_include_file'
else
  echo "Permissionless sudo is enabled"
fi
  
for pkg in ${REQUIRED_PKG[@]}; do
  PKG_CHECK=$(dpkg-query -W --showformat='${Status}' $pkg|grep "install ok installed")
  echo Checking for $pkg : $PKG_CHECK
  if [ "" = "$PKG_CHECK" ] ; then 
    echo "NO $REQUIRED_PKG. Please install"
    sudo apt-get install $pkg --yes
  else
    echo "Version installed:" $(dpkg-query -W -f '${Version}' $pkg)  
  fi
done
