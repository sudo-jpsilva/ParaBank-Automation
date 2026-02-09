*** Settings ***
Library    Browser

*** Variables ***

${HOME_URL}    https://automationexercise.com/
${BUTTON_ACCEPT_COOKIES}    role=button[name="Consent"] 

*** Keywords ***
Home Page
    New Page    ${HOME_URL}

Home Page Accept Cookies
    Wait For Elements State    ${BUTTON_ACCEPT_COOKIES}    visible    10s
    Click    ${BUTTON_ACCEPT_COOKIES} 

