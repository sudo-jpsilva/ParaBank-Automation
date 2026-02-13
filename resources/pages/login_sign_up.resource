*** Settings ***
Library     Browser
Resource    ../variables.resource


*** Variables ***
# Sign Up Navigation
${SIGN_UP_LINK}             css=#loginPanel > p:nth-child(3) > a
${REGISTER_BUTTON}          //*[@id="customerForm"]/table/tbody/tr[13]/td[2]/input

# Registration Form Fields
${REG_FIRST_NAME}           //*[@id="customer.firstName"]
${REG_LAST_NAME}            //*[@id="customer.lastName"]
${REG_ADDRESS}              //*[@id="customer.address.street"]
${REG_CITY}                 //*[@id="customer.address.city"]
${REG_STATE}                //*[@id="customer.address.state"]
${REG_ZIP_CODE}             //*[@id="customer.address.zipCode"]
${REG_PHONE}                //*[@id="customer.phoneNumber"]
${REG_SSN}                  //*[@id="customer.ssn"]
${REG_USERNAME}             //*[@id="customer.username"]
${REG_PASSWORD}             //*[@id="customer.password"]
${REG_CONFIRM_PASSWORD}     //*[@id="repeatedPassword"]

# Login Form Fields
${LOGIN_USERNAME}           css=#loginPanel input[name="username"]
${LOGIN_PASSWORD}           css=#loginPanel input[name="password"]
${LOGIN_BUTTON}             //*[@id="loginPanel"]/form/div[3]/input
${LOGOUT_LINK}              //*[@id="leftPanel"]/ul/li[8]/a

# Validation Messages
${LOGIN_ERROR_MESSAGE}      The username and password could not be verified.
${WELCOME_MESSAGE}          Welcome


*** Keywords ***
Login User
    [Documentation]    Logs in with the given credentials.
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Fill Text    ${LOGIN_USERNAME}    ${username}
    Fill Text    ${LOGIN_PASSWORD}    ${password}
    Click    xpath=${LOGIN_BUTTON}

Wait For Login Welcome Message
    [Documentation]    Waits for the welcome message after successful login.
    Wait For Elements State    text=${WELCOME_MESSAGE} ${FIRSTNAME}    visible    10s

Wait For Login Error Message
    [Documentation]    Waits for the error message after failed login.
    Wait For Elements State    text=${LOGIN_ERROR_MESSAGE}    visible    10s

Logout User
    [Documentation]    Logs out the current user.
    Wait For Elements State    xpath=${LOGOUT_LINK}    visible    10s
    Click    xpath=${LOGOUT_LINK}

Fill Form With Valid Data
    [Documentation]    Fills the registration form with valid generated data and submits it.
    Wait And Fill Text    xpath=${REG_FIRST_NAME}    ${FIRSTNAME}    # robocop: disable
    Wait And Fill Text    xpath=${REG_LAST_NAME}    ${LASTNAME}
    Wait And Fill Text    xpath=${REG_ADDRESS}    ${ADDRESS}
    Wait And Fill Text    xpath=${REG_CITY}    ${CITY}    # robocop: disable
    Wait And Fill Text    xpath=${REG_STATE}    ${STATE}
    Wait And Fill Text    xpath=${REG_ZIP_CODE}    ${ZIP}
    Wait And Fill Text    xpath=${REG_PHONE}    ${PHONE}
    Wait And Fill Text    xpath=${REG_SSN}    ${SSN}
    Wait And Fill Text    xpath=${REG_USERNAME}    ${USERNAME}
    Wait And Fill Text    xpath=${REG_PASSWORD}    ${PASSWORD}
    Wait And Fill Text    xpath=${REG_CONFIRM_PASSWORD}    ${PASSWORD}
    Click    xpath=${REGISTER_BUTTON}

Wait And Fill Text
    [Documentation]    Waits for a field to be visible, fills it with the given value, and verifies the value was entered.
    [Arguments]    ${selector}    ${value}
    Wait For Elements State    ${selector}    visible    10s
    Fill Text    ${selector}    ${value}
    ${actual}=    Get Text    ${selector}
    IF    '${actual}' != '${value}'
        Clear Text    ${selector}
        Fill Text    ${selector}    ${value}
        Get Text    ${selector}    ==    ${value}
    END

Sign Up User
    [Documentation]    Navigates to the sign-up page.
    Click    ${SIGN_UP_LINK}

Wait For Sign Up Welcome Message
    [Documentation]    Waits for the welcome message after successful registration.
    Wait For Elements State    text=${WELCOME_MESSAGE} ${USERNAME}    visible    10s
