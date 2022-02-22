import tkinter as tk
from ctypes import windll
import threading
import time
from datetime import datetime

GWL_EXSTYLE=-20
WS_EX_APPWINDOW=0x00040000
WS_EX_TOOLWINDOW=0x00000080

width=150
height=30
xpos=-150
ypos=972
background='grey'  #this will be transparent

width=58
height=17
xpos=1355
ypos=890

width=77
xpos=1806
ypos=1034
background='green2'


class Display(threading.Thread):

    def __init__(self,  width, height, xpos, ypos, background):
        threading.Thread.__init__(self)
        self.start()
        self.height=height
        self.width=width
        self.xpos=xpos
        self.ypos=ypos
        self.background=background

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

        gemStr=str(self.width)+'x'+str(self.height)+'+'+str(self.xpos)+'+'+str(self.ypos)
        print(gemStr)
        #self.root.geometry("100x30+-150+972") 
        self.root.geometry(gemStr) 
        #self.root.attributes('-alpha', 0.3)
        self.root.wm_attributes("-topmost", 1)
        self.root.overrideredirect(True)
        self.root.after(10, lambda: self.set_appwindow(self.root))

        self.text = tk.StringVar()
        print(self.text)
        self.text.set("---")
        
        height=self.height
        width= self.width
        bg=self.background
        label = tk.Label(self.root, textvariable=self.text, bg=bg ,fg='#000', height=height, width=width, anchor="e")
        label.pack()
        self.root.attributes('-transparentcolor', 'grey')
        self.root.mainloop()

    def ontop(self):
        self.root.attributes('-topmost',True)
    def changeText(self,text):
        self.text.set(text)  

app = Display(   width , height, xpos, ypos, background)
print('Now we can continue running code while mainloop runs!')
time.sleep(10)
lines=""
workAtSec=45 #workAtSec should be between 1 and 59
while 1==1:
    try:
       f = open('../../content.txt','r')
       lines = f.readlines()
       f.close()
       lines[0]=lines[0][:-1]
       shownText=lines[0]
       batchNum_hr=int(lines[0][0:2])
       batchNum_min=int(lines[0][2:4])
       #print(batchNum_min)
       #print(batchNum_hr)
       batchNum= batchNum_hr*60 + batchNum_min
       current_min = int(datetime.now().strftime("%M"))
       current_hr = int(datetime.now().strftime("%H"))
       current_time= current_hr*60 + current_min
       print(shownText)
       if (current_time-batchNum)>5:
           position=0
           shownText=shownText[:position] + "-" + shownText[position+1:]
           position=1
           shownText=shownText[:position] + "-" + shownText[position+1:]
           position=2
           shownText=shownText[:position] + "-" + shownText[position+1:]
           position=3
           shownText=shownText[:position] + "-" + shownText[position+1:]           
           print(shownText)
    except IOError: 
       print("could not read file") 
    except:
       print("there is an error") 

    app.changeText(shownText)
    app.ontop()
    currSec=time.localtime().tm_sec
    if currSec>=workAtSec:
        totalWait=60-currSec+1
        intervalV=1
        for ii in range(4):
            if (totalWait-intervalV)>=intervalV:
                time.sleep(intervalV)
                totalWait=totalWait-intervalV
                app.ontop()
            else :
                time.sleep(totalWait)
                app.ontop()
                break
    while currSec<workAtSec:
        time.sleep(1)
        app.ontop()
        currSec=time.localtime().tm_sec
    
    