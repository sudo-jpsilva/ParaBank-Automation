*** Settings ***
Resource    ../resources/pages/home_page.resource
Resource    ../resources/pages/login_signup.resource

*** Keywords ***

Suite Setup 
    Home Page
    Home Page Accept Cookies
    Signup Page
    Login Form
    Login Is Correct
    Delete Account

Check Account Created
    Wait For Elements State    text=ACCOUNT CREATED!    visible    10s
    Click        text=Continue

Delete Account
    Click        //*[@id="header"]/div/div/div/div[2]/div/ul/li[5]/a
    Wait For Elements State    text= ACCOUNT DELETED!    visible    10s
    Click        //*[@id="form"]/div/div/div/div/a

Log Out User
    Click        //*[@id="header"]/div/div/div/div[2]/div/ul/li[4]/a
    Home Page