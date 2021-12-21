BOLD='\033[1m'
DARKGREY='\033[1;30m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
NORMAL='\033[0m'
RED='\033[0;31m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'

function prompt() {
  echo -en "$1"
  read -p " (y/n) " -n 1 -r || exit 1; echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then return 0 # true
  else return 1 # false
  fi
}

function echo_and_run() {
  echo -e "$GREEN`pwd`$WHITE\$ $@" $NORMAL
  "$@" || { echoerr -e $RED"Looks like that didn't work.$YELLOW ¯\_(ツ)_/¯ $NORMAL"; exit 1; }
}
echoerr() { echo "$@" 1>&2; }

function identify_pkg_manager(){
  declare -A osInfo;
  osInfo[/etc/redhat-release]=yum
  osInfo[/etc/arch-release]=pacman
  osInfo[/etc/gentoo-release]=emerge
  osInfo[/etc/SuSE-release]=zypp
  osInfo[/etc/debian_version]="sudo apt install -y"
  
  for f in ${!osInfo[@]}
  do
      if [[ -f $f ]];then
          echo Package installation command: ${osInfo[$f]}
      fi
  done
}

function install_package(){

  declare -A INSTALLERS=( 
      [apt]="sudo apt install -y"
      [brew]="brew install"
      [dnf]="sudo dnf install --assume yes"
      [pip]="pip install"

  )

  
  if [[ $# -ne 2 ]]; then
      echo "Specify package installer and package to install"
      echo "Received $#, $*"
      exit 1
  fi

  package=$1
  installer=$2

  if ! [[ ${INSTALLERS[$installer]} && $(command -v "$installer") ]];
  then
      echo "$installer is an unsupported installer."
      echo "Either _helpers.sh needs to know about it in INSTALLERS"
      echo "or it is not installed on this system."
  fi
  
  echo "Install $package with $installer"
  echo "$package" | xargs -I _ ${INSTALLERS[$installer]} _
}
