from pyftpdlib import servers
from pyftpdlib.handlers    import FTPHandler
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.servers     import FTPServer

authorizer = DummyAuthorizer()
authorizer.add_user("user", "12345", "D:\\SERVER_LOG\\ftp", perm="elradfmwMT")
authorizer.add_anonymous("D:\\SERVER_LOG\\ftp_anyone")

handler = FTPHandler
handler.authorizer = authorizer

server = FTPServer(("0.0.0.0", 8079), handler)
server.serve_forever()
