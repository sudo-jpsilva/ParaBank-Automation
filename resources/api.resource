*** Settings ***

Library     Browser
Library     Collections
Library     RequestsLibrary
Resource    ../resources/common.resource



*** Variables ***

${BASE_URL}         https://parabank.parasoft.com/parabank

*** Keywords ***

Suite Setup For API
    [Documentation]    Performs end-to-end setup tasks, such as logging in via API to retrieve necessary data for tests.
    Clean and Initialize Database
    Suite Setup E2E
    Login With API to Get User ID

Clean and Initialize Database
    [Documentation]    Resets and initializes the ParaBank database to ensure a clean state for
    Clean Data Base
    Initialize Database

Create Session For API
    Create Session    parabank    ${BASE_URL}     verify=False

Login With API to Get User ID
    [Documentation]    Logs in via API and extracts the customer ID for use in subsequent API calls.
    Create Session For API
    ${params}=    Create Dictionary    _type=json
    ${response}=    GET On Session    parabank    
    ...    url=/services/bank/login/${USERNAME}/${PASSWORD}    
    ...    params=${params}
    Log To Console    Login Response: ${response.text}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Evaluate    json.loads('''${response.text}''')    json
    ${customer_id}=   Get From Dictionary   ${json}   id
    Set Suite Variable   ${CUSTOMER_ID}   ${customer_id}

Initialize Database
    [Documentation]    Reseta a base de dados do ParaBank via API.
    Create Session For API
    ${response}=    POST On Session
    ...    parabank
    ...    /services/bank/initializeDB
    ...    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    204

Clean Data Base
    [Documentation]    Limpa os dados do ParaBank via API.
    Create Session For API
    ${response}=    POST On Session
    ...    parabank
    ...    /services/bank/cleanDB
    ...    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    204

Get And Validate Customer Information
    [Documentation]    Retrieves customer information via API and validates it against expected values.
    [Arguments]    ${expected_first}    ${expected_last}    
    ...    ${expected_phone}  ${expected_address}  ${expected_city}   
    ...    ${expected_state}   ${expected_zip}   ${expected_ssn} 

    Create Session For API

    ${params}=    Create Dictionary    _type=json
    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${CUSTOMER_ID}
    ...    params=${params}
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    200
    ${customer}=    Set Variable    ${response.json()}

    ${first_name}=    Get From Dictionary    ${customer}    firstName
    ${last_name}=     Get From Dictionary    ${customer}    lastName
    ${phone}=         Get From Dictionary    ${customer}    phoneNumber

    Should Not Be Empty    ${first_name}    ${expected_first}
    Should Not Be Empty    ${last_name}     ${expected_last}
    Should Not Be Empty    ${phone}         ${expected_phone}

    # Campos aninhados (address)
    ${address}=       Get From Dictionary    ${customer}    address
    ${city}=          Get From Dictionary    ${address}     city
    ${state}=         Get From Dictionary    ${address}     state
    ${zip}=           Get From Dictionary    ${address}     zipCode
    ${ssn}=           Get From Dictionary    ${customer}    ssn
    
    Should Not Be Empty    ${address}       ${expected_address}
    Should Not Be Empty    ${city}          ${expected_city}
    Should Not Be Empty    ${state}         ${expected_state}
    Should Not Be Empty    ${zip}           ${expected_zip}
    Should Not Be Empty    ${ssn}           ${expected_ssn}

