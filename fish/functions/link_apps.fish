function link_apps
  set -l NIX_PROFILE $HOME/.nix-profile
  set -l APP_DIR $HOME/Applications
  # Remove broken links
  for i in $APP_DIR/*;
    if [ -L "$f" ] && [ ! -e "$f" ];
        rm $f
    end
  end

  # Link new ones
  for f in $NIX_PROFILE/Applications/*;
   set -l app_name (basename $f)
   if [ ! -e $APP_DIR/$app_name ];
       ln -s "$f" $APP_DIR/
   end
  end
end
