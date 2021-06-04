import http.server
import socketserver
import os
PORT = 8001

Handler = http.server.SimpleHTTPRequestHandler

#web_dir = os.path.join(os.path.dirname(__file__), 'web')
os.chdir("Z:\\MVNO")

with socketserver.TCPServer(("0.0.0.0", PORT), Handler) as httpd:
    print("serving at port", PORT)
    httpd.serve_forever()