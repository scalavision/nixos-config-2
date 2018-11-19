{ mutate, sakura, xorg, i3status, dropbox, dmenu, pulseaudioFull,
  volume, backlight, dunst, dunst_config, lib, screenshot }:
mutate ./config {
  inherit sakura i3status dropbox dmenu pulseaudioFull volume
  backlight dunst dunst_config screenshot;
  i3status_conf = let
      location = (import /etc/nixos/secrets.nix).location;
    in mutate ./i3status {
      remote_tzs = lib.lists.imap0 (i: tz: ''
        tztime remote${toString i} {
          format = "-%d %H:%M:%S %Z"
          timezone = "${tz}"
        }
        order += "tztime remote${toString i}"

      '') location.remote_timezones;
    };
}
