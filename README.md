# Client-Registration-App - Beta for IOS

Purpose: 
  - For incoming clients to be able to register through the app and have their registration form sent directly to the corresponding Real Estate Agent's email. Allowing the real estate agent to print the registration form from their computer. 

Background to why this is useful: 

  - When new clients come into the office, the real estate agent brings them into a conference room and hands them a registration form. The registration form is double sided and on the back side, it explains the broker's fee that my brokage charges to every client (15% of the annual's rent). It also explains that every building or complex that is introduced by the real estate agent, the client must use that brokage as the porcuring brokage in order to secure that apartment. This prevents clients from going behind the real estate agent's back and securing an apartment without paying the 15% broker's fee. 

  - The reality is that nobody wants to pay a 15% broker's fee and most clients ask about these clauses before they even begin registering. Sometimes real estate agents lose clients because clients don't understand what is stated in the clauses. This application prevents the user from reading these clauses when they are first filling out the registration form on paper. 

  - When the client is done registering, the real estate agent will then appraoch the client with a filled registration form and fully explain the broker's fee and how the process of securing an apartment in NYC is like. 

  - This prevents the real estate agent from having to waste time explaing the broker's fee and clauses that are stated on the backside of the registration form before the client has fully filled out the registration form. This also gives the real estate agent, the opportunity to vett the client on their apartment criteria's and budget. 

  - I am currently (5/15/19) a real estate agent

# How it works

- Client clicks registers through the UI

- Client fills out registration form

- Once the client hits submit, their information is converted into a JSON Object and sent to the html code (registration/1.html) which is the registration form written into html. 

- The Json Object is then parse in a JavaScript function and places each piece of the client's information into the coresponding text field within the html code. 

- Finally, a email composer is created with the registration form attached, subjected filled out and being sent to the corresponding real estate agent whom the client belongs to. The user will then have to click send in order to send the email. (IOS doesn't allow you to automatically send emails). 

- Then the application reverts back to the introductionary screen. 

# State of the application 

- Not yet published

- Fully functional 

- Does not check for correct input from user yet. Have not implemented yet because it is easier to test without. User must select agent's name, enter name, cell phone, email, budget, income, move in date and budget in order to submit. 

- Still needs to be cleaned up a bit, and a couple more functionalities need to be added. For example, a toolkid for the keyboard

- html needs to be changed a bit so that text fields are the correct size

- Some front end changes as well, to make the front end look pretty

# Things to come

- Server side so that computations aren't being done within the application

- Json Object is sent to a Java base server which then responds to the swift front end side

- Database (SQL) within the Java server to store client information for the real estate agent's database 

- Automatically sent email with registration form attached, so that the client doesn't have to click twice

- Real estate agent log in functionalities. Real estate agent could see registration forms on the application itself and print from their phones, pull up client's information with ease (cell phones numbers, emails, budget). 


