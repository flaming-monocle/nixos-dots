{ config, pkgs, lib, ... }:
let
  inherit (lib) mkOption mkIf types;
  packageName = "packageName";
in

{
  options.custom.moduleName = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable this custom module";
    };
    extraConfig = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "An empty list of strings";
    };
  };
}
