*** Settings ***
Library    Browser
Resource    ../resources/common.resource

*** Variables ***

#Sign Up Buttons

${sign_up_link}             css=#loginPanel > p:nth-child(3) > a
${register_button}          xpath=//*[@id="customerForm"]/table/tbody/tr[13]/td[2]/input

#Sign Up Form Fields
${first_name_path}          xpath=//*[@id="customer.firstName"]
${last_name_path}           xpath=//*[@id="customer.lastName"] 
${street_path}              xpath=//*[@id="customer.address.street"]
${city_path}                xpath=//*[@id="customer.address.city"]
${state_path}               xpath=//*[@id="customer.address.state"]
${zip_code_path}            xpath=//*[@id="customer.address.zipCode"]
${phone_number_path}        xpath=//*[@id="customer.phoneNumber"]
${ssn_path}                 xpath=//*[@id="customer.ssn"]
${username_path}            xpath=//*[@id="customer.username"]
${password_path}            xpath=//*[@id="customer.password"]
${confirm_password_path}    xpath=//*[@id="repeatedPassword"]

#Validation Messages
${login_error_message}      The username and password could not be verified.

#Login Form Fields
${login_username_path}      css=#loginPanel input[name="username"]
${login_password_path}      css=#loginPanel input[name="password"]

#Login Button
${login_button}             xpath=//*[@id="loginPanel"]/form/div[3]/input

${wrong_login_message}    text=The username and password could not be verified.

*** Keywords ***

Login User
    Fill Text   ${login_username_path}     ${USERNAME}    
    Fill Text   ${login_password_path}     ${PASSWORD}
    Click       ${login_button}    
    Wait For Elements State    text=Welcome ${FIRSTNAME}    visible    10s

Logout User
    Click        css=#leftPanel > ul > li:nth-child(8) > a

