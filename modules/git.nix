{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.unstable.git;
    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
    userEmail = "elias06wennerlund@gmail.com";
    userName = "Elias Wennerlund";
    extraConfig = {
      # FIXME: uncomment the next lines if you wantt o be able to clone private https repos
      # url = {
      #   "https://oauth2:${secrets.github_token}@github.com" = {
      #     insteadOf = "https://github.com";
      #   };
      #   "https://oauth2:${secrets.gitlab_token}@github.com" = {
      #     insteadOf = "https://gitlab.com";
      #   };
      # };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      merge = { conflictstyle = "diff3"; };
      diff = { colorMoved = "default"; };
    };
  };
}
