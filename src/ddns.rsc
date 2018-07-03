/log info "Started DDNS script"
:global currIpAddr;

:local newIpAddr [/ip address get [find interface="ether1-gateway"] address];

:for i from=( [:len $newIpAddr] - 1) to=0 do={ 
  :if ( [:pick $newIpAddr $i] = "/") do={
    :set newIpAddr [:pick $newIpAddr 0 $i]
  } 
}

:if ($newIpAddr != $currIpAddr) do={

  /tool dns-update dns-server=<dns_server> name=<dns_name> zone=<dns_zone> key-name=<dns_key_name> key=<dns_key> address=$newIpAddr
  :set currIpAddr $newIpAddr;

  /log info "Updated IP address"
}

/log info "Finished DDNS script"
