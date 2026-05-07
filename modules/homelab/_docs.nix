{ self, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      iconSize = "32";
      mkRow =
        name: svc:
        let
          nameCell = if svc.path != "" then "[`${name}`](${svc.path})" else "`${name}`";
          icon =
            if svc.iconUrl != "" then
              ''<img src="${svc.iconUrl}" width="${iconSize}" alt="${name} icon">''
            else
              "-";
          desc = if svc.description != "" then svc.description else "-";
        in
        "| ${nameCell} | ${desc} | ${icon} |";

      table = pkgs.writeTextFile {
        name = "homelab-services-table";
        text = ''
          | service | description | icon |
          | --- | --- | --- |
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList mkRow self.homelabServices)}
        '';
      };

      mkApp =
        {
          name,
          table,
          startMarker,
          endMarker,
        }:
        {
          type = "app";
          program = toString (
            pkgs.writeShellScript name ''
              dest=''${1:-./README.md}
              if [ ! -f "$dest" ]; then
                echo "$dest does not exist"
                exit 1
              fi
              if grep -q '${startMarker}' "$dest" && grep -q '${endMarker}' "$dest"; then
                awk -v docs=${table} '
                  /${startMarker}/ { print; while ((getline line < docs) > 0) print line; skip=1; next }
                  /${endMarker}/ { skip=0 }
                  !skip { print }
                ' "$dest" > "$dest.tmp" && mv "$dest.tmp" "$dest"
              elif ! grep -q '${startMarker}' "$dest" && ! grep -q '${endMarker}' "$dest"; then
                printf '${startMarker}\n' >> "$dest"
                cat ${table} >> "$dest"
                printf '${endMarker}\n' >> "$dest"
              fi
            ''
          );
        };

    in
    {
      apps = lib.optionalAttrs (self.homelabServices != { }) {
        homelab-service-table = mkApp {
          name = "homelab-service-table";
          inherit table;
          startMarker = "<!-- homelab-services:start -->";
          endMarker = "<!-- homelab-services:end -->";
        };
      };
    };
}
