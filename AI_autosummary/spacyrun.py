
# coding: utf-8

# Version 11.22 <a class="anchor" id="TOC"></a>

# <h1>Table of Contents<span class="tocSkip"></span></h1>
# <div class="toc"><ul class="toc-item"><li><span><a href="#Startup--&nbsp;&nbsp;TOC" data-toc-modified-id="Startup--&nbsp;&nbsp;TOC-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>Startup  &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#NLP-Function--&nbsp;&nbsp;TOC" data-toc-modified-id="NLP-Function--&nbsp;&nbsp;TOC-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>NLP Function  &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span><ul class="toc-item"><li><span><a href="#freqText-(text,-lem=1)---&nbsp;&nbsp;TOC" data-toc-modified-id="freqText-(text,-lem=1)---&nbsp;&nbsp;TOC-2.1"><span class="toc-item-num">2.1&nbsp;&nbsp;</span>freqText (text, lem=1)  <a class="anchor"></a> &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#cntUniqueWordsText-(text,-lem=1)---&nbsp;&nbsp;TOC" data-toc-modified-id="cntUniqueWordsText-(text,-lem=1)---&nbsp;&nbsp;TOC-2.2"><span class="toc-item-num">2.2&nbsp;&nbsp;</span>cntUniqueWordsText (text, lem=1)  <a class="anchor"></a> &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#getUniqueWordsText-(text,-numV=20,-lem=1)---&nbsp;&nbsp;TOC" data-toc-modified-id="getUniqueWordsText-(text,-numV=20,-lem=1)---&nbsp;&nbsp;TOC-2.3"><span class="toc-item-num">2.3&nbsp;&nbsp;</span>getUniqueWordsText (text, numV=20, lem=1)  <a class="anchor"></a> &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#getSim,-getSimMean,-Average--&nbsp;&nbsp;TOC" data-toc-modified-id="getSim,-getSimMean,-Average--&nbsp;&nbsp;TOC-2.4"><span class="toc-item-num">2.4&nbsp;&nbsp;</span>getSim, getSimMean, Average <a class="anchor"></a> &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#summaryText,-cntWord,-minText,-topText--&nbsp;&nbsp;TOC" data-toc-modified-id="summaryText,-cntWord,-minText,-topText--&nbsp;&nbsp;TOC-2.5"><span class="toc-item-num">2.5&nbsp;&nbsp;</span>summaryText, cntWord, minText, topText <a class="anchor"></a> &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#getTS--&nbsp;&nbsp;TOC" data-toc-modified-id="getTS--&nbsp;&nbsp;TOC-2.6"><span class="toc-item-num">2.6&nbsp;&nbsp;</span>getTS <a class="anchor"></a> &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#cnt_sentence,-top_sentence_all,-top_sentence,-top_sentence_from_sorted_sentenece--&nbsp;&nbsp;TOC" data-toc-modified-id="cnt_sentence,-top_sentence_all,-top_sentence,-top_sentence_from_sorted_sentenece--&nbsp;&nbsp;TOC-2.7"><span class="toc-item-num">2.7&nbsp;&nbsp;</span>cnt_sentence, top_sentence_all, top_sentence, top_sentence_from_sorted_sentenece <a class="anchor"></a> &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li></ul></li><li><span><a href="#Email-Function--&nbsp;&nbsp;TOC" data-toc-modified-id="Email-Function--&nbsp;&nbsp;TOC-3"><span class="toc-item-num">3&nbsp;&nbsp;</span>Email Function  &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span><ul class="toc-item"><li><span><a href="#processEmailRaw,-extractHTML,-getText,-fixMinor-&nbsp;&nbsp;TOC" data-toc-modified-id="processEmailRaw,-extractHTML,-getText,-fixMinor-&nbsp;&nbsp;TOC-3.1"><span class="toc-item-num">3.1&nbsp;&nbsp;</span>processEmailRaw, extractHTML, getText, fixMinor &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#fixUniCode,-replyText,-replyTextHome-&nbsp;&nbsp;TOC" data-toc-modified-id="fixUniCode,-replyText,-replyTextHome-&nbsp;&nbsp;TOC-3.2"><span class="toc-item-num">3.2&nbsp;&nbsp;</span>fixUniCode, replyText, replyTextHome &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#getPayload,-getPayloadMsg-&nbsp;&nbsp;TOC" data-toc-modified-id="getPayload,-getPayloadMsg-&nbsp;&nbsp;TOC-3.3"><span class="toc-item-num">3.3&nbsp;&nbsp;</span>getPayload, getPayloadMsg &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#handleJunkBox-&nbsp;&nbsp;TOC" data-toc-modified-id="handleJunkBox-&nbsp;&nbsp;TOC-3.4"><span class="toc-item-num">3.4&nbsp;&nbsp;</span>handleJunkBox &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li></ul></li><li><span><a href="#Knowledge-Graph-Function--&nbsp;&nbsp;TOC" data-toc-modified-id="Knowledge-Graph-Function--&nbsp;&nbsp;TOC-4"><span class="toc-item-num">4&nbsp;&nbsp;</span>Knowledge Graph Function  &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span><ul class="toc-item"><li><span><a href="#get_entities,-get_relation,-getGraphInfo,-genGraph-&nbsp;&nbsp;TOC" data-toc-modified-id="get_entities,-get_relation,-getGraphInfo,-genGraph-&nbsp;&nbsp;TOC-4.1"><span class="toc-item-num">4.1&nbsp;&nbsp;</span>get_entities, get_relation, getGraphInfo, genGraph &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li></ul></li><li><span><a href="#Main-Program--&nbsp;&nbsp;TOC" data-toc-modified-id="Main-Program--&nbsp;&nbsp;TOC-5"><span class="toc-item-num">5&nbsp;&nbsp;</span>Main Program  &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li><li><span><a href="#Test-Knowledge-Graph--&nbsp;&nbsp;TOC" data-toc-modified-id="Test-Knowledge-Graph--&nbsp;&nbsp;TOC-6"><span class="toc-item-num">6&nbsp;&nbsp;</span>Test Knowledge Graph  &nbsp;&nbsp;<a href="#TOC">TOC</a></a></span></li></ul></div>

