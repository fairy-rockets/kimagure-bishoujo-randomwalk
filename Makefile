.PHONY: generate gif chrome build web batch

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

generate:
	mkdir -p img0000
	node main.js 0 10000 30

anime.0000.mp4:
	ffmpeg -y -r 120 -i img.0000/%07d.png -vf "tblend=average,framestep=2" -vcodec libx264 -pix_fmt yuv420p -b:v 20000k -profile:v high -preset veryslow -r 60 anime.0000.mp4

all.mp4: img.all
	ffmpeg -y -r 120 -i img.all/%07d.png -vf "tblend=average,framestep=2" -vcodec libx264 -pix_fmt yuv420p -b:v 12000k -profile:v high -preset placebo -tune grain -r 60 -threads 0 -pass 1 all.mp4
	ffmpeg -y -r 120 -i img.all/%07d.png -vf "tblend=average,framestep=2" -vcodec libx264 -pix_fmt yuv420p -b:v 12000k -profile:v high -preset placebo -tune grain -r 60 -threads 0 -pass 2  all.mp4

all-youtube.mp4: img.all
	ffmpeg -y -r 120 -i img.all/%07d.png -vf "tblend=average,framestep=2,scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2" -vcodec libx264 -pix_fmt yuv420p -b:v 40000k -profile:v high -preset placebo -tune grain -r 60 -threads 0 -pass 1 all-youtube.mp4
	ffmpeg -y -r 120 -i img.all/%07d.png -vf "tblend=average,framestep=2,scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2" -vcodec libx264 -pix_fmt yuv420p -b:v 40000k -profile:v high -preset placebo -tune grain -r 60 -threads 0 -pass 2  all-youtube.mp4

clean:
	rm -rf img.* anime.*.mp4

chrome:
	$(CHROME) --headless --disable-gpu --remote-debugging-port=10000 'http://localhost:8080'

build:
	npm run build

web:
	cd build; python3 -m http.server 8080

batch:
	nohup bash generate.sh 2>&1 > gen.log &
