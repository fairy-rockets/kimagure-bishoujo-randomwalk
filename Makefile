.PHONY: generate gif chrome build web

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

generate:
	mkdir -p img0000
	node main.js 0 10000 30

anime.0000.mp4:
	ffmpeg -y -r 120 -i img.0000/%07d.png -vf "tblend=average,framestep=2" -vcodec libx264 -pix_fmt yuv420p -b:v 20000k -profile:v high -preset veryslow -r 60 anime.0000.mp4

clean:
	rm -rf img.* anime.*.mp4

chrome:
	$(CHROME) --headless --disable-gpu --remote-debugging-port=10000 'http://localhost:8080'

build:
	npm run build

web:
	cd build; python3 -m http.server 8080
