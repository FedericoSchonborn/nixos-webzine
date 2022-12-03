let
  issue = {
    disabled = true; # set to false to publish
    number = "002";
    date = "2022-12-??";

    news = [
    ];

    # need some HTML to wrap the content
    tips = ''
    '';

    artwork = {
      caption = "";
      url = "static/artwork-001.png";
      author = "";
    };

    # { text = ""; url = ""; }
    links = [
        { text = "NixOS: On Raspberry Pi 3B"; url = "https://myme.no/posts/2022-12-01-nixos-on-raspberrypi.html"; }
    ];

    # { text = ""; url = ""; }
    events = [
      {
        date = "2023-02-04 to 2023-02-05";
        where = "Brussels, Europe";
        text = "FOSDEM 2023";
        url = "https://discourse.nixos.org/t/fosdem-2023-nix-and-nixos-devroom/23133";
      }
    ];

    # need some HTML to wrap the content
    editors = ''
    '';

    # list of people who contributed to the issue
    authors = [
      "Solène Rapenne"
    ];
  };
in
  issue
