*** Settings ***
Resource    ../resources/common.resource
Resource   ../resources/api.resource

Suite Setup   Suite Setup 1

*** Test Cases ***
Register New User
    [Documentation]    This test case verifies that a new user can register successfully.
    [Tags]    smoke
    [Teardown]    Close Browser
    Test Setup
    Sign Up User
    Fill Form With Valid Data
    Wait For Sign Up Welcome Message

Login With Valid Credentials
    [Documentation]    This test case verifies that a user can log in with valid credentials.
    [Tags]    smoke
    [Teardown]    Close Browser
    Test Setup
    Login User
    Wait For Login Welcome Message

Login With Invalid Credentials
    [Documentation]    This test case verifies that a user cannot log in with invalid credentials.
    [Tags]    negative
    [Teardown]    Close Browser
    Test Setup
    ${invalid_username}    ${invalid_password}=    Generate Invalid User
    Login User      ${invalid_username}    ${invalid_password}
    Wait For Login Error Message


    