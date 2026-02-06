*** Settings ***
Library    Browser

*** Variables ***

${LOGIN_URL}    https://automationexercise.com/login
${SIGNUP_PAGE}    id=form
${SIGNUP_PAGE_TEXT}    New User Signup!

${NAME_PATH}        //*[@id="form"]/div/div/div[3]/div/form/input[2]
${EMAIL_PATH}       //*[@id="form"]/div/div/div[3]/div/form/input[3]
${SIGNUP_BUTTON}    //*[@id="form"]/div/div/div[3]/div/form/button
${SIGNUP_SUCCESS}    text=Enter Account Information

*** Keywords ***
Signup Page
    New Page    ${LOGIN_URL}
    ${text}=     Get Text    ${SIGNUP_PAGE}
    Should Contain    ${text}    ${SIGNUP_PAGE_TEXT}

Signup Form
    Fill Text    ${NAME_PATH}        joaop
    Fill Text    ${EMAIL_PATH}       avlis.ooj@gmail.com
    Click        ${SIGNUP_BUTTON}
    Wait For Elements State    ${SIGNUP_SUCCESS}    visible    10s

Account Information
    Click        id=id_gender1
    Fill Text    id=name     jpsilva
    Fill Text    id=password  123456789
    Select Options By    id=days    value    10
    Select Options By    id=months  value    4
    Select Options By    id=years   value    1990
    Fill Text    id=first_name   joao
    Fill Text    id=last_name    silva
    Fill Text    id=address1     Rua da Ruazinha, 123
    Select Options By    id=country  value    United States
    Fill Text    id=state       California
    Fill Text    id=city        Los Angeles
    Fill Text    id=zipcode      90001
    Fill Text    id=mobile_number  1234567890
    Click        //*[@id="form"]/div/div/div/div[1]/form/button



