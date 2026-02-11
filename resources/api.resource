*** Settings ***

Library     Browser
Library     Collections
Library     RequestsLibrary
Resource    ../resources/common.resource
Resource    ../resources/pages/login_sign_up.resource



*** Variables ***

${BASE_URL}         http://parabank.parasoft.com/parabank

*** Keywords ***

Suite Setup For API
    [Documentation]    Performs end-to-end setup tasks, such as logging in via API to retrieve necessary data for tests.
    Suite Setup E2E
    Login With API to Get User ID

Login With API to Get User ID

    [Documentation]    Logs in via API and extracts the customer ID for use in subsequent API calls.
    Create Session    parabank    ${BASE_URL}

    ${params}=    Create Dictionary    _type=json
    ${response}=    GET On Session    parabank    url=/services/bank/login/${USERNAME}/${PASSWORD}    params=${params}

    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    Login Response: ${response.text}

    ${json}=    Evaluate    json.loads('''${response.text}''')    json
    ${customer_id}=   Get From Dictionary   ${json}   id
    Set Suite Variable   ${CUSTOMER_ID}   ${customer_id}

