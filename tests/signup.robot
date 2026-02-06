*** Settings ***

Resource    ../resources/pages/home_page.resource
Resource    ../resources/pages/login_signup.resource

#Suite Teardown   Delete Account

*** Keywords ***

Check Account Created
    Wait For Elements State    text=ACCOUNT CREATED!    visible    10s
    Click        text=Continue

Delete Account
    Click        //*[@id="header"]/div/div/div/div[2]/div/ul/li[5]/a
    Wait For Elements State    text= ACCOUNT DELETED!    visible    10s
    Click        //*[@id="form"]/div/div/div/div/a

*** Test Cases ***
Signup
    Home Page Accept Cookies
    Signup Page
    Signup Form
    Account Information
    Check Account Created
    Delete Account

