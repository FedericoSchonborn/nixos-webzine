let
  issue = {
    disabled = true; # set to false to publish
    number = "002";
    date = "2023-01-03";

    news = [
        "22.05 is end-of-life, it won't receive updates anymore"
        "Nix 2.12.0!"
    ];

    # need some HTML to wrap the content
    tips = ''
      <p>When looking for NixOS modules options, if they exist or how to use them, you always have these information at hand in a manual page named <code>configuration.nix</code>.</p>
      <p>If you are not familiar with manual pages (often referred to as "man pages"), just type <code>man configuration.nix</code> in a terminal, and scroll around. By default, the program <code>less</code> is used to display the manual page content, it's call a pager.
      For searching, use <code>/some_pattern</code>, you can repeat a search with <code>n</code> (Vi users should feel at home)</p>
    '';

    artwork = {
      caption = "You'll never build alone - Liverpool Nix User Group";
      url = "static/artwork-002.png";
      author = "Matthew Croughan";
    };

    # { text = ""; url = ""; }
    links = [
        {
            text = "NixOS: On Raspberry Pi 3B";
            url = "https://myme.no/posts/2022-12-01-nixos-on-raspberrypi.html";
        }
        {
            text = "Configure packages like NixOS sytems";
            url = "https://github.com/DavHau/drv-parts";
        }

        {
            text = "Nix reasonable defaults";
            url = "https://jackson.dev/post/nix-reasonable-defaults/";
        }

        {
            text = "Nix 2.12.0 released";
            url = "https://discourse.nixos.org/t/nix-2-12-0-released/23780";
        }

        {
            text = "What's new in Nix? (Video, YouTube)";
            url = "https://www.youtube.com/watch?v=ypFLcMCSzNA";
        }

        {
            text = "Another NixOS Deployment Tool - Nixinate your systems";
            url = "https://github.com/MatthewCroughan/nixinate";
        }

        {
            text = "Automagically assimilating NixOS machines into your Tailnet with Terraform";
            url = "https://xeiaso.net/blog/nix-flakes-terraform";
        }

        {
            text = "Nix from First Principles: Flake Edition";
            url = "https://tonyfinn.com/blog/nix-from-first-principles-flake-edition/";
        }

        {
            text = "2022 November Sprint Report";
            url = "https://oceansprint.org/blog/2022/12/07/2022-november-sprint-report/";
        }

        {
            text = "Instant, easy, and predictable development environments";
            url = "https://github.com/jetpack-io/devbox/tree/0.1.2";
        }

        {
            text = "Building Go programs with Nix Flakes";
            url = "https://xeiaso.net/blog/nix-flakes-go-programs";
        }

        {
            text = "My impressions of nixOS";
            url = "https://www.yusuf.fyi/posts/nixos-impressions";
        }

        {
            text = "Setting up my new laptop: nix style";
            url = "https://bmcgee.ie/posts/2022/12/setting-up-my-new-laptop-nix-style/";
        }

        {
            text = "Devenv: Compose a Developer Environment easily for PHP with Nix";
            url = "https://shyim.me/blog/devenv-compose-developer-environment-for-php-with-nix/";
        }

        {
            text = "Nix and NixOS, my pain points";
            url = "https://remy.grunblatt.org/nix-and-nixos-my-pain-points.html";
        }

        {
            text = "Nix-ld: A clean solution for issues with pre-compiled executables on NixOS";
            url = "https://blog.thalheim.io/2022/12/31/nix-ld-a-clean-solution-for-issues-with-pre-compiled-executables-on-nixos/";
        }
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
      <p>Second issue of the NixOS webzine, I'd like to thank all the readers who gave me a very positive feedback, making me motivated to continue it.</p>
      <p>If you want to contribute, or make artworks, please contact me, this could be turned into a fun team project</p>
    '';

    # list of people who contributed to the issue
    authors = [
      "Solène Rapenne"
    ];
  };
in
  issue
