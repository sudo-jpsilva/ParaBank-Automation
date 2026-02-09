*** Settings ***

Resource    ../resources/pages/home_page.resource
Resource    ../resources/pages/login_signup.resource
Resource    ../resources/common.resource

Suite Setup     Suite Setup


*** Test Cases ***
Signup
    Signup Page
    Signup Form
    Account Information
    Check Account Created
    Log Out User

Login User With Correct Email And Password
    Signup Page
    Login Form
    Login Is Correct
