from pyftpdlib import servers
from pyftpdlib.handlers    import FTPHandler
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.servers     import FTPServer

authorizer = DummyAuthorizer()
authorizer.add_user("user", "12345", "/Users/admin", perm="elradfmwMT")
authorizer.add_anonymous("/Users/admin/Downloads")

handler = FTPHandler
handler.authorizer = authorizer

server = FTPServer(("0.0.0.0", 8079), handler)
server.serve_forever()
