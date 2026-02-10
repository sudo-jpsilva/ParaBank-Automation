*** Settings ***
Library    Browser
Resource    ../resources/common.resource
Resource    ../resources/pages/login_sign_up.resource

Suite Setup   Suite Setup 1

*** Test Cases ***
Register New User
    [Documentation]    This test case verifies that a new user can register successfully.
    [Tags]    smoke
    [Teardown]    Close Browser
    Test Setup
    Click        ${sign_up_link}
    Sleep        5s
    Fill Text    ${first_name_path}        ${FIRSTNAME}
    Fill Text    ${last_name_path}         ${LASTNAME}
    Fill Text    ${street_path}            ${STREET}
    Fill Text    ${city_path}              ${CITY}
    Fill Text    ${state_path}             ${STATE}
    Fill Text    ${zip_code_path}          ${ZIP}
    Fill Text    ${phone_number_path}      ${PHONE}
    Fill Text    ${ssn_path}               ${SSN}
    Fill Text    ${username_path}          ${USERNAME}
    Fill Text    ${password_path}          ${PASSWORD}
    Fill Text    ${confirm_password_path}  ${PASSWORD}
    Click        ${register_button}
    Wait For Elements State    text=Welcome ${USERNAME}   visible    10s
    
Login With Valid Credentials
    [Documentation]    This test case verifies that a user can log in with valid credentials.
    [Tags]    smoke
    [Teardown]    Close Browser
    Test Setup
    Fill Text   ${login_username_path}     ${USERNAME}
    Fill Text   ${login_password_path}     ${PASSWORD}
    Click       ${login_button}    
    Wait For Elements State    text=Welcome ${FIRSTNAME}    visible    10s

Login With Invalid Credentials
    [Documentation]    This test case verifies that a user cannot log in with invalid credentials.
    [Tags]    negative
    [Teardown]    Close Browser
    Test Setup
    ${username}    ${password}=    Generate Invalid User
    Fill Text   ${login_username_path}     ${username}    
    Fill Text   ${login_password_path}     ${password}
    Click       ${login_button}    
    Wait For Elements State    ${wrong_login_message}      visible    10s



    