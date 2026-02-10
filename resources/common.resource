*** Settings ***
Library    Browser
Library    ../libraries/faker.py

*** Variables ***
${HOME_URL}    https://parabank.parasoft.com/parabank/index.htm
${BROWSER}    firefox


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
    New Browser   ${BROWSER}   false
    New Page    ${HOME_URL}

Test Teardown
    Close Browser