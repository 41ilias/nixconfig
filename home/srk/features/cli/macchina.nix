{ pkgs, ... }:

{
  home.packages = [
    pkgs.macchina
  ];

  xdg.configFile."macchina/macchina.toml".text = ''
    # Specifies the network interface to use for the LocalIP readout
    interface = "wlp1s0"
    
    # Lengthen uptime output
    long_uptime = true
    
    # Lengthen shell output
    long_shell = true
    
    # Lengthen kernel output
    long_kernel = false
    
    # Toggle between displaying the current shell or your user's default one.
    current_shell = true
    
    # Toggle between displaying the number of physical or logical cores of your
    # processor.
    physical_cores = false
    
    # Themes need to be placed in "$XDG_CONFIG_DIR/macchina/themes" beforehand.
    # e.g.:
    #  if theme path is /home/foo/.config/macchina/themes/Sodium.toml
    #  theme should be uncommented and set to "Sodium"
    #
    theme = "srk_nixos"
    
    # Displays only the specified readouts.
    # Accepted values (case-sensitive):
    #   - Host
    #   - Machine
    #   - Kernel
    #   - Distribution
    #   - OperatingSystem       # Doesn't work
    #   - DesktopEnvironment
    #   - WindowManager         # Don't need it
    #   - Resolution
    #   - Backlight             # Don't need it
    #   - Packages              # Doesn't work
    #   - LocalIP
    #   - Terminal
    #   - Shell
    #   - Uptime
    #   - Processor
    #   - ProcessorLoad
    #   - Memory
    #   - Battery               # Doesn't work
    #   - GPU                   # Doesn't exist
    #   - DiskSpace             # Doesn't exist

    show = [
      "Host",
      "Machine",
      "Kernel",
      "Distribution",
      "DesktopEnvironment",
      "LocalIP",
      "Terminal",
      "Packages",              # Doesn't work
      "Shell",
      "Uptime",
      "Processor",
      "Resolution",
      "ProcessorLoad",
      "Memory",
    ]
  '';

  xdg.configFile."macchina/themes/srk_nixos.toml".text = ''
    spacing         = 1
    padding         = 0
    hide_ascii      = false
    prefer_small_ascii = false
    separator       = "  "
    key_color       = "Cyan"
    separator_color = "Magenta"
    
    [palette]
    type = "Dark"
    visible = true
    glyph = "    "
    
    [bar]
    glyph           = ""
    symbol_open     = '['
    symbol_close    = ']'
    hide_delimiters = true
    visible         = true
    
    [box]
    title           = "⏽󰇘󰇘󰇘󰇘󰇘󰇘󰇘⏽  System ⏽󰇘󰇘󰇘󰇘󰇘󰇘󰇘⏽  Info ⏽󰇘󰇘󰇘󰇘󰇘󰇘⏽"
    border          = "rounded"
    visible         = true
    
    [box.inner_margin]
    x               = 1
    y               = 1

    [custom_ascii]
    color = "Blue"
    path = "~/.config/macchina/nixos_ascii"
    
    [randomize]
    key_color       = false
    separator_color = false
    
    [keys]
    host            = " Host"
    kernel          = "󱙣 Kernel"
    battery         = " Battery"
    os              = " OS"
    de              = "󰇄 DE"
    wm              = " WM"
    distro          = "󰠪 Distro"
    terminal        = " Terminal"
    shell           = " Shell"
    packages        = "󰏗 Packages"
    uptime          = " Uptime"
    memory          = "󰍛 Memory"
    machine         = " Machine"
    local_ip        = "󰩠 Local IP"
    backlight       = "󰳲 Brightness"
    resolution      = "󰹑 Resolution"
    cpu_load        = " CPU Load"
    cpu             = " CPU"
    gpu             = "GPU"
    disk_space      = "󰋊 Disk Space"
  '';

  xdg.configFile."macchina/nixos_ascii".text = ''
          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖         
          ▜███▙       ▜███▙  ▟███▛         
           ▜███▙       ▜███▙▟███▛          
            ▜███▙       ▜██████▛           
     ▟█████████████████▙ ▜████▛     ▟▙     
    ▟███████████████████▙ ▜███▙    ▟██▙    
           ▄▄▄▄▖           ▜███▙  ▟███▛    
          ▟███▛             ▜██▛ ▟███▛     
         ▟███▛       S       ▜▛ ▟███▛      
▟███████████▛       SRK        ▟██████████▙
▜██████████▛         K        ▟███████████▛
      ▟███▛ ▟▙               ▟███▛         
     ▟███▛ ▟██▙             ▟███▛          
    ▟███▛  ▜███▙           ▝▀▀▀▀           
    ▜██▛    ▜███▙ ▜██████████████████▛     
     ▜▛     ▟████▙ ▜████████████████▛      
           ▟██████▙       ▜███▙            
          ▟███▛▜███▙       ▜███▙           
         ▟███▛  ▜███▙       ▜███▙          
         ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘          
  '';
}
