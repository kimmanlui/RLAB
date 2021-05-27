#!/usr/bin/env python
# coding: utf-8

# In[1]:


from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import ThreadedFTPServer

from pyftpdlib import servers
from pyftpdlib.handlers    import FTPHandler
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.servers     import FTPServer

import threading


# In[2]:






class FtpThread(threading.Thread):
  def __init__(self, user_list):
    self.user_list = user_list
    self.killswitch = 0
    threading.Thread.__init__(self)
  def run(self,*args,**kwargs):    
    authorizer = DummyAuthorizer()
    authorizer.add_user("user", "12345", "D:\\SERVER_LOG\\ftp", perm="elradfmwMT")
    authorizer.add_anonymous("D:\\SERVER_LOG\\ftp_anyone")

    handler = FTPHandler
    handler.authorizer = authorizer

    handler.banner = "pyftpdlib based ftpd ready."
    address = ("0.0.0.0", 8079)
    self.server = FTPServer(address, handler)
    self.server.max_cons = 256
    self.server.max_cons_per_ip = 5
    self.server.serve_forever()

  def stop(self):
    self.server.close_all()


# In[3]:



ftp_server = FtpThread("")
ftp_server.start()
import time

from datetime import datetime
now = datetime.now()
current_time = now.strftime("%M")

while int(current_time)<58:
   time.sleep(25)
   now = datetime.now()
   current_time = now.strftime("%M")
   print("current min: "+current_time)

ftp_server.stop()




# In[4]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




