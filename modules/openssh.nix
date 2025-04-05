{ username, ... }: {
  services.openssh = {
    enable = true;
    # Optional: Disable password authentication and enable key-based authentication
    passwordAuthentication = false;
    # port = 2222; # change default port if desired
  };

  # Optional: Open prot 22 in the firewall (if needed, NixOS utually handles this)
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Optional: Enable systemd service on boot
  systemd.services.sshd.enable = true;

  # Optional: add your user to the wheel group so you can sudo
  users.users.${username}.extraGroups = [ "wheel" ];
}
