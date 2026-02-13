*** Settings ***
Library     Collections
Library     RequestsLibrary
Resource    variables.resource


*** Keywords ***
Clean and Initialize Database
    [Documentation]    Resets and initializes the ParaBank database to ensure a clean state for testing.
    Clean Data Base
    Initialize Database

Create Session For API
    Create Session    parabank    ${BASE_URL}    verify=False

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
    ${customer_id}=    Get From Dictionary    ${json}    id
    Set Suite Variable    ${CUSTOMER_ID}    ${customer_id}

Initialize Database
    [Documentation]    Initializes the ParaBank database via API.
    Create Session For API
    ${response}=    POST On Session
    ...    parabank
    ...    /services/bank/initializeDB
    ...    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    204

Clean Data Base
    [Documentation]    Cleans the ParaBank database via API.
    Create Session For API
    ${response}=    POST On Session
    ...    parabank
    ...    /services/bank/cleanDB
    ...    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    204

Validate Customer Information
    [Documentation]    Retrieves customer information via API and validates it against expected values.
    [Arguments]    ${customer}    ${expected_first}    ${expected_last}
    ...    ${expected_phone}    ${expected_address}    ${expected_city}
    ...    ${expected_state}    ${expected_zip}    ${expected_ssn}

    ${first_name}=    Get From Dictionary    ${customer}    firstName
    ${last_name}=    Get From Dictionary    ${customer}    lastName
    ${phone}=    Get From Dictionary    ${customer}    phoneNumber

    Should Be Equal As Strings    ${first_name}    ${expected_first}
    Should Be Equal As Strings    ${last_name}    ${expected_last}
    Should Be Equal As Strings    ${phone}    ${expected_phone}

    # Nested fields (address)
    ${address}=    Get From Dictionary    ${customer}    address
    ${street}=    Get From Dictionary    ${address}    street
    ${city}=    Get From Dictionary    ${address}    city
    ${state}=    Get From Dictionary    ${address}    state
    ${zip}=    Get From Dictionary    ${address}    zipCode
    ${ssn}=    Get From Dictionary    ${customer}    ssn

    Should Be Equal As Strings    ${street}    ${expected_address}
    Should Be Equal As Strings    ${city}    ${expected_city}
    Should Be Equal As Strings    ${state}    ${expected_state}
    Should Be Equal As Strings    ${zip}    ${expected_zip}
    Should Be Equal As Strings    ${ssn}    ${expected_ssn}

Get Customer Accounts
    [Documentation]    Gets the list of accounts for the current customer via API.
    ${params}=    Create Dictionary    _type=json
    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${CUSTOMER_ID}/accounts
    ...    params=${params}
    ...    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    200
    ${accounts}=    Set Variable    ${response.json()}
    RETURN    ${accounts}

Validate Account List
    [Documentation]    Validates that the account list is not empty and each account has id, type, balance.
    [Arguments]    ${accounts}
    Should Not Be Empty    ${accounts}
    ${count}=    Get Length    ${accounts}
    Should Be True    ${count} >= 1
    FOR    ${i}    IN RANGE    ${count}
        ${account}=    Get From List    ${accounts}    ${i}
        Should Not Be Empty    ${account}    id
        Should Not Be Empty    ${account}    type
        Should Not Be Empty    ${account}    balance
    END

Get Accounts With Invalid Customer And Validate Error
    [Arguments]    ${invalid_id}
    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${invalid_id}/accounts
    ...    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    400
    Log    Body: ${response.text}
    Should Contain    ${response.text}    Could not find customer #0

Get Customer Information Response
    [Arguments]    ${customer_id}    ${expected_status}=200
    ${params}=    Create Dictionary    _type=json
    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${customer_id}
    ...    params=${params}
    ...    expected_status=anything
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    RETURN    ${response}

Update Customer Information With Random Data
    [Documentation]    Updates customer information with random data via API and validates the update was successful.

    ${first_name}    ${last_name}    ${email}    ${password}    ${address}    ${city}    ${state}
    ...    ${zip_code}    ${phone_number}    ${ssn}    ${username}=    Generate Data For New User

    ${params}=    Create Dictionary
    ...    firstName=${first_name}
    ...    lastName=${last_name}
    ...    phoneNumber=${phone_number}
    ...    street=${address}
    ...    city=${city}
    ...    state=${state}
    ...    zipCode=${zip_code}
    ...    ssn=${ssn}
    ...    username=${username}
    ...    password=${password}

    ${response}=    POST On Session
    ...    parabank
    ...    /services/bank/customers/update/${CUSTOMER_ID}
    ...    params=${params}
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.text}    Successfully updated customer profile

    RETURN    ${response}    ${first_name}    ${last_name}    ${email}    ${password}    ${address}    ${city}    ${state}    ${zip_code}    ${phone_number}    ${ssn}    ${username}
