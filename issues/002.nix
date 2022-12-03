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
