{system ? builtins.currentSystem}: let
  pkgs = import <nixpkgs> {inherit system;};

  issues = [
    ./issues/001.nix
    ./issues/002.nix
  ];

  website = {
    url = "https://localhost/";
    style = builtins.readFile ./style.html;
  };
in
  pkgs.stdenv.mkDerivation rec {
    name = "nixos-webzine";

    builder = pkgs.writeShellScript "builder.sh" (
      ''
        ${pkgs.busybox}/bin/mkdir -p $out
      ''
      + (
        pkgs.lib.concatStringsSep "\n"
        (builtins.map (file: ''
            ${pkgs.busybox}/bin/cp ${file}/* $out/
          '')
          pages_generator)
      )
    );

    pages_generator = (builtins.map (element: let
      issue = import element;
    in
      pkgs.writeTextDir "${issue.number}.html" ''
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
            <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
            <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
            <link rel="alternate" type="application/rss+xml" href="https://${website.url}/atom.xml">
            <meta property="og:title" content="NixOS webzine ${issue.number}" />
            <meta property="og:description" content="Webzine created by volunteers who are passionate about the NixOS project development." />
            <meta property="og:url" content="https://${website.url}/issue-${issue.number}.html" />
            <meta property="og:image" content="https://${website.url}/images/logo.png" />
            <meta property="og:type" content="website" />
            <meta property="og:locale" content="en_EN" />
            <title>NixOS webzine ${issue.number}</title>
            ${website.style}
          </head>
          <body>
            <main>
              <!-- NEWS -->
              ${
          if (builtins.length issue.news) != 0
          then ''
            <article id="news">
            <div class="puffies" aria-hidden="true">❄ ❄ ❄</div>
            <h2>News</h2>
            <ul>
                ${pkgs.lib.concatStringsSep "\n" (builtins.map (item: ''
                <li>${item}</li>
              '')
              issue.news)}
            </ul>
            </article>
          ''
          else ""
        }

              <!-- TIPS -->
              ${
          if issue.tips != ""
          then ''
            <article id="tips">
            <div class="puffies" aria-hidden="true">❄ ❄ ❄</div>
            <h2>Tips</h2>
            ${issue.tips}
            </article>
          ''
          else ""
        }

              <!-- LINKS -->
              ${
          if (builtins.length issue.links) != 0
          then ''
            <article id="links">
            <div class="puffies" aria-hidden="true">❄ ❄ ❄</div>
            <h2>Going further</h2>
            <ul>
                ${pkgs.lib.concatStringsSep "\n" (builtins.map (item: ''
                <li>${item}</li>
              '')
              issue.links)}
            </ul>
            </article>
          ''
          else ""
        }
            </main>
            <footer>
              <hr />
              <p id="license">Content under <a class="permalink" href="https://creativecommons.org/licenses/by/3.0/legalcode">CC-BY-NC-3.0</a>.
                Artworks are under their own licenses.
                <br /><a class="permalink" href="atom.xml">Feed ATOM</a>
              </p>
            </footer>
          </body>
        </html>
      ''))
    issues;
  }
