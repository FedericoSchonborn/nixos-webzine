{system ? builtins.currentSystem}: let
  pkgs = import <nixpkgs> {inherit system;};

  issues = [
    ./issues/001.nix
    ./issues/002.nix
  ];

  website = {
    url = "https://webzine.snowflake.ovh/";
    style = builtins.readFile ./style.html;
    header = ''
      <header>
        <h2 id="title"><a href="https://${website.url}"><span><img src="static/NixOS_logo.svg" alt="❄️">NixOS Webzine</span></a></h2>
        <p id="banner"><span aria-hidden="true">☕</span><em>Your tasty dose of NixOS news</em><span aria-hidden="true">☕</span></p>
      </header>
    '';
  };
in
  pkgs.stdenv.mkDerivation rec {
    name = "nixos-webzine";

    src = ./static;

    builder = pkgs.writeShellScript "builder.sh" (
      ''
        ${pkgs.busybox}/bin/mkdir -p $out/static
        ${pkgs.busybox}/bin/cp ${index_generator}/* $out/
        ${pkgs.busybox}/bin/cp -fr $src/* $out/static/
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
      pkgs.writeTextDir "issue-${issue.number}.html" ''
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
            ${website.header}
            <main>

          <!-- NEWS -->
          ${
          if (builtins.length issue.news) != 0
          then ''
            <article id="news">
            <div class="snowflakes" aria-hidden="true">❄ ❄ ❄</div>
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
            <div class="snowflakes" aria-hidden="true">❄ ❄ ❄</div>
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
            <div class="snowflakes" aria-hidden="true">❄ ❄ ❄</div>
            <h2>Going further</h2>
            <ul>
                ${pkgs.lib.concatStringsSep "\n" (builtins.map (item: ''
                <li>${item.text} [<a href="${item.url}" class="permalink">link</a>]</li>
              '')
              issue.links)}
            </ul>
            </article>
          ''
          else ""
        }

          <!-- ARTWORK-->
          ${
          if issue.artwork.url != ""
          then ''
            <article id="artwork">
            <div class="snowflakes" aria-hidden="true">❄ ❄ ❄</div>
            <h2>Artwork of the moment</h2>
            <figure>
                <a href="${issue.artwork.url}">
                <picture>
                    <img src="${issue.artwork.url}"
                     alt="${issue.artwork.caption}" />
                </picture>
                </a>
                <figcaption>${issue.artwork.caption} - by ${issue.artwork.author}</figcaption>
            </figure>
            </article>
          ''
          else ""
        }

          <!-- REDACTION -->
          ${
          if issue.editors != ""
          then ''
            <article id="editors">
            <div class="snowflakes" aria-hidden="true">❄ ❄ ❄</div>
            <h2>Notes from the editorial team</h2>
            ${issue.editors}
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

    index_generator = pkgs.writeTextDir "index.html" ''
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
            <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
            <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
            <link rel="alternate" type="application/rss+xml" href="https://${website.url}/atom.xml">
            <meta property="og:title" content="NixOS webzine" />
            <meta property="og:description" content="Webzine created by volunteers who are passionate about the NixOS project development." />
            <meta property="og:url" content="https://${website.url}/index.html" />
            <meta property="og:image" content="https://${website.url}/images/logo.png" />
            <meta property="og:type" content="website" />
            <meta property="og:locale" content="en_EN" />
            <title>NixOS webzine index</title>
            ${website.style}
          </head>

          <body>

            ${website.header}
           
            <main>
              <article id="issues">
                <h2>Issues published</h2>
                <ul>
                    ${pkgs.lib.concatStringsSep "\n" (builtins.map (element: let
                      issue = import element;
                    in ''
                    <li>${issue.date} - Issue ${issue.number}  <a class="permalink" href="issue-${issue.number}.html">English</a></li>
                    '') (pkgs.lib.lists.reverseList issues))}
                </ul>
              </article>

              <article id="infos">
                <h2>Infos</h2>
                <div>
                  <p>This webzine is done by volunteers who are passionate about the NixOS project development.</p>
                  <p>Our goal is to allow people to stay informed about NixOS in a cool, fun and instructive way, like reading a regularly issued magazine of one's favorite hobby.</p>
                </div>
              </article>

              <article id="community">
                <h2>Community</h2>
                <p>Looking to get in touch with NixOS users? Here are a few ways to join them.</p>
                <ul>
                  <li><a class="permalink" href="atom.xml">Webzine feed</a></li>
                  <li><a class="permalink" href="https://discourse.nixos.org">Official discourse forum</a></li>
                  <li>Reddit: <a class="permalink" href="https://www.reddit.com/r/nixos/">Subreddit /r/nixos/</a></li>
                  <li>Matrix: channel <em>#community:nixos.org</em></li>
                  <li>Mastodon: Search for tag #NixOS</li>
                  <li>Twitter: <a class="permalink" href="https://twitter.com/hashtag/nixos">#nixos</a></li>
                </ul>
              </article>

              <article id="contribute">
                <h2>How to contribute</h2>
                <p>If you want to contribute to the Webzine, from a simple contribution suggesting a link or a news to a large or regular contribution, we do all the work publicly with Git.
                  <a class="permalink" href="https://tildegit.org/solene/nixos-webzine/">Link to the Git repository.</a>
                </p>
              </article>
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
      '';
  }
