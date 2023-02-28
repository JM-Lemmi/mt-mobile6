:global currentIP;
 
:local newIP [/ipv6 address get [find interface="lte1" !link-local] address];
 
:if ($newIP != $currentIP) do={
    :put "ip address $currentIP changed to $newIP";
    :local newIPbits [:toip6 [:pick $newIP 0 [:find $newIP "/"]]];
    :put "ip6 is $newIPbits";
    :local prefix ($newIPbits & ffff:ffff:ffff:ffff:0:0:0:0);
    :put "prefix is $prefix";
    :local lanaddr ($prefix | ::f);
    :put "lan addr is $lanaddr";
    /ipv6 address remove [find comment="dyn mobile6"];
    /ipv6 address add interface=bridge address=$lanaddr advertise=yes comment="dyn mobile6";
    :set currentIP $newIP;
}