# # Startup  &nbsp;&nbsp;[TOC](#TOC)

# Get the basic information from logininfo.xml

# In[1]:


from bs4 import BeautifulSoup
infile = open("/Users/admin/Documents/Dropbox/jupyter/prj/logininfo.xml","r")
contents = infile.read()
soup = BeautifulSoup(contents,'xml')

username    =soup.conf.hotmail_username.get_text()
password    =soup.conf.hotmail_password.get_text()
HOTMAIL_HOST=soup.conf.hotmail_host.get_text()
HOTMAIL_USER=username
HOTMAIL_PASS=password
SMTP_HOST   =soup.conf.smtp_host.get_text()
SMTP_USER   =soup.conf.smtp_user.get_text()
SMTP_PASS   =soup.conf.smtp_pass.get_text()
testWho     =soup.conf.testwho.get_text()   


# Select which engine to use spacy : 1 or nltk : 0

# In[2]:


spacyEng=1
debug=0
knowledgeGraphFlag=0


# # NLP Function  &nbsp;&nbsp;[TOC](#TOC)

# In[3]:


import nltk 
from nltk.corpus import stopwords 
from nltk.tokenize import word_tokenize, sent_tokenize 


# ## freqText (text, lem=1)  <a class="anchor" ></a> &nbsp;&nbsp;[TOC](#TOC)

# In[4]:


def freqText(text, lem=1):
    import nltk 
    from nltk.corpus import stopwords 
    from nltk.tokenize import word_tokenize, sent_tokenize 
    stm = nltk.wordnet.WordNetLemmatizer()
    #stm = nltk.stem.SnowballStemmer('english')
    #stm = nltk.stem.PorterStemmer() 
    # Tokenizing the text 
    stopWords = set(stopwords.words("english")) 
    words = word_tokenize(text) 

    # Creating a frequency table to keep the  
    # score of each word 

    freqTable = dict() 
    for word in words: 
        word = word.lower() 
        if lem==1: 
            word=stm.lemmatize(word)    
            #word=stm.stem(word) 
        if word in stopWords: 
            continue    
        if word in freqTable:         
            freqTable[word] += 1
        else: 
            freqTable[word] = 1
    return(freqTable)        
    


# ## cntUniqueWordsText (text, lem=1)  <a class="anchor" ></a> &nbsp;&nbsp;[TOC](#TOC)

# In[5]:


def cntUniqueWordsText (text, lem=1):
    freqTable = freqText(text, lem)
    return(len(freqTable))


# ## getUniqueWordsText (text, numV=20, lem=1)  <a class="anchor" ></a> &nbsp;&nbsp;[TOC](#TOC)

# In[6]:


from operator import itemgetter
def getUniqueWordsText (text, numV=20, lem=1):
    freqTable = freqText(text, lem)
    #print(freqTable)
    x = freqTable
    #sorted_x = sorted(x.items(), key=operator.itemgetter(1), reverse=True)
    sorted_x = sorted(x.items(), key=itemgetter(1), reverse=True)
    a=str(sorted_x[0:numV])
    #print(a)
    a=a.replace('),', ')\n')
    a=a.replace('[','')
    a=a.replace(']','')
    a=a.replace("('",'')
    a=a.replace("',",' -> ')
    a=a.replace(")",'')
    return(a)


