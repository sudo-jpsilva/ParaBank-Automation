*** Settings ***
Library    Browser
Library    ../libraries/faker.py
Resource    ../resources/pages/home_page.resource
Resource    ../resources/pages/login_sign_up.resource

*** Variables ***



*** Keywords ***
Generate Data For New User
    ${first_name}    Generate First Name
    ${last_name}     Generate Last Name
    ${email}         Generate Random Email
    ${password}      Generate Random Password
    ${street}        Generate Street
    ${city}          Generate City
    ${state}         Generate State
    ${zip_code}      Generate Zip Code
    ${phone_number}  Generate Phone Number
    ${ssn}           Generate SSN
    ${username}      Generate Username
    ${password}      Generate Random Password
    RETURN   ${first_name}    ${last_name}    ${email}    ${password}    ${street}    ${city}    ${state}    ${zip_code}    ${phone_number}    ${ssn}    ${username}

Generate Invalid User
    ${username}      Generate Username
    ${password}      Generate Random Password
    RETURN   ${username}    ${password}

Suite Setup 1

    ${first}  ${last}  ${email}  ${password}  ${street}  ${city}
    ...  ${state}  ${zip}  ${phone}  ${ssn}  ${username}=    Generate Data For New User

    Set Suite Variable    ${FIRSTNAME}    ${first}
    Set Suite Variable    ${LASTNAME}     ${last}
    Set Suite Variable    ${EMAIL}         ${email}
    Set Suite Variable    ${STREET}        ${street}
    Set Suite Variable    ${CITY}          ${city}
    Set Suite Variable    ${STATE}         ${state}
    Set Suite Variable    ${ZIP}           ${zip}
    Set Suite Variable    ${PHONE}         ${phone}
    Set Suite Variable    ${SSN}           ${ssn}
    Set Suite Variable    ${USERNAME}    ${username}
    Set Suite Variable    ${PASSWORD}    ${password}

Test Setup
    Open Browser
    Go to Home Page

Register New User
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

Suite Setup E2E
    Suite Setup 1
    Open Browser
    Go to Home Page
    Register New User
    Logout User


