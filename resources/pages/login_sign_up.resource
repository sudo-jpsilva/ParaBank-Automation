*** Settings ***
Library    Browser

*** Variables ***

#Sign Up Buttons

${sign_up_link}             css=#loginPanel > p:nth-child(3) > a
${register_button}          //*[@id="customerForm"]/table/tbody/tr[13]/td[2]/input

#Sign Up Form Fields
${first_name_path}          //*[@id="customer.firstName"]
${last_name_path}           //*[@id="customer.lastName"] 
${address_path}             //*[@id="customer.address.street"]
${city_path}                //*[@id="customer.address.city"]
${state_path}               //*[@id="customer.address.state"]
${zip_code_path}            //*[@id="customer.address.zipCode"]
${phone_number_path}        //*[@id="customer.phoneNumber"]
${ssn_path}                 //*[@id="customer.ssn"]
${username_path}            //*[@id="customer.username"]
${password_path}            //*[@id="customer.password"]
${confirm_password_path}    //*[@id="repeatedPassword"]

#Validation Messages
${login_error_message}      The username and password could not be verified.

#Login Form Fields
${login_username_path}      css=#loginPanel input[name="username"]
${login_password_path}      css=#loginPanel input[name="password"]

#Login Button
${login_button}             //*[@id="loginPanel"]/form/div[3]/input
${logout_link}              //*[@id="leftPanel"]/ul/li[8]/a

${welcome_message}          Welcome

*** Keywords ***

Login User
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Fill Text   ${login_username_path}     ${username}    
    Fill Text   ${login_password_path}     ${password}
    Click       xpath=${login_button}    

Wait For Login Welcome Message
    Wait For Elements State    text=${welcome_message} ${FIRSTNAME}    visible    10s

Wait For Login Error Message
    Wait For Elements State    text=${login_error_message}      visible    10s

Logout User
    Wait For Elements State    xpath=${logout_link}    visible    10s
    Click        xpath=${logout_link}

Fill Form With Valid Data
    [Documentation]    This keyword fills the registration form with valid data
    Wait And Fill Text    xpath=${first_name_path}        ${FIRSTNAME}
    Wait And Fill Text    xpath=${last_name_path}         ${LASTNAME}
    Wait And Fill Text    xpath=${address_path}           ${ADDRESS}
    Wait And Fill Text    xpath=${city_path}              ${CITY}
    Wait And Fill Text    xpath=${state_path}             ${STATE}
    Wait And Fill Text    xpath=${zip_code_path}          ${ZIP}
    Wait And Fill Text    xpath=${phone_number_path}      ${PHONE}
    Wait And Fill Text    xpath=${ssn_path}               ${SSN}
    Wait And Fill Text    xpath=${username_path}          ${USERNAME}
    Wait And Fill Text    xpath=${password_path}          ${PASSWORD}
    Wait And Fill Text    xpath=${confirm_password_path}  ${PASSWORD}
    Click        xpath=${register_button}

Wait And Fill Text
    [Documentation]    Waits for a field to be visible, fills it with the given value, and verifies the value was entered.
    [Arguments]    ${selector}    ${value}
    Wait For Elements State    ${selector}    visible    10s
    Fill Text                  ${selector}    ${value}
    ${actual}=    Get Text     ${selector}
    IF    '${actual}' != '${value}'
        Clear Text    ${selector}
        Fill Text     ${selector}    ${value}
        Get Text      ${selector}    ==    ${value}
    END

Sign Up User
    Click    ${sign_up_link}

Wait For Sign Up Welcome Message
    Wait For Elements State    text=${welcome_message} ${USERNAME}   visible    10s