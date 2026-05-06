{
  flake.modules.homeManager.librewolf = {
    programs.librewolf.enable = true;
  };

  flake.modules.nixos.librewolf =
    let
      mkInstallUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
    in
    {
      imports = [ ./_module.nix ];

      programs.librewolf = {
        enable = true;

        policies = {
          DisableAppUpdate = true;
          SearchSuggestEnabled = true;
          DisableSetDesktopBackground = true;
          OfferToSaveLogins = false;
          TranslateEnabled = false;
          DisableTelemetry = true;
          VisualSearchEnabled = false;
          NoDefaultBookmarks = true;

          PictureInPicture.Enabled = false;

          FirefoxSuggest = {
            WebSuggestions = false;
            SponsoredSuggestions = false;
            ImproveSuggest = false;
            Locked = true;
          };

          GenerativeAI = {
            Enabled = false;
            Locked = true;
          };

          SanitizeOnShutdown = {
            Cache = true;
            Cookies = true;
            Downloads = true;
            FormData = true;
            History = true;
            Sessions = true;
          };

          DNSOverHTTPS = {
            Enabled = true;
            ProviderURL = "https://cloudflare-dns.com/dns-query";
            Fallback = true;
          };

          UserMessaging = {
            ExtensionRecommendations = false;
            FeatureRecommendations = false;
            UrlbarInterventions = false;
            SkipOnboarding = true;
            MoreFromMozilla = false;
            FirefoxLabs = false;
          };

          Preferences = {
            "browser.search.suggest.enabled.private" = true;
            "browser.search.suggest.enabledOverride" = true;
            "browser.urlbar.suggest.addons" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.importantDates" = false;
            "browser.urlbar.suggest.mdn" = false;
            "browser.urlbar.suggest.sports" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.suggest.trending" = false;
            "browser.urlbar.suggest.wikipedia" = false;
            "browser.urlbar.suggest.yelp" = false;
            "browser.urlbar.suggest.yelpRealtime" = false;
            "browser.urlbar.trimURLs" = false;
            "browser.search.separatePrivateDefault" = false;
            "browser.toolbars.bookmarks.visibility" = "newtab";
            "network.cookie.cookieBehavior" = 1;
            "browser.sessionstore.resume_from_crash" = false;
            "network.lna.blocking" = true;
            "network.lna.block_trackers" = true;
            "browser.warnOnQuitShortcut" = false;
            "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
            "browser.newtabpage.activity-stream.showSearch" = false;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "general.smoothScroll.msdPhysics.enabled" = true;
            "geo.enabled" = false;
          };

          ExtensionSettings =
            let
              defaults = {
                installation_mode = "force_installed";
                default_area = "addon-bar";
              };
            in
            {
              "uBlock0@raymondhill.net" = defaults // {
                install_url = mkInstallUrl "ublock-origin";
              };
            };

          SearchEngines = {
            Remove = [
              "Google"
              "Bing"
              "Perplexity"
              "Wikipedia (en)"
            ];
            Add = [
              {
                Name = "DuckDuckGo-Dark";
                URLTemplate = "https://duckduckgo.com/?kae=d&q={searchTerms}";
                Method = "GET";
                IconURL = "https://duckduckgo.com/favicon.ico";
                SuggestURLTemplate = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
              }
              {
                Name = "NixOS Options";
                URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
                Method = "GET";
                IconURL = "https://nixos.org/favicon.ico";
                Alias = "@no";
              }
              {
                Name = "NixOS Packages";
                URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
                Method = "GET";
                IconURL = "https://nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "MyNixOS";
                URLTemplate = "https://mynixos.com/search?q={searchTerms}";
                Method = "GET";
                IconURL = "https://mynixos.com/favicon.ico";
                Alias = "@mn";
              }
              {
                Name = "Noogle";
                URLTemplate = "https://noogle.dev/q/?term={searchTerms}";
                Method = "GET";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = "@ng";
              }
            ];
            Default = "DuckDuckGo-Dark";
          };
        };
      };
    };
}
