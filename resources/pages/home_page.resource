*** Settings ***
Library    Browser
Resource   ../variables.resource


*** Keywords ***
Open Browser
    [Documentation]    Opens a new browser instance with headless mode enabled
    New Browser   ${BROWSER}   ${HEADLESS}
    
Go to Home Page
    [Documentation]    Navigates to the home page of the ParaBank application.
    New Page    ${HOME_URL}