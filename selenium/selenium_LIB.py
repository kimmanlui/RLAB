import time
from datetime import datetime
from datetime import date
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select

def whichisit():
    print("selenium_LIB version 13May")

def myOpen(server, url):
    target_url=server+url
    driver.get(target_url)
    
    
def myClick(pth):
    elem=driver.find_element_by_xpath(pth)  #find_element_by_id ('loginbutton')
    elem.click()
    
def myClick_name(name):
    inputElement = driver.find_element_by_name(name)
    inputElement.click()

def myClick_name_dex(name, dex):
    inputElements = driver.find_elements_by_name(name)
    inputElements[dex].click()    
    
def mySelect(pth, text):
    sel = Select(driver.find_element_by_xpath(pth))
    sel.select_by_visible_text(text) 
    
def mySend_keys(pth, text):
    driver.find_element_by_xpath(pth).clear()
    inputElement = driver.find_element_by_xpath(pth)
    inputElement.send_keys(text)     

def mySend_keys_id(id, text):
    driver.find_element_by_id(id).clear()
    inputElement = driver.find_element_by_id(id)
    inputElement.send_keys(text)   

def mySend_keys_name(name, text):
    driver.find_element_by_name(name).clear()
    inputElement = driver.find_element_by_name(name)
    inputElement.send_keys(text)   
    
def getStamp():
    dateTimeObj = datetime.now()
    stamp=dateTimeObj.strftime("%Y")+dateTimeObj.strftime("%m")+dateTimeObj.strftime("%d")
    return(stamp)

def myClear_name(name):
    driver.find_element_by_name(name).clear()


def myNumTable():
    return(len(getTable()))

def myTable():
    tables=driver.find_elements_by_xpath("//table")
    return(tables)


def myTableSize_dex(dex):
    tableEle=myTable()
    classV=tableEle[dex].get_attribute('class')
    r = driver.find_elements_by_xpath ("//table[@class= '"+classV+"']/tbody/tr")
    rc = len (r)
    c = driver.find_elements_by_xpath ("//table[@class= '"+classV+"']/tbody/tr[1]/td")
    cc = len (c)
    print(str(rc)+"x"+str(cc))
    
def myTableText_dex(dex, rowDex, colDex):
    tableEle=myTable()
    classV=tableEle[dex].get_attribute('class')
    tmp=driver.find_element_by_xpath ("//table[@class= '"+classV+"']/tbody/tr["+str(rowDex)+"]/td["+str(colDex)+"]").text
    return(tmp)

def myTableClick_dex(dex, rowDex, colDex):
    tableEle=myTable()
    classV=tableEle[dex].get_attribute('class')
    myTableClick(classV, rowDex, colDex)

def myTableSize(classV):
    tableEle=myTable()
    r = driver.find_elements_by_xpath ("//table[@class= '"+classV+"']/tbody/tr")
    rc = len (r)
    c = driver.find_elements_by_xpath ("//table[@class= '"+classV+"']/tbody/tr[1]/td")
    cc = len (c)
    print(str(rc)+"x"+str(cc))

def myTableText(classV, rowDex, colDex):
    tmp=driver.find_element_by_xpath ("//table[@class= '"+classV+"']/tbody/tr["+str(rowDex)+"]/td["+str(colDex)+"]").text
    return(tmp)

def myTableClick(classV, rowDex, colDex):
    driver.find_element_by_xpath ("//table[@class= '"+classV+"']/tbody/tr["+str(rowDex)+"]/td["+str(colDex)+"]").click()