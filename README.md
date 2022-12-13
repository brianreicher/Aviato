# Aviato - A Marketplace for Airline Ticket Resale

Aviato is an online trading platform & marketplace, indented to act as
a Google Flights + StubHub hybrid. As a frequent flyer myself, I
understand the chaos of flight prices. For example, a roundtrip December 2022 flight from New
York (JFK) to San Francisco (SFO) has increased over $250 in the
past month, and ultimately acts to discourage travel for many
budgeting/impulse vacationers. 

With the intent to ease the financial burden of airline travel and increase sporadic exploration, Aviato facilitates the exchange of airline flights between users -- intending to use travel reservations as investment/currency. This can also be
used to ease the drama of last-minute plan mixups, as flyers who
wish to get rid of upcoming non-refundable tickets have a place to
"cut their losses" and make back a portion of their initial purchase.
Aviato will be built with the
hopes of connecting all major US-based airlines (United, American,
Delta, JetBlue, Hawaiian Airlines, Alaskan Airlines, and Southwest).
In the future, Aviato will look beyond the scope of our course project and
construct an OAuth backend to integrate with airline and bank
accounts.

## Current Working Build
The application currently supports a MVP-build of Aviato - not yet with full trading functionality. Here, users are able to login or create an account, view their profile, add flights to their profile, and browse flights on the marketplace. Applicaiton adminstrator are able to view user account information, purchase histories, and transaction information. 

## How to setup and start the backend

1. Install Docker Desktop
1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 




