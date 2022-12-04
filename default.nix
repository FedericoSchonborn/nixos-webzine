{system ? builtins.currentSystem}: let
  pkgs = import <nixpkgs> {inherit system;};

  issues = [
    ./issues/001.nix
  ];

  website = {
    url = "https://webzine.nixos.cafe";
    domain = "webzine.nixos.cafe";
    style = builtins.readFile ./style.html;
    header = ''
      <header>
        <h2 id="title"><a href="${website.url}"><span><img src="static/NixOS_logo.svg" alt="❄️">NixOS Webzine</span></a></h2>
        <p id="banner"><span aria-hidden="true">☕</span><em>Your tasty dose of reproducible NixOS news</em><span aria-hidden="true">☕</span></p>
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
        ${pkgs.busybox}/bin/cp ${atom}/* $out/
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
            <link rel="icon" type="image/png" sizes="32x32" href="/static/NixOS_logo.svg">
            <link rel="icon" type="image/png" sizes="16x16" href="/static/NixOS_logo.svg">
            <meta property="og:description" content="Webzine created by volunteers who are passionate about the NixOS project development." />
            <link rel="alternate" type="application/rss+xml" href="${website.url}/atom.xml">
            <meta property="og:title" content="NixOS webzine issue #${issue.number}" />
            <meta property="og:url" content="${website.url}/issue-${issue.number}.html" />
            <meta property="og:image" content="${website.url}/static/NixOS_logo.svg" />
            <meta property="og:type" content="website" />
            <meta property="og:description" content="Your tasty dose ☕ of reproducible NixOS news ❄️" />
            <meta property="og:locale" content="en_EN" />
            <title>NixOS webzine issue #${issue.number}</title>
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
            <h2>Nix Tips</h2>
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

          <!-- EVENTS -->
          ${
          if (builtins.length issue.events) != 0
          then ''
            <article id="events">
            <div class="snowflakes" aria-hidden="true">❄ ❄ ❄</div>
            <h2>Events</h2>
            <ul>
                ${pkgs.lib.concatStringsSep "\n" (builtins.map (item: ''
                <li><strong>${item.text}</strong>, ${item.date} in ${item.where} [<a href="${item.url}" class="permalink">link</a>]</li>
              '')
              issue.events)}
            </ul>
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

          <!-- AUTHORS -->
          ${
          if (builtins.length issue.authors) != 0
          then ''
            <article id="authors">
            <div class="snowflakes" aria-hidden="true">❄ ❄ ❄</div>
            <h2>Authors</h2>
            ${pkgs.lib.concatStringsSep ", " issue.authors}
            </article>
          ''
          else ""
        }
            </main>
            <footer>
              <hr />
              <p id="license">Content under <a class="permalink" href="https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode">CC-BY-NC-SA-4.0</a>.
                Artworks are under their own licenses. <a class="permalink" href="atom.xml">Feed ATOM</a>
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
            <link rel="icon" type="image/png" sizes="32x32" href="/static/NixOS_logo.svg">
            <link rel="icon" type="image/png" sizes="16x16" href="/static/NixOS_logo.svg">
            <link rel="alternate" type="application/rss+xml" href="${website.url}/atom.xml">
            <meta property="og:title" content="NixOS webzine" />
            <meta property="og:description" content="Webzine created by volunteers who are passionate about the NixOS project development. Your tasty dose ☕ of reproducible NixOS news ❄️" />
            <meta property="og:url" content="${website.url}/index.html" />
            <meta property="og:image" content="${website.url}/static/NixOS_logo.svg" />
            <meta property="og:type" content="website" />
            <meta property="og:locale" content="en_EN" />
            <title>NixOS webzine homepage</title>
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
                  <li><a class="permalink" href="https://discourse.nixos.org">Official discourse forum</a></li>
                  <li>Matrix: official communication channel <a class="permalink" href="https://matrix.to/#/#community:nixos.org">#community:nixos.org</a></li>
                  <li>Reddit: <a class="permalink" href="https://www.reddit.com/r/nixos/">Subreddit /r/nixos/</a></li>
                  <li>Mastodon: Search for tag <em>#NixOS</em></li>
                  <li>Discord: <a class="permalink" href="https://discord.gg/RbvHtGa">user group</a></li>
                  <li>Telegram: <a class="permalink" href="https://t.me/nixos_en">English NixOS user group</a>, <a class="permalink" href="https://t.me/nix_org">English Nix user group</a>, <a class="permalink" href="https://t.me/nixos_webzine">Webzine channel</a></li>
                  <li>Twitter: <a class="permalink" href="https://twitter.com/hashtag/nixos">#nixos</a></li>
                  <li><a class="permalink" href="atom.xml">Webzine feed</a></li>
                </ul>
              </article>

              <article id="learn">
                <h2>Learn NixOS</h2>
                <p>New to NixOS? Want to learn more about it?</p>
                <ul>
                  <li><a class="permalink" href="https://nixos.org">NixOS official website</a></li>
                  <li><a class="permalink" href="https://search.nixos.org/packages">Package search engine</a></li>
                  <li><a class="permalink" href="https://nixos.org/manual/nixos/stable/">The NixOS manual</a></li>
                  <li><a class="permalink" href="https://nixos.org/manual/nixpkgs/stable/">nixpkgs manual</a></li>
                  <li><a class="permalink" href="https://nixos.org/manual/nix/stable/">nix package manager manual</a></li>
                  <li><a class="permalink" href="https://nix.dev/">Learn the nix language on nix.dev</a></li>
                  <li><a class="permalink" href="https://nixos.org/guides/nix-pills/">Learn how nix works on nix-pills</a></li>
                </ul>
              </article>

              <article id="contribute">
                <h2>How to contribute</h2>
                <p>If you want to contribute to the Webzine, from a simple to a regular contribution, we do all the work publicly with Git.
                  <a class="permalink" href="https://tildegit.org/solene/nixos-webzine/">Link to the Git repository.</a>
                </p>
              </article>
            </main>
            <footer>
              <hr />
              <p id="license">Content under <a class="permalink" href="https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode">CC-BY-NC-SA-4.0</a>.
                Artworks are under their own licenses. <a class="permalink" href="atom.xml">Feed ATOM</a>
              </p>
            </footer>
          </body>
        </html>
      '';


   atom = pkgs.writeTextDir "atom.xml" ''
     <?xml version="1.0" encoding="utf-8"?>
       <feed xmlns="http://www.w3.org/2005/Atom">
       <id>${website.url}/</id>
       <title>NixOS Webzine</title>
       <icon>${website.url}/static/NixOS_logo.svg</icon>
       <link rel="alternate" type="text/html" href="${website.url}/" />
       <link rel="self" type="application/atom+xml" href="${website.url}/atom.xml" />
       <author>
         <name>NixOS Webzine contributors</name>
       </author>
       <updated>${let last_issue = import (builtins.head (pkgs.lib.lists.reverseList issues)); in last_issue.date}T00:00:00Z</updated>

       ${pkgs.lib.concatStringsSep "\n" (builtins.map (element: let
         issue = import element;
       in ''
         <entry>
           <title type="text">Issue #${issue.number}</title>
           <id>tag:${website.domain},2022:/issue-${issue.number}.html</id>
           <updated>${issue.date}T00:00:00Z</updated>
           <link rel="alternate" type="text/html" href="${website.url}/issue-${issue.number}.html" />
           <summary type="html">
           <![CDATA[
              ${
              if (builtins.length issue.news) != 0
              then ''
                <ul>
                    ${pkgs.lib.concatStringsSep "\n" (builtins.map (item: ''
                    <li>${item}</li>
                  '')
                  issue.news)}
                </ul>
              ''
              else ""
            }
           ]]>
           </summary>
         </entry>
       '') (pkgs.lib.lists.reverseList issues))}
       </feed>'';
  }
