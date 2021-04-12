import win32com.client
import time

def outlookMail(subject='CELLRPT', body='Hi\r\nok', to = 'X', rootFolderName='X'):
    olMailItem = 0x0
    obj = win32com.client.Dispatch("Outlook.Application")
    newMail = obj.CreateItem(olMailItem)
    newMail.Subject = subject
    newMail.Body = body
    newMail.To = to
    newMail.Send()
    time.sleep(2)
    namespace = obj.GetNamespace("MAPI")
    deleted_folder=namespace.Folders[rootFolderName].Folders['Sent Items']
    dex=len(deleted_folder.Items)-1
    subject=deleted_folder.Items[dex].Subject
    if subject.find(subject)>=0:
        deleted_folder.Items[dex].Delete()
