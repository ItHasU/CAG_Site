import http.server
import socketserver
import os

PORT = 8000
DIRECTORY = "www"

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

print(f"Démarrage du serveur HTTP sur http://127.0.0.1:{PORT}")
print(f"Le dossier '{DIRECTORY}/' sera servi.")

try:
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        httpd.serve_forever()
except KeyboardInterrupt:
    print("\nServeur arrêté par l'utilisateur.")