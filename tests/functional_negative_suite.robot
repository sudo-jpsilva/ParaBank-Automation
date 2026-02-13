*** Settings ***
Resource        ../resources/common.resource

Suite Setup     Initialize Test Data


*** Test Cases ***
Register New User
    [Documentation]    This test case verifies that a new user can register successfully.
    [Tags]    ui    register    smoke
    Test Setup
    Sign Up User
    Fill Form With Valid Data
    Wait For Sign Up Welcome Message
    [Teardown]    Close Browser

Login With Valid Credentials
    [Documentation]    This test case verifies that a user can log in with valid credentials.
    [Tags]    ui    login    smoke
    Test Setup
    Login User
    Wait For Login Welcome Message
    [Teardown]    Close Browser

Login With Invalid Credentials
    [Documentation]    This test case verifies that a user cannot log in with invalid credentials.
    [Tags]    ui    login    negative    boundary
    Test Setup
    ${invalid_username}    ${invalid_password}=    Generate Invalid User
    Login User    ${invalid_username}    ${invalid_password}
    Wait For Login Error Message
    [Teardown]    Close Browser