# ## getSim, getSimMean, Average <a class="anchor" ></a> &nbsp;&nbsp;[TOC](#TOC)

# In[7]:


import numpy as np

def getSim (sorted_x, limit):
    sents=sorted_sentence[0:limit]
    anaM=np.matlib.zeros((limit,limit))

    doc=[]
    for ii in range(len(sents)):
        doc.append(nlp(str(sents[ii][0])))


    for ii in range(0, limit) :
        for kk in range(ii, limit):
                simV=round(sents[kk][0].similarity(sents[ii][0]),2)
                anaM[ii,kk]=simV
                #print(str(ii)+' '+str(kk)+' '+str(simV))

    return(anaM.round(2))   

def getSimMean(sorted_x, limit):
    sents=sorted_sentence[0:limit]
    anaM=np.matlib.zeros((limit,limit))

    val=[]
    doc=[]
    for ii in range(len(sents)):
        doc.append(nlp(str(sents[ii][0])))


    for ii in range(0, limit) :
        for kk in range(ii, limit):
                simV=round(sents[kk][0].similarity(sents[ii][0]),2)
                val.append(simV)
                #print(str(ii)+' '+str(kk)+' '+str(simV))

    return(val)    

def Average(lst): 
    return round(sum(lst) / len(lst),3)


# ## summaryText, cntWord, minText, topText <a class="anchor" ></a> &nbsp;&nbsp;[TOC](#TOC)

# In[8]:



# REF : https://www.geeksforgeeks.org/python-text-summarizer/
def summaryText(text, threshold=1.2):
    import nltk 
    from nltk.corpus import stopwords 
    from nltk.tokenize import word_tokenize, sent_tokenize 
    # Tokenizing the text 
    stopWords = set(stopwords.words("english")) 
    words = word_tokenize(text) 

    # Creating a frequency table to keep the  
    # score of each word 

    freqTable = dict() 
    for word in words: 
        word = word.lower() 
        if word in stopWords: 
            continue
        if word in freqTable: 
            freqTable[word] += 1
        else: 
            freqTable[word] = 1

    # Creating a dictionary to keep the score 
    # of each sentence 
    sentences = sent_tokenize(text) 
    sentenceValue = dict() 

    for sentence in sentences: 
        for word, freq in freqTable.items(): 
            if word in sentence.lower(): 
                if sentence in sentenceValue: 
                    sentenceValue[sentence] += freq 
                else: 
                    sentenceValue[sentence] = freq 



    sumValues = 0
    for sentence in sentenceValue: 
        sumValues += sentenceValue[sentence] 
   
    # Average value of a sentence from the original text 

    average = int(sumValues / len(sentenceValue)) 

    # Storing sentences into our summary. 

    
   
    summary = '' 
    for sentence in sentences: 
        if (sentence in sentenceValue) and (sentenceValue[sentence] > (threshold * average)): 
            summary += " " + sentence 
    return(summary)
    
def cntWord(test_string):
  import string  
  res = sum([i.strip(string.punctuation).isalpha() for i in test_string.split()])
  return(res)

def minText(text):
    startAvgDex=0.9
    startAvgDexText=summaryText(text, startAvgDex)
    startAvgWordCnt=cntWord(startAvgDexText)
    lastAvgWordCnt=startAvgWordCnt
    lastAvgDexText=startAvgDexText

    for x in range(6):
        startAvgDex=startAvgDex + 0.1
        startAvgDexText=summaryText(text, startAvgDex)
        startAvgWordCnt=cntWord(startAvgDexText)
        if startAvgWordCnt==0 :
            minAvgDex=lastAvgWordCnt
        else :
            lastAvgWordCnt=startAvgWordCnt
            lastAvgDexText=startAvgDexText  
    return(lastAvgDexText)

def topText(text, top=2):
    import nltk 
    from nltk.corpus import stopwords 
    from nltk.tokenize import word_tokenize, sent_tokenize 
    # Tokenizing the text 
    stopWords = set(stopwords.words("english")) 
    words = word_tokenize(text) 

    # Creating a frequency table to keep the  
    # score of each word 

    freqTable = dict() 
    for word in words: 
        word = word.lower() 
        if word in stopWords: 
            continue
        if word in freqTable: 
            freqTable[word] += 1
        else: 
            freqTable[word] = 1

    # Creating a dictionary to keep the score 
    # of each sentence 
    sentences = sent_tokenize(text) 
    sentenceValue = dict() 

    for sentence in sentences: 
        for word, freq in freqTable.items(): 
            if word in sentence.lower(): 
                if sentence in sentenceValue: 
                    sentenceValue[sentence] += freq 
                else: 
                    sentenceValue[sentence] = freq 



    sumValues = 0
    for sentence in sentenceValue: 
        sumValues += sentenceValue[sentence] 
   
    # Average value of a sentence from the original text 

    average = int(sumValues / len(sentenceValue)) 

    # Storing sentences into our summary. 
    sentenceValueA=dict(sorted(sentenceValue.items(), key=lambda item: item[1], reverse=True))
    i=0
    summary=''
    for key, value in sentenceValue.items():
        temp = [key,value]
        #print(key)
        #print(value)
        if i<top:
            summary +=key+"\n\n"
        i+=1  
    return(summary)


# ## getTS <a class="anchor" ></a> &nbsp;&nbsp;[TOC](#TOC)

# In[9]:




import re
def getTS(text):
    gotText=''
    result = re.search(r".s\d.", text)
    if not (result):
        gotText='2'
    else :
        gotText=result.group(0)
        gotText=gotText.replace('.', '')
        gotText=gotText.replace('s', '')
    iText = int(gotText)
    if iText <= 1 :
        iText = 1
    if iText >= 20 :
        iText = 20
    return(iText)




   


# In[10]:


#!pip3 install -U pip setuptools wheel
#!pip3 install -U spacy
#!python -m spacy download en_core_web_sm
#!python -m spacy download en_core_web_lg


# In[11]:


from collections import Counter
from string import punctuation


# In[12]:


if spacyEng==1:
    import spacy
    nlp = spacy.load('en_core_web_lg')
    import en_core_web_lg
    nlp = en_core_web_lg.load()


# ## cnt_sentence, top_sentence_all, top_sentence, top_sentence_from_sorted_sentenece <a class="anchor" ></a> &nbsp;&nbsp;[TOC](#TOC)

# In[13]:


def cnt_sentence(text):
    keyword = []
    pos_tag = ['PROPN', 'ADJ', 'NOUN', 'VERB']
    doc = nlp(text.lower())
    for token in doc:
        if(token.text in nlp.Defaults.stop_words or token.text in punctuation):
            continue
        if(token.pos_ in pos_tag):
            keyword.append(token.text)
    
    freq_word = Counter(keyword)
    max_freq = Counter(keyword).most_common(1)[0][1]
    for w in freq_word:
        freq_word[w] = (freq_word[w]/max_freq)
        
    sent_strength={}
    for sent in doc.sents:
        for word in sent:
            if word.text in freq_word.keys():
                if sent in sent_strength.keys():
                    sent_strength[sent]+=freq_word[word.text]
                else:
                    sent_strength[sent]=freq_word[word.text]
    
    summary = []
    
    sorted_x = sorted(sent_strength.items(), key=lambda kv: kv[1], reverse=True)    
    return(len(sorted_x))


def top_sentence_all(text):
    keyword = []
    pos_tag = ['PROPN', 'ADJ', 'NOUN', 'VERB']
    doc = nlp(text.lower())
    for token in doc:
        if(token.text in nlp.Defaults.stop_words or token.text in punctuation):
            continue
        if(token.pos_ in pos_tag):
            keyword.append(token.text)
    
    freq_word = Counter(keyword)
    max_freq = Counter(keyword).most_common(1)[0][1]
    for w in freq_word:
        freq_word[w] = (freq_word[w]/max_freq)
        
    sent_strength={}
    for sent in doc.sents:
        for word in sent:
            if word.text in freq_word.keys():
                if sent in sent_strength.keys():
                    sent_strength[sent]+=freq_word[word.text]
                else:
                    sent_strength[sent]=freq_word[word.text]
    sorted_sentence = sorted(sent_strength.items(), key=lambda kv: kv[1], reverse=True)
    return(sorted_sentence)



def top_sentence(text, limit):
    sorted_x=top_sentence_all(text)
    summary = []
    counter = 0
    for i in range(len(sorted_x)):
        summary.append("\n\n"+str(sorted_x[i][0]).capitalize())

        counter += 1
        if(counter >= limit):
            break            
    return ' '.join(summary)



def top_sentence_from_sorted_sentenece(sorted_x, limit):
    summary = []
    counter = 0
    for i in range(len(sorted_x)):
        summary.append("\n\n"+str(i+1)+" "+str(sorted_x[i][0]).capitalize())

        counter += 1
        if(counter >= limit):
            break            
    return ' '.join(summary)


# In[14]:


# Input text - to summarize  
text_1 = """ 
There are many techniques available to generate extractive summarization to keep it simple, I will be using an unsupervised learning approach to find the sentences similarity and rank them. Summarization can be defined as a task of producing a concise and fluent summary while preserving key information and overall meaning. One benefit of this will be, you don’t need to train and build a model prior start using it for your project. It’s good to understand Cosine similarity to make the best use of the code you are going to see. Cosine similarity is a measure of similarity between two non-zero vectors of an inner product space that measures the cosine of the angle between them. Its measures cosine of the angle between vectors. The angle will be 0 if sentences are similar.
"""
text_2 = '''Yamaha is reminding people that musical equipment cases are for musical equipment — not people — two weeks after fugitive auto titan Carlos Ghosn reportedly was smuggled out of Japan in one. In a tweet over the weekend, the Japanese musical equipment company said it was not naming any names, but noted there had been many recent stories about people getting into musical equipment cases. Yamaha (YAMCY) warned people not to get into, or let others get into, its cases to avoid "unfortunate accidents." Multiple media outlets have reported that Ghosn managed to sneak through a Japanese airport to a private jet that whisked him out of the country by hiding in a large, black music equipment case with breathing holes drilled in the bottom. CNN Business has not independently confirmed those details of his escape. The former Nissan (NSANF) CEO had been out on bail awaiting trial in Japan on charges of financial wrongdoing before making his stunning escape to Lebanon at the end of December. Ghosn has referred to his departure as an effort to "escape injustice." In an interview with CNN\'s Richard Quest last week, Ghosn did not comment on the nature of his escape, saying he didn\'t want to endanger any of the people who aided in the operation. Ghosn did, however, respond to a question about what it felt like to ride through the airport in a packing case by first declining to comment but then adding: "Freedom, no matter the way it happens, is always sweet." In a press conference in Lebanon ahead of the CNN interview last Wednesday, Ghosn\'s first public appearance since fleeing Japan, Ghosn said he decided to leave the country because he believed he would not receive a fair trial, a claim Japanese authorities have disputed. Brands sometimes capitalize on their tangential relationship to big news in order to attract attention on social media. Yamaha is one of Japan\'s best known brands and Ghosn was one of Japan\'s top executives before being ousted from Nissan — a match made in social media heaven. Not surprisingly, Yamaha\'s post went viral on Twitter over the weekend.'''


# In[15]:


#print('Number of Sentences: '+str(cnt_sentence(text_3)))
#print(top_sentence(text_2, 2))


# In[16]:


#REF https://www.devdungeon.com/content/read-and-send-email-python#toc-3


# # Email Function  &nbsp;&nbsp;[TOC](#TOC)

# ## processEmailRaw, extractHTML, getText, fixMinor &nbsp;&nbsp;[TOC](#TOC)

# In[17]:


def processEmailRaw(raw_email):
    bodyAll=''
    raw_email_string = raw_email.decode('utf-8')
    # converts byte literal to string removing b''
    email_message = email.message_from_string(raw_email_string)
    # this will loop through all the available multiparts in mail
    for part in email_message.walk():
     if part.get_content_type() == "text/plain": # ignore attachments/html
      body = part.get_payload(decode=True)  
      bodyAll=bodyAll+body.decode('utf-8')
     else:
      continue
    return(bodyAll)

def extractHTML(sbody):
    stDex=sbody.find('<html>')
    enDex=sbody.find('</html>')
    sbody2=sbody[stDex:(enDex+7)]
    return(sbody2)

def getText(sbody2):
    from bs4 import BeautifulSoup
    #soup = BeautifulSoup(bodyAll, "lxml")
    soup = BeautifulSoup(sbody2, features="html.parser")
    # kill all script and style elements
    for script in soup(["script", "style"]):
        script.extract()    # rip it out

    # get text
    text = soup.get_text()

    # break into lines and remove leading and trailing space on each
    lines = (line.strip() for line in text.splitlines())
    # break multi-headlines into a line each
    chunks = (phrase.strip() for line in lines for phrase in line.split("  "))
    # drop blank lines
    text = '\n'.join(chunk for chunk in chunks if chunk)

    return(text)

def fixMinor(text):
    text=text.replace("=A1=A6", "")
    text=text.replace("=A1=A7", "")
    text=text.replace("=A1=A8", "")
    text=text.replace("=92", "")
    text=text.replace("=\n", "")
    text=text.replace("\n", " ")
    text=text.replace("\xa0"," ")
    return(text)
#print(bodyAll)
#http://www.vineetdhanawat.com/blog/2012/06/how-to-extract-email-gmail-contents-as-text-using-imaplib-via-imap-in-python-3/


# ## fixUniCode, replyText, replyTextHome &nbsp;&nbsp;[TOC](#TOC)

# In[18]:


#https://stackoverflow.com/questions/46160886/how-to-send-smtp-email-for-office365-with-python-using-tls-ssl
def fixUnicode(text):
    text = text.replace('\u2013','-')
    text = text.replace('\u2014','-')
    text = text.replace('\u201c','"')
    text = text.replace('\u201d','"')
    text = text.replace('\u2018','\'')
    text = text.replace('\u2019','\'')
    return(text)

def replyText(fromWho, toWho, subject, text, SMTP_HOST, SMTP_USER,SMTP_PASS):
    text=fixUnicode(text)
    import smtplib
    SMTP_SSL_PORT=587
    # Craft the email by hand
    from_email = toWho  # or simply the email address
    to_emails = [fromWho]
    body = text
    headers = f"From: {from_email}\r\n"
    headers += f"To: {', '.join(to_emails)}\r\n" 
    headers += f"Subject:"+subject+"\r\n"
    email_message = headers + "\r\n" + body  # Blank line needed between headers and body
    mailserver = smtplib.SMTP(SMTP_HOST,SMTP_SSL_PORT)
    mailserver.ehlo()
    mailserver.starttls()
    mailserver.login(SMTP_USER, SMTP_PASS)
    mailserver.sendmail(from_email,to_emails,email_message)
    mailserver.quit()
    


def replyTextHome(fromWho, toWho, subject, text, SMTP_HOST, SMTP_USER, SMTP_PASS):
    text=fixUnicode(text)
    import smtplib
    SMTP_SSL_PORT=25
    # Craft the email by hand
    from_email = toWho  # or simply the email address
    to_emails = [fromWho]
    body = text
    headers = f"From: {from_email}\r\n"
    headers += f"To: {', '.join(to_emails)}\r\n" 
    headers += f"Subject:"+subject+"\r\n"
    email_message = headers + "\r\n" + body  # Blank line needed between headers and body

    mailserver = smtplib.SMTP(SMTP_HOST,SMTP_SSL_PORT)
    mailserver.ehlo()
    #mailserver.starttls()
    mailserver.login(SMTP_USER, SMTP_PASS)
    mailserver.sendmail(from_email,to_emails,email_message)
    mailserver.quit()    

def waitMin(mins):
    time.sleep(mins*60)    


# ## getPayload, getPayloadMsg &nbsp;&nbsp;[TOC](#TOC)

# In[19]:


def getPayload(raw_email):
    msg = email.message_from_bytes(raw_email)
    if msg.is_multipart():
        # iterate over email parts
        for part in msg.walk():
            # extract content type of email
            content_type = part.get_content_type()
            content_disposition = str(part.get("Content-Disposition"))
            try:
                # get the email body
                body = part.get_payload(decode=True).decode()
            except:
                pass
            if content_type == "text/plain" and "attachment" not in content_disposition:
                # print text/plain emails and skip attachments
                body=body
    else:
        # extract content type of email
        content_type = msg.get_content_type()
        # get the email body
        body = msg.get_payload(decode=True).decode()
        if content_type == "text/plain":
            # print only text email parts
            body=body
    return(body)

def getPayloadMsg(body):
    htoken=body[0:body.find('\r\n')]
    s=body.find('\r\n\r\n')
    body1=body[s+4:len(body)] 
    e=body1.find(htoken)
    body2=body1[0:e]
    base64_message = body2
    base64_bytes = base64_message.encode('utf-8')
    message_bytes = base64.b64decode(base64_bytes)
    message = message_bytes.decode('utf-8')
    return(message)


# ## handleJunkBox &nbsp;&nbsp;[TOC](#TOC)

# In[20]:


def handleJunkBox():
    statusj, countj = M.select('junk')
    _, message_numbers_raw = M.search(None, 'ALL')
    junkMsg=message_numbers_raw[0].split()
    if len(junkMsg)>0:
        print("Moving Junk Msg "+str(len(junkMsg)))
        for i in range(len(junkMsg)):
            msg_uid=junkMsg[0]
            M.store(msg_uid, '-FLAGS', '\\SEEN') 
            result = M.copy( msg_uid, 'Inbox')
            #print(result[0])
            if result[0] == 'OK':
                mov, data = M.store( msg_uid , '+FLAGS', '(\\Deleted)')
                M.expunge()


# In[21]:


#socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS4,proxy_ip,proxy_port,True)
#socket.socket = socks.socksocket


# # Knowledge Graph Function  &nbsp;&nbsp;[TOC](#TOC)

# ## get_entities, get_relation, getGraphInfo, genGraph &nbsp;&nbsp;[TOC](#TOC)

# In[22]:


