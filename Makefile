welcome:
	cat Makefile
run: 
	deployctl run --libs=ns,fetchevent --watch website.ts
static:
	deno run --quiet --allow-read --allow-net https://deno.land/std/http/file_server.ts . --cors --port 8081 --no-dotfiles
develop:
	make static &
	make run
sync:
	rsync --recursive --compress --stats public gl:/var/www/static.gaslight.dev
	rsync --recursive --compress --stats elements gl:/var/www/static.gaslight.dev
	rsync --recursive --compress --stats gaslight.js gl:/var/www/static.gaslight.dev/gaslight.js	
deploy:
	make sync; git push
