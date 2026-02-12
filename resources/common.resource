*** Settings ***
Library    Browser
Library    ../libraries/faker.py
Resource    ../resources/pages/home_page.resource
Resource   ../resources/pages/login_sign_up.resource
Resource    ../resources/api.resource

*** Keywords ***

# Data Generation Keywords
Generate Data For New User
    [Documentation]    This keyword generates random data for a new user registration.
    ${first_name}    Generate First Name
    ${last_name}     Generate Last Name
    ${email}         Generate Random Email
    ${password}      Generate Random Password
    ${address}       Generate Random Address
    ${city}          Generate City
    ${state}         Generate State
    ${zip_code}      Generate Zip Code
    ${phone_number}  Generate Phone Number
    ${ssn}           Generate SSN
    ${username}      Generate Username
    ${password}      Generate Random Password
    RETURN   ${first_name}    ${last_name}    ${email}    ${password}    ${address}    ${city}    ${state}    ${zip_code}    ${phone_number}    ${ssn}    ${username}

Generate Invalid User
    [Documentation]    This keyword generates invalid user credentials for testing negative scenarios.
    ${username}      Generate Username
    ${password}      Generate Random Password
    RETURN   ${username}    ${password}

# User Interaction Keywords
Register New User
    [Documentation]    This keyword fills the registration form with valid data and submits it to create a new user account.
    Click        ${sign_up_link}
    Fill Form With Valid Data

# Suite Setup and Test Setup Keywords
Suite Setup 1
    [Documentation]    This keyword is executed before the test suite starts. It can be used to set up any necessary preconditions for the tests.
    Clean and Initialize Database
    ${first}  ${last}  ${email}  ${password}  ${address}  ${city}
    ...  ${state}  ${zip}  ${phone}  ${ssn}  ${username}=    Generate Data For New User
    Set Suite Variable    ${FIRSTNAME}     ${first}
    Set Suite Variable    ${LASTNAME}      ${last}
    Set Suite Variable    ${EMAIL}         ${email}
    Set Suite Variable    ${ADDRESS}       ${address}
    Set Suite Variable    ${CITY}          ${city}
    Set Suite Variable    ${STATE}         ${state}
    Set Suite Variable    ${ZIP}           ${zip}
    Set Suite Variable    ${PHONE}         ${phone}
    Set Suite Variable    ${SSN}           ${ssn}
    Set Suite Variable    ${USERNAME}      ${username}
    Set Suite Variable    ${PASSWORD}      ${password}

Suite Setup E2E
    [Documentation]    This keyword is executed before the test suite starts. It can be used to set up any necessary preconditions for end-to-end testing.
    Clean and Initialize Database
    Suite Setup 1
    Open Browser
    Go to Home Page
    Register New User
    Logout User

Test Setup
    [Documentation]    This keyword is executed before each test case. It can be used to set up any necessary preconditions for the individual tests.
    Open Browser
    Go to Home Page


