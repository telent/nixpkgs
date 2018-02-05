pkgs: { interfaces, services ? {} } : 
let lib = pkgs.lib;
    intf = name : attrs : ''
   check network ${name} interface ${attrs.device}
     start program = "/bin/sh -c '/bin/ifconfig ${attrs.device} ${attrs.address} up ${ lib.optionalString (builtins.hasAttr "defaultRoute" attrs) "&& route add default gw ${attrs.defaultRoute} dev ${attrs.device}"} '"
     stop program = "/bin/ifconfig ${attrs.device} down"
     if failed link then restart
   '';
   makeService = (name: spec : let spec_ = {
     pidfile = "/run/${name}.pid";
     uid = 0;
     gid = 0;
     stop = "/bin/kill \\\$MONIT_PROCESS_PID";
   } // spec; in ''
    check process ${name} with pidfile ${spec_.pidfile}
      start program = "${lib.strings.escape ["\""] spec_.start}"
        as uid ${toString spec_.uid} gid ${toString spec_.gid}
      stop program = "${lib.strings.escape ["\""] spec_.stop}"
      depends on ${lib.strings.concatStringsSep ", " spec_.depends}
    '');
in ''
  set init
  set daemon 30
  set httpd port 80
    allow localhost
    allow 192.168.0.0/24
  set idfile /run/monit.id
  set statefile /run/monit.state
  ${lib.strings.concatStringsSep "\n" (lib.attrsets.mapAttrsToList intf interfaces)}
  ${lib.strings.concatStringsSep "\n" (lib.attrsets.mapAttrsToList makeService services)}
  ''
  
