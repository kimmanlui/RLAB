import pyautogui
import time
import win32api, win32con
from datetime import datetime
def click(x,y):
    win32api.SetCursorPos((x,y))
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN,x,y,0,0)
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP,x,y,0,0)

lastmpt=pyautogui.position() 
click(lastmpt[0]+1,lastmpt[1]+0)
action =1
while 1==1:
    mpt=pyautogui.position() 
    if mpt[0]==lastmpt[0] and mpt[1]==lastmpt[1]:
        now = datetime.now()
        current_time = now.strftime("%H:%M:%S")
        print("Move the mouse at ", current_time)
        click(mpt[0]+action,mpt[1]+action)
        action = action * -1
    lastmpt=mpt
    time.sleep(60*4)