curl -s "https://api.github.com/repos/abenezerw/Green-Lush/contents/Configs/.config/hyde/themes/Green%20Lush/wallpapers" | \
  jq -r '.[] | select(.name | endswith(".png") or endswith(".PNG")) | .download_url' | \
  xargs -n1 curl -O -J -L
