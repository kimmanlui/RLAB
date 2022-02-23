#!pip install pyotp
import pyotp

from bs4 import BeautifulSoup
infile = open("/Users/admin/Documents/Dropbox/jupyter/prj/logininfo.xml","r")
contents = infile.read()
soup = BeautifulSoup(contents,"html5lib")

token  =soup.conf.token.get_text()
totp = pyotp.TOTP(token)
code=totp.now()
from time import gmtime, strftime
import pyperclip
pyperclip.copy(code)
print(strftime("%S", gmtime())+"   "+code)
import time
time.sleep(15)