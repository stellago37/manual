#!/usr/bin/env python
# coding: utf-8

# In[2]:


#pip install selenium


# In[4]:


from selenium import webdriver

driver = webdriver.Chrome("C:/Users/chromedriver.exe")
driver.get('https://www.google.com')


# In[5]:


# 페이지의 제목을 체크하여 'Google'에 제대로 접속했는지 확인한다
# Naver사이트는 아니니 error 코드 발생하는게 당연
assert "Google" in driver.title
assert "Naver" in driver.title


# In[7]:


#검색 입력 부분에 커서를 올리고
#검색 입력 부분에 다양한 명령을 내리기 위해 elem 변수에 할당한다
#우리가 구글에서 검색할 때 검색어를 입력하기 위해 검색창에 마우스를 클릭하는 것과 같은 행위를 코드로 하는 것
elem = driver.find_element_by_name("q")


# In[8]:


#입력 부분에 default로 값이 있을 수 있어 비운다
elem.clear()


# In[9]:


#검색어를 입력한다
elem.send_keys("Selenium")


# In[10]:


#검색을 실행한다
elem.submit()


# In[11]:


#검색이 제대로 됐는지 확인한다
assert "No results found." not in driver.page_source


# In[12]:


#브라우저를 종료한다
driver.close()

