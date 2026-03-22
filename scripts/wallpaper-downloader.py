import os
import requests
from urllib.parse import quote

# Configuration
REPO = "abenezerw/Green-Lush"
BRANCH = "main"
PATH_IN_REPO = "Configs/.config/hyde/themes/Green Lush/wallpapers"
FILES = [
    "云和山风景.PNG", "夜色归途.png", "山雨如晦.png", "幽谷秘境.png",
    "情色海湾.png", "日出.png", "森林中的书店.png", "灯火阑珊.png",
    "绿色房子.PNG", "绿色道路.PNG", "艳阳天.png", "轩榭晨光.png",
    "这是什么.PNG", "铁道天桥.png", "静夜幽.PNG", "静夜幽居.png"
]

os.makedirs("wallpapers", exist_ok=True)

for filename in FILES:
    encoded = quote(filename, safe='')
    url = f"https://raw.githubusercontent.com/{REPO}/{BRANCH}/{PATH_IN_REPO}/{encoded}"
    print(f"⬇️  {filename}")
    response = requests.get(url)
    if response.status_code == 200:
        with open(f"/home/fikri/Pictures/Wallpapers/{filename}", "wb") as f:
            f.write(response.content)
    else:
        print(f"❌ Failed: {filename}")
