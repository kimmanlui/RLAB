from pyftpdlib import servers
from pyftpdlib.handlers    import FTPHandler
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.servers     import FTPServer

authorizer = DummyAuthorizer()
authorizer.add_user("user", "12345", "D:\\SERVER_LOG\\ftp", perm="elradfmwMT")
authorizer.add_anonymous("D:\\SERVER_LOG\\ftp_anyone")

handler = FTPHandler
handler.authorizer = authorizer

print("<<<< linux example: ftp 10.89.34.95 8078 >>>>")
print("<<<< login: user  password: 12345        >>>>")
server = FTPServer(("0.0.0.0", 8078), handler)
server.serve_forever()
