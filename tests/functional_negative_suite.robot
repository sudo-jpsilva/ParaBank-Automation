*** Settings ***
Library    Browser
Resource    ../resources/common.resource

Suite Setup   Suite Setup 1


*** Variables ***

${Chrome}    chromium
${Firefox}   firefox
${Edge}      edge

*** Test Cases ***
    
Register New User
    [Documentation]    This test case verifies that a new user can register successfully.
    [Tags]    smoke
    [Setup]    Test Setup
    [Teardown]    Test Teardown
    Click       css=#loginPanel > p:nth-child(3) > a
    Fill Text    xpath=//*[@id="customer.firstName"]          ${FIRSTNAME}
    Fill Text    xpath=//*[@id="customer.lastName"]           ${LASTNAME}
    Fill Text    xpath=//*[@id="customer.address.street"]     ${STREET}
    Fill Text    xpath=//*[@id="customer.address.city"]       ${CITY}
    Fill Text    xpath=//*[@id="customer.address.state"]      ${STATE}
    Fill Text    xpath=//*[@id="customer.address.zipCode"]    ${ZIP}
    Fill Text    xpath=//*[@id="customer.phoneNumber"]        ${PHONE}
    Fill Text    xpath=//*[@id="customer.ssn"]                ${SSN}
    Fill Text    xpath=//*[@id="customer.username"]           ${USERNAME}
    Fill Text    xpath=//*[@id="customer.password"]           ${PASSWORD}
    Fill Text    xpath=//*[@id="repeatedPassword"]            ${PASSWORD}
    Click        xpath=//*[@id="customerForm"]/table/tbody/tr[13]/td[2]/input
    Wait For Elements State    text=Welcome ${USERNAME}    visible    10s
    
Login With Valid Credentials
    [Documentation]    This test case verifies that a user can log in with valid credentials.
    [Tags]    smoke
    [Setup]    Test Setup
    [Teardown]    Test Teardown
    Fill Text   css=#loginPanel input[name="username"]     ${USERNAME}
    Fill Text   css=#loginPanel input[name="password"]     ${PASSWORD}
    Click       xpath=//*[@id="loginPanel"]/form/div[3]/input
    Wait For Elements State    text=Welcome ${FIRSTNAME}    visible    10s

Login With Invalid Credentials
    [Documentation]    This test case verifies that a user cannot log in with invalid credentials.
    [Tags]    negative
    [Setup]    Test Setup
    [Teardown]    Test Teardown
    ${username}    ${password}=    Generate Invalid User
    Fill Text   css=#loginPanel input[name="username"]     ${username}    
    Fill Text   css=#loginPanel input[name="password"]     ${password}
    Click       xpath=//*[@id="loginPanel"]/form/div[3]/input
    Wait For Elements State    text=The username and password could not be verified.    visible    10s



    