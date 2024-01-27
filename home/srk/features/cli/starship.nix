{ pkgs, lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {

      format =let
          git = "$git_branch$git_commit$git_state$git_status";
          cloud = "$aws$gcloud$openstack";
        in
        ''
          $directory($nix_shell)(${git})(- ${cloud}) $fill $conda$go$lua$nodejs$package$python$rust$jobs($cmd_duration)
          $character$shlvl
        '';

      fill = {
        symbol = " ";
        disabled = false;
      };

      username = {
        disabled = true;
      };

      # If I can keep my prompt over ssh, then maybe it's useful.
      # But how do I do that?
      hostname = {
        format = "[@$hostname]($style) ";
        ssh_only = false;
        ssh_symbol = "󰣀";
        style = "bold yellow";
        disabled = true;
      };
      shlvl = {
        format = "[$symbol]($style) ";
        style = "bold green";
        repeat = true;
        threshold = 3;
        repeat_offset = 1;
        disabled = false;
      };

      cmd_duration = {
        format = " [$duration]($style) ";
      };

      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style)) ";
      };

      nix_shell = {
        format = "[$state$symbol(\($name\))]($style) ";
        impure_msg = "";
        symbol = " ";
        style = "dimmed red";
      };

      character = {
        error_symbol = "[~~>](bold red)";
        success_symbol = "[->>](bold green)";
        vimcmd_symbol = "[<<-](bold yellow)";
        vimcmd_visual_symbol = "[<<-](bold cyan)";
        vimcmd_replace_symbol = "[<<-](bold purple)";
        vimcmd_replace_one_symbol = "[<<-](bold purple)";
      };

      time = {
        format = "\\\[[$time]($style)\\\]";
        disabled = true;
      };

      # Icon changes only \/
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      gcloud.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      nim.symbol = "󰆥 ";
      nodejs.symbol = " ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      python.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      shlvl.symbol = "❯";
      swift.symbol = "󰛥 ";
      terraform.symbol = "󱁢";
    };
  };
}
