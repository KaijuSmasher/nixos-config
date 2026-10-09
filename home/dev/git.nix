{config, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "KaijuSmasher";
        email = "kaijusmasher1998@gmail.com";
      };
      init.defaultBranch = "main";
      core = {
        autocrlf = "input";
        safecrlf = "warn";
      };
    };
  };
}
