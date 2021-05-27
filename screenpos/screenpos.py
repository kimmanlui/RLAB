#!/usr/bin/env python
# coding: utf-8

# In[264]:

# REF
# https://stackoverflow.com/questions/55547940/how-to-get-a-list-of-the-name-of-every-open-window

# HOW TO PIN A TASKBAR SHORTCUT
# https://www.digitalcitizen.life/how-pin-special-windows-shortcuts-taskbar/



import win32gui
import win32con
import subprocess
import time
import win32com.client
from PIL import ImageGrab

def findFirstMatch(word, winTitle ):
    for i in range(len(winTitle)):
        if word in winTitle[i]:
            return(winTitle[i])
        
def listWinEnumHandler( hwnd, ctx ):
    global x
    if win32gui.IsWindowVisible( hwnd ):
        title=win32gui.GetWindowText( hwnd )
        winTitle.append(title)
        #print (hex(hwnd), title)

def windowEnumHandler(hwnd, top_windows):
    top_windows.append((hwnd, win32gui.GetWindowText(hwnd)))

def bringToFront(window_name):
    top_windows = []
    win32gui.EnumWindows(windowEnumHandler, top_windows)
    for i in top_windows:
        #print(i[1])
        if window_name.lower() in i[1].lower():
            # print("found", window_name)
            win32gui.ShowWindow(i[0], win32con.SW_SHOWNORMAL)
            win32gui.ShowWindow(i[0], win32con.SW_RESTORE)
            
           
            shell = win32com.client.Dispatch("WScript.Shell")
            shell.SendKeys('%')
            win32gui.SetForegroundWindow(i[0])
            
            win32gui.BringWindowToTop(i[0])
            win32gui.SetActiveWindow(i[0])
            #win32gui.SetWindowPos(i[0],win32con.HWND_NOTOPMOST, 0, 0, 0, 0, win32con.SWP_NOMOVE + win32con.SWP_NOSIZE)  
            #win32gui.SetWindowPos(i[0],win32con.HWND_TOPMOST, 0, 0, 0, 0, win32con.SWP_NOMOVE + win32con.SWP_NOSIZE)  
            #win32gui.SetWindowPos(i[0],win32con.HWND_NOTOPMOST, 0, 0, 0, 0, win32con.SWP_SHOWWINDOW + win32con.SWP_NOMOVE + win32con.SWP_NOSIZE) 

            break


# In[ ]:





# In[ ]:





# In[246]:


import pickle

def saveObj(obj):
    f = open('/kim/temp/screenpos/store.pckl', 'wb')
    pickle.dump(obj, f)
    f.close()

def loadObj():
    f = open('/kim/temp/screenpos/store.pckl', 'rb')
    obj = pickle.load(f)
    f.close()
    return(obj)
        
      


# In[ ]:





# In[ ]:






# In[247]:


runStatus=loadObj()
# [ xCorr, yCorr, width, height]
if runStatus==0:
    notepad=[-431,868,430,130]
    chrome=[645, 0, 805, 862]
    outlook=[-431, 0, 1093, 868]
if runStatus==1:
    notepad=[-431,868,430,130]
    chrome=[0, 0, 1450, 862]
    outlook=[-985, 0, 993, 868]
if runStatus==2:
    #chrome=[300, 0, 1150, 862]
    notepad=[0,0,700,989]
    chrome=[685, 0, 1450, 862]
    outlook=[-985, 0, 993, 868]    
    
if runStatus==0: 
    runStatus=1
elif runStatus==1: 
    runStatus=2
else: 
    runStatus=0

saveObj(runStatus)   


# hwnd = win32gui.FindWindow(None, "screenpos - Jupyter Notebook - Google Chrome")
# rect = win32gui.GetWindowRect(hwnd)
# x = rect[0]
# y = rect[1]
# w = rect[2] - x
# h = rect[3] - y
# print("Window %s:" % win32gui.GetWindowText(hwnd))
# print("\tLocation: (%d, %d)" % (x, y))
# print("\t    Size: (%d, %d)" % (w, h))

# In[275]:


winTitle = []
win32gui.EnumWindows( listWinEnumHandler, None )


# In[277]:


program=findFirstMatch('Microsoft Outlook', winTitle)
if program==None:
    proc = subprocess.Popen(["/PROGRA~2/MICROS~1/Office14/outlook.exe"])
    time.sleep(8)
program=findFirstMatch('Mozilla Firefox', winTitle)
if program==None:
    proc = subprocess.Popen(["/PROGRA~2/mozill~1/firefox.exe"])
    time.sleep(8) 
program=findFirstMatch('Google Chrome', winTitle)
if program==None:
    proc = subprocess.Popen(["/PROGRA~2/Google/Chrome/Application/chrome.exe"])
    time.sleep(8) 
program=findFirstMatch('Explorer++', winTitle)
if program==None:
    proc = subprocess.Popen(["/PROGRA~1/Explorerpp/Explorer++.exe"])
    time.sleep(8)     


# In[269]:




winTitle = []
win32gui.EnumWindows( listWinEnumHandler, None )


# In[270]:


program=findFirstMatch('Mozilla Firefox', winTitle)
bringToFront(program)
hwnd=win32gui.FindWindow(None, program)
win32gui.MoveWindow(hwnd, -1284, 0, 866, 989, True)


# In[ ]:





# In[271]:


program=findFirstMatch('Explorer++', winTitle)
bringToFront(program)
hwnd=win32gui.FindWindow(None, program)
win32gui.MoveWindow(hwnd, notepad[0], notepad[1], notepad[2], notepad[3], True)


# In[272]:


program=findFirstMatch('Microsoft Outlook', winTitle)
bringToFront(program)
hwnd=win32gui.FindWindow(None, program)
win32gui.MoveWindow(hwnd, outlook[0], outlook[1], outlook[2], outlook[3], True)


# In[215]:


program=findFirstMatch('Google Chrome', winTitle)
bringToFront(program)
hwnd=win32gui.FindWindow(None, program)
win32gui.MoveWindow(hwnd, chrome[0], chrome[1], chrome[2], chrome[3], True)


# In[120]:



#winTitle


# In[188]:


notepad=[0,0,700,989]
chrome=[685, 0, 1450, 862]
outlook=[-985, 0, 993, 868] 


# In[144]:





# 

# In[ ]:




