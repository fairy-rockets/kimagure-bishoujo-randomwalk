.PHONY: generate gif chrome build http

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

generate:
	node main.js

gif:
	rm -f anime.gif
	convert -delay 2 -loop 0 img/*.png  anime.gif

clean-data:
	rm -f output.txt img/*.png anime.gif

chrome:
	$(CHROME) --headless --disable-gpu --remote-debugging-port=9222 'http://localhost:8080'

build:
	npm run build

http:
	cd build; python3 -m http.server 8080
