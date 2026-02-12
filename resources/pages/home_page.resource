*** Settings ***
Library    Browser

*** Variables ***

${HOME_URL}    https://parabank.parasoft.com/parabank/index.htm
${BROWSER}     firefox
${HEADLESS}    True

*** Keywords ***
Open Browser
    [Documentation]    Opens a new browser instance with headless mode enabled
    New Browser   ${BROWSER}   ${HEADLESS}
    
Go to Home Page
    [Documentation]    Navigates to the home page of the ParaBank application.
    New Page    ${HOME_URL}