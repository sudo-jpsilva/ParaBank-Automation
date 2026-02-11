*** Settings ***
Library    RequestsLibrary
Resource    ../resources/common.resource
Resource    ../resources/api.resource

Suite Setup   Suite Setup For API

*** Variables ***

${invalid_id}    00000

*** Test Cases ***
Get Customers Accounts
    [Documentation]    Happy-path test for GET /services/bank/customers/{customer_id}/accounts
    Create Session    parabank    ${BASE_URL}

    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${CUSTOMER_ID}/accounts
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    Response: ${response.text}

Get Accounts With Invalid Customer ID
    [Documentation]    Negative test for GET /services/bank/customers/{customer_id}/accounts
    Create Session    parabank    ${BASE_URL}

    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${invalid_id}/accounts
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    400
    Log To Console    Response: ${response.text}


