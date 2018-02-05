let syslogServerAddress = "192.168.0.2";
    nixwrt = import ./nixwrt.nix rec {
  target = "yun";
  monitConfig = {
    interfaces.wired = {
      device = "eth1";
      address = "192.168.0.251";
      defaultRoute = "192.168.0.254";
    };
    services = {
      dropbear = {
        start = "${pkgs.dropbear}/bin/dropbear -s -P /run/dropbear.pid";
        depends = [ "wired"];
      };
      syslogd = { start = "/bin/syslogd -R ${syslogServerAddress}"; 
                  depends = ["wired"]; };
      ntpd =  { start = "/bin/ntpd -p pool.ntp.org" ;
                depends = ["wired"]; };
    };
  };
  ssh.authorizedKeys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFYv/Cko02eYOqXJGKIlp75/LC1rYZeFarwSHS2XdYoFv57G4rEcN9O4mkOTVjQYmJV3+PhqAkAqJ5wOM35Ub55Bm0+sAnxcA4kzP1TFMMAmydMftXvOQr5G+FP24R+8CADz3R3Jr94vQ/vbQjV3lgb7vAg1i2MPadfadodKOkSkj9tDLPGf+iVTwVBv5p9QwCV1BOTFMfZQlPxBCtXAwY8ds9CLw5dDlnBd6+i44JP4M2FLlA1Qvm+nn6orYmz4GYMop9dx46T5DD+MBt6lnnJZXh+SUa5SIIq/7nNRrKH1H6EZwGvTld8Fwp1wxx6164UoM1/QNAimBUFhFdPyrH dan@carobn" ];
} ; in nixwrt
