.PHONY: serve build check

serve:
	python3 -m http.server 8080

build: index.html

check:
	python3 -m http.server 8080 & \
	  SERVER_PID=$$!; \
	  sleep 1; \
	  curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8080/; \
	  kill $$SERVER_PID