def get_entities(sent):
  ## chunk 1
  ent1 = ""
  ent2 = ""

  prv_tok_dep = ""    # dependency tag of previous token in the sentence
  prv_tok_text = ""   # previous token in the sentence

  prefix = ""
  modifier = ""

  #############################################################
  
  for tok in nlp(sent):
    ## chunk 2
    # if token is a punctuation mark then move on to the next token
    if tok.dep_ != "punct":
      # check: token is a compound word or not
      if tok.dep_ == "compound":
        prefix = tok.text
        # if the previous word was also a 'compound' then add the current word to it
        if prv_tok_dep == "compound":
          prefix = prv_tok_text + " "+ tok.text
      
      # check: token is a modifier or not
      if tok.dep_.endswith("mod") == True:
        modifier = tok.text
        # if the previous word was also a 'compound' then add the current word to it
        if prv_tok_dep == "compound":
          modifier = prv_tok_text + " "+ tok.text
      
      ## chunk 3
      if tok.dep_.find("subj") == True:
        ent1 = modifier +" "+ prefix + " "+ tok.text
        prefix = ""
        modifier = ""
        prv_tok_dep = ""
        prv_tok_text = ""      

      ## chunk 4
      if tok.dep_.find("obj") == True:
        ent2 = modifier +" "+ prefix +" "+ tok.text
        
      ## chunk 5  
      # update variables
      prv_tok_dep = tok.dep_
      prv_tok_text = tok.text
  #############################################################

  return [ent1.strip(), ent2.strip()]

def get_relation(sent):

  doc = nlp(sent)

  # Matcher class object 
  matcher = Matcher(nlp.vocab)

  #define the pattern 
  pattern = [{'DEP':'ROOT'}, 
            {'DEP':'prep','OP':"?"},
            {'DEP':'agent','OP':"?"},  
            {'POS':'ADJ','OP':"?"}] 

  matcher.add("matching_1", None, pattern) 

  matches = matcher(doc)
  k = len(matches) - 1

  span = doc[matches[k][1]:matches[k][2]] 

  return(span.text)

def getGraphInfo(candidate_sentences):
    entity_pairs = []
    for i in (candidate_sentences[1:10]):
        i=str(i)
        entity_pairs.append(get_entities(i))
    relations = []
    for i in (candidate_sentences[1:10]):
        i=str(i)
        relations.append(get_relation(i))
    
    # extract subject
    source = [i[0] for i in entity_pairs]

    # extract object
    target = [i[1] for i in entity_pairs]

    kg_df = pd.DataFrame({'source':source, 'target':target, 'edge':relations})
    return(kg_df)

def genGraph(filename, kg_df):
    G=nx.from_pandas_edgelist(kg_df, "source", "target", 
                          edge_attr=True, create_using=nx.MultiDiGraph())
    plt.figure(figsize=(12,12))

    pos = nx.spring_layout(G)
    nx.draw(G, with_labels=True, node_color='skyblue', edge_cmap=plt.cm.Blues, pos = pos)
    plt.savefig(filename)


# # Main Program  &nbsp;&nbsp;[TOC](#TOC)

# In[23]:



import re
import pandas as pd
import bs4
import requests
import spacy
from spacy import displacy

from spacy.matcher import Matcher 
from spacy.tokens import Span 

import networkx as nx

import matplotlib.pyplot as plt
from tqdm import tqdm

pd.set_option('display.max_colwidth', 200)
# %matplotlib inline


# In[24]:


import time
import imaplib
import email
from datetime import datetime
#from langdetect import detect
import re
import base64
import traceback 

mail_server = HOTMAIL_HOST
M=imaplib.IMAP4_SSL(host=mail_server)
M.login(username,password)



# In[25]:


# bring junk mails back to inbox
handleJunkBox()


# In[26]:


# get Unseen Message
status, count   = M.select('inbox')
_, message_numbers_raw = M.search(None, '(UNSEEN)')
unseenMsg=message_numbers_raw[0].split()


# In[27]:


#messageNumber=unseenMsg[0]


# In[28]:


print(unseenMsg)
#_, msg = M.fetch(messageNumber, '(RFC822)')    
#message = email.message_from_bytes(msg[0][1])


# In[29]:


#fromWho=str(message["from"])
#toWho=str(message["to"])
#subject=str(message["subject"])


# In[30]:


#status, data = M.fetch(messageNumber,'(UID BODY[TEXT])')
#raw_email=data[0][1]
#tmpText=getText(extractHTML(processEmailRaw(data[0][1])))
#text=fixMinor(tmpText)


# In[31]:


print("debug :"+str(debug+0))


# In[ ]:


fromWho='X'
subject='X'

showNumFreqWord=100


