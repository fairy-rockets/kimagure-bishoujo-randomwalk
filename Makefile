.PHONY: generate gif chrome build web

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

generate:
	node main.js

gif:
	rm -f anime.gif anime.mp4
	@# convert -delay 2 -loop 0 img/*.png  anime.gif
	#@ffmpeg -r 120 -i img/%07d.png -vcodec libx264 -pix_fmt yuv420p -b:v 20000k -profile:v high -preset veryslow -r 60 anime.mp4 2> /dev/null
	ffmpeg -r 120 -i img/%07d.png -vf "tblend=average,framestep=2" -vcodec libx264 -pix_fmt yuv420p -b:v 20000k -profile:v high -preset veryslow -r 60 anime.mp4


clean-data:
	rm -f output.txt img/*.png anime.gif

chrome:
	$(CHROME) --headless --disable-gpu --remote-debugging-port=9222 'http://localhost:8080'

build:
	npm run build

web:
	cd build; python3 -m http.server 8080
