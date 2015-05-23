#!/usr/bin/python3
import sys
import signal
import http.server

# handle a PID 1 issued exit for container
def signal_handler(signal, frame):
    print("Stopping webserver...")
    sys.exit(0)

signal.signal(signal.SIGTERM, signal_handler)

# start the webserver
print("Starting webserver...")
http.server.test(
	HandlerClass=http.server.SimpleHTTPRequestHandler,
	port=8000,
	bind="0.0.0.0"
)