#for loopdx in range(5):
while 1==1:
    try:  
        for messageNumber in unseenMsg:
            _, msg = M.fetch(messageNumber, '(RFC822)')    
            message = email.message_from_bytes(msg[0][1])
            M.store(messageNumber, '+FLAGS', '\SEEN') 
            fromWho=str(message["from"])
            if "noreply" not in fromWho:
                toWho=str(message["to"])
                subject=str(message["subject"])
               
                status, data = M.fetch(messageNumber,'(UID BODY[TEXT])')
                raw_email=data[0][1]
                tmpText=getText(extractHTML(processEmailRaw(data[0][1])))
                text=fixMinor(tmpText)
                #detectLang=detect(text)
                
                numTop=int(getTS(subject))
                #numTop=2
                
                if len(text)!=0:                
                    properTextRate=round(text.count('=')/len(text),4)
                    isProperText=(properTextRate<=0.05)
                    print("new message ("+str(properTextRate)+"): "+fromWho+", "+subject)
                    #old block here before
                else: 
                    print('not html')
                    bodynon=getPayload(msg[0][1])
                    if len(bodynon)!=0:
                        if bodynon.find('<html>')!=-1:
                            tmpText=getText(extractHTML(bodynon))
                            text=fixMinor(tmpText)
                        else:
                            tmpText=getText(bodynon)
                            text=fixMinor(tmpText)
                    else :
                        text=''
                        
                    isProperText=(len(text)!=0)    
                    #if len(text)!=0:
                    
                    
                if isProperText:
                    sumInfo=''
                    orgtext=text
                    if fromWho=='Lui KM <cskmlui@hotmail.com>':
                        text=text.replace('(CNN)','.')
                        
                    
                    #dup
                    cntAll=cntUniqueWordsText(text)
                    anaAll=getUniqueWordsText(text, showNumFreqWord )
                    oCnt=cntWord(text) 
                    mRes="NA"
                    meanV=0
                    simNum=15
                    if spacyEng==1:
                        sorted_sentence = top_sentence_all(text)
                        text   = top_sentence_from_sorted_sentenece(sorted_sentence, numTop)
                        simM   = str(getSim(sorted_sentence, simNum))
                        meanV  = Average(getSimMean(sorted_sentence,simNum))
                        sCnt   = cntWord(text)
                        sumInfo= "("+str(sCnt)+"/"+str(oCnt)+"/"+str(cntAll)+"|"+str(meanV)+")"
                    else:
                        text=topText(text)
                        sCnt=cntWord(text)
                        sumInfo="("+str(sCnt)+"/"+str(oCnt)+"/"+str(cntAll)+")"
                    if numTop==20:
                        text=text+"\r\n\r\n-----Word Freq Cnt-----\r\n"+anaAll
                        text=text+"\r\n\r\n-----Similarity Matrix-----\r\n"+simM
                    replySubject="[Summary "+sumInfo+"] "+subject
                        # dup                          
                else :
                    text="The received email was not an HTML formatted email."
                    replySubject="[Problem] "+subject
                        
                try:
                    print("send email by replyText: "+replySubject)
                    if debug!=1:
                        replyText(fromWho, toWho, replySubject , text, HOTMAIL_HOST, HOTMAIL_USER, HOTMAIL_PASS)
                except:
                    print("send email by replyTextHome: "+replySubject)
                    if debug!=1: 
                        replyTextHome(fromWho, toWho, replySubject , text, SMTP_HOST, SMTP_USER, SMTP_PASS)                
            

        now = datetime.now()
        current_time = now.strftime("%H:%M")    
        print("wait ("+current_time+")")    
        if debug==1:
            break
        waitMin(1)  
        fromWho='X'
        subject='X'
        #handleJunkBox
        handleJunkBox()
        #get Unseen Message
        status, count   = M.select('inbox')
        _, message_numbers_raw = M.search(None, '(UNSEEN)')
        unseenMsg=message_numbers_raw[0].split()  
    except:
        traceback.print_exc() 
        print("Exception occurred")
        if fromWho!='X':
            print("problem with this email:"+fromWho+", "+subject) 
        waitMin(1)
        M=imaplib.IMAP4_SSL(host=mail_server)
        M.login(username,password)
        status, count = M.select('inbox')
        print("Exception End")

    if debug==1: 
        break

print("-END-")


# In[34]:


#.close()
#M.logout()


# # Test Knowledge Graph  &nbsp;&nbsp;[TOC](#TOC)

# In[98]:


#candidate_sentences=[]
#for i in range(len(sorted_sentence)): candidate_sentences.append(sorted_sentence[i][0])

    
#for i in reversed(range(len(candidate_sentences))):
#    if cntWord(candidate_sentences[i])<=2:
#        del candidate_sentences[i]


# In[122]:



#kg_df=getGraphInfo(candidate_sentences[1:50])
#genGraph('/Users/admin/Documents/kg_img/abc.png', kg_df)


# In[79]:



##############################################


# In[ ]:





# In[ ]:




