#!/usr/bin/env bash

echo "enter bridge interface name"
bridge_name=$(gum input --placeholder="br0" --value="br0")

echo "choose interface to use as a bridge "
bridge_slave=$(ifconfig | awk '{print $1}'|grep en| sed 's/://' |gum choose)

echo "enter ip address for bridge interface"
current_ip=$(ip address | grep ${bridge_slave} | grep inet | awk '{print $2}')
ipaddr=$(gum input --placeholder="${current_ip}" --value="${current_ip}")

echo "enter gateway"
gateway=$(gum input --placeholder="192.168.41.1" --value="192.168.41.1")

echo "enter dns"
dns=$(gum input --placeholder="192.168.41.1" --value="192.168.41.1")

echo "enter dns search"
search=$(gum input --placeholder="syncopated.net" --value="syncopated.net")

clear

printf "bridge name: $bridge_name \nbridge slave: $bridge_slave\n"
printf "bridge address: $ipaddr\nbridge gateway: $gateway\n"
printf "bridge dns: $dns\nbridge dns search: $search\n"
echo -e "----------------------"

gum confirm "does this all look correct?"

if [ $? = 0 ]; then
  nmcli connection add type bridge autoconnect yes con-name ${bridge_name} ifname ${bridge_name}

  nmcli connection modify br0 ipv4.addresses ${ipaddr} ipv4.method manual

  nmcli connection modify br0 ipv4.gateway ${gateway}

  nmcli connection modify br0 ipv4.dns ${dns}

  nmcli connection modify br0 ipv4.dns-search ${search}

  nmconnection=$(nmcli connection show | grep ${bridge_slave} | awk -F '  ' '{print $1}')

  nmcli connection delete "${nmconnection}"

  nmcli connection add type bridge-slave autoconnect yes con-name ${bridge_slave} ifname ${bridge_slave} master ${bridge_name}

  gum confirm "reboot?" && sudo shutdown -r now

else
  echo "ok then, try again. exiting"
  exit
fi
