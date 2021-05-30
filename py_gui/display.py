import tkinter as tk
from ctypes import windll
import threading
import time


GWL_EXSTYLE=-20
WS_EX_APPWINDOW=0x00040000
WS_EX_TOOLWINDOW=0x00000080

class Display(threading.Thread):

    def __init__(self):
        threading.Thread.__init__(self)
        self.start()

    def set_appwindow(self, root):
        hwnd = windll.user32.GetParent(root.winfo_id())
        style = windll.user32.GetWindowLongPtrW(hwnd, GWL_EXSTYLE)
        style = style & ~WS_EX_TOOLWINDOW
        style = style | WS_EX_APPWINDOW
        res = windll.user32.SetWindowLongPtrW(hwnd, GWL_EXSTYLE, style)
        # re-assert the new window style
        root.wm_withdraw()
        root.after(10, lambda: root.wm_deiconify())

    def callback(self):
        self.root.quit()

    def run(self):
        self.root = tk.Tk()
        self.root.wm_title("AppWindow Test")
        self.root.protocol("WM_DELETE_WINDOW", self.callback)

        self.root.geometry("150x30+-150+975") 
        #self.root.attributes('-alpha', 0.3)
        self.root.wm_attributes("-topmost", 1)
        self.root.overrideredirect(True)
        self.root.after(10, lambda: self.set_appwindow(self.root))

        self.text = tk.StringVar()
        print(self.text)
        self.text.set("---")
        
        label = tk.Label(self.root, textvariable=self.text, bg='grey' , height=30, width=150, anchor="e")
        label.pack()
        self.root.attributes('-transparentcolor', 'grey')
        self.root.mainloop()

    def changeText(self,text):
        self.text.set(text)  

app = Display()
print('Now we can continue running code while mainloop runs!')
time.sleep(10)
lines=""
workAtSec=45 #workAtSec should be between 1 and 59
while 1==1:
    try:
       f = open('../../content.txt','r')
       lines = f.readlines()
       f.close()
       shownText=lines[0]
       print(shownText)
    except:
       print("there is an error") 

    app.changeText(shownText)
    
    currSec=time.localtime().tm_sec
    if currSec>=workAtSec:
        time.sleep(60-currSec+1)
    while currSec<workAtSec:
        time.sleep(1)
        currSec=time.localtime().tm_sec
    
    