let nixwrt = import ./nixwrt.nix {
  target = "yun";
  interfaces.wired = {
    device = "eth1";
    ipAddress = "192.168.0.251";
    defaultRoute = "192.168.0.254";
  };
  syslogServerAddress = "192.168.0.2";
  ssh.authorizedKeys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFYv/Cko02eYOqXJGKIlp75/LC1rYZeFarwSHS2XdYoFv57G4rEcN9O4mkOTVjQYmJV3+PhqAkAqJ5wOM35Ub55Bm0+sAnxcA4kzP1TFMMAmydMftXvOQr5G+FP24R+8CADz3R3Jr94vQ/vbQjV3lgb7vAg1i2MPadfadodKOkSkj9tDLPGf+iVTwVBv5p9QwCV1BOTFMfZQlPxBCtXAwY8ds9CLw5dDlnBd6+i44JP4M2FLlA1Qvm+nn6orYmz4GYMop9dx46T5DD+MBt6lnnJZXh+SUa5SIIq/7nNRrKH1H6EZwGvTld8Fwp1wxx6164UoM1/QNAimBUFhFdPyrH dan@carobn" ];
};
in nixwrt.tftproot
