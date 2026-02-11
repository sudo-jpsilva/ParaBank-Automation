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
${address_path}              xpath=//*[@id="customer.address.street"]
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
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Fill Text   ${login_username_path}     ${username}    
    Fill Text   ${login_password_path}     ${password}
    Click       ${login_button}    

Wait For Login Welcome Message
    Wait For Elements State    text=Welcome ${FIRSTNAME}    visible    10s

Wait For Login Error Message
    Wait For Elements State    ${wrong_login_message}      visible    10s

Logout User
    Click        css=#leftPanel > ul > li:nth-child(8) > a

Fill Form With Valid Data
    [Documentation]    This keyword fills the registration form with valid data and waits for the welcome message to be visible.
    Sleep        5s
    Fill Text    ${first_name_path}        ${FIRSTNAME}
    Fill Text    ${last_name_path}         ${LASTNAME}
    Fill Text    ${address_path}           ${ADDRESS}
    Fill Text    ${city_path}              ${CITY}
    Fill Text    ${state_path}             ${STATE}
    Fill Text    ${zip_code_path}          ${ZIP}
    Fill Text    ${phone_number_path}      ${PHONE}
    Fill Text    ${ssn_path}               ${SSN}
    Fill Text    ${username_path}          ${USERNAME}
    Fill Text    ${password_path}          ${PASSWORD}
    Fill Text    ${confirm_password_path}  ${PASSWORD}
    Click        ${register_button}
    Sleep        5s

Sign Up User
    Click        ${sign_up_link}

Wait For Sign Up Welcome Message
    Wait For Elements State    text=Welcome ${USERNAME}   visible    10s