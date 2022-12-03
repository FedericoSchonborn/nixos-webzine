let
  issue = {
    number = "001";
    date = "2022-12-03";

    news = [
      ''NixOS 22.11 has been released 🥳 <a href="https://nixos.org/blog/announcements.html#nixos-22.11" class="permalink">Announcement</a>''
      ''This webzine is alive! A cozy place to read about NixOS news in a funny format.''
      ''The community reached the top 10 of the most active GitHub project! <a href="https://discourse.nixos.org/t/another-moment-of-awesome-nixpkgs-top-10/23150" class="permalink">source</a>''
      ''The community is now collaborating directly with GitHub to improve the contributors experience <a href="https://discourse.nixos.org/t/nixos-github-collaboration/23432" class="permalink">source</a>''
    ];

    tips = ''
      <p>Did you know you can let Nix daemon handle garbage collection automatically? This can be done by setting the variable <code>min-free</code> to trigger a garbage collection if the remaining disk is less than its value in bytes each time Nix is manipulating the store.
      However, you may also want to set <code>max-free</code> in order to prevent the garbage collector to removing too much content from the store, this value tells Nix to stop the garbage collector once a certain amount of space is available.</p>
      <p>Using the following code, you can tell Nix to automatically handle the free space when you have less than 1 GB until you have 3 GB available.
      <pre>nix.extraOptions = '''
        min-free = 1073741824
        max-free = 3221225472
      ''';</pre></p>
    '';

    artwork = {
      caption = "a snowflake in a neon style";
      url = "static/artwork-001.png";
      author = "stable-diffusion";
    };

    links = [
      {
        url = "https://aldoborrero.com/posts/how-to-setup-a-nix-binary-cache-with-terraform-in-digitalocean-and-cloudflare/";
        text = "How to set up a Nix Binary cache with Terraform in DigitalOcean + Cloudflare";
      }
      {
        text = "From Ubuntu to NixOS the story of a mastodon migration";
        url = "https://gianarb.it/blog/from-ubuntu-to-nixos-history-of-a-mastodon-migration";
      }
      {
        text = "Resurrecting My Old Website With Ancient NixOS Packages";
        url = "https://jeezy.substack.com/p/resurrecting-my-old-website-with";
      }
      {
        text = "Using NixOS in a SystemD container";
        url = "https://gist.github.com/ivan-tkatchev/e29cbcf042f04ea263f44d4604186f22";
      }
      {
        text = "Simple NixOS mailserver updated for 22.11";
        url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/merge_requests/283";
      }
      {
        text = "Announcing Silicon Valley Nix / NixOS User Group";
        url = "https://notes.softinio.com/p/announcing-silicon-valley-nix-nixos";
      }
      {
        text = "Hard user separation with two NixOS as one";
        url = "https://dataswamp.org/~solene/2022-11-17-two-nixos-as-one.html";
      }
    ];

    events = [
      {
        text = "FOSDEM 2023";
        url = "https://discourse.nixos.org/t/fosdem-2023-nix-and-nixos-devroom/23133";
      }
    ];

    editors = ''
      <p>I'm pleased to announce the release of the first issue of this Webzine. I made a similar experiment with the OpenBSD webzine and it turned out it worked well, so why not do it for NixOS?</p>
      <p>The website is made of static HTML files generated entirely from a nix expression, it's super fun to add entries in it, and only have a few dependencies, feel free to contribute 🤘</p>
    '';

    authors = [
      "Solène Rapenne"
    ];
  };
in
  issue
