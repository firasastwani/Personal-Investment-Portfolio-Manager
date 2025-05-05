Harley Guan
Prototype for securitiesController.java
Prototype for the part of porofolioController that is related to show portfolios in dashboard
Prototype of Frontend code that shows portfolios. 
db_design.pdf
security.txt 
perf.txt

Wayne Lam
Developed Next.js frontend
- login/register page
- watchlist
- stocks
- profile
- buy/sell configuration
Managed frontend events and integrated backend APIs


Firas Astwani 
prelim.pdf
Set up database and table schemas
Found 1000 rows of security data online in a csv file and parsed it using python scripts in a seperate file. (see datasource.txt)
Created project with spring initializer and set up initial file structure for backend
Set up authentication and authorization for user registration and login
Implemented Portfolio, PortfolioHolding, and Transaction and their corresponding controllers, services, models, and repositories, which contains the logic for the portfolio management queries. 
Implemented PortfolioAnalyticsService.java, which contains the logic for the portfolio analytics queries. 

Demo Video Link: https://www.loom.com/share/a7df043c4f5b4e4899d9043d53d95237


Test users: 
user1 pass 
user2 pass 
user3 pass

Technology
Springboot
React frontend
Next.js

Database name: pipsap_db
Database username: root
Database password: mysqlpass


HOW TO RUN
First, type 
cd frontend in powershell
Then type and wait for installation
npm install
Then type to start the frontend
npm run dev 

For backend
Type to compile the code
mvn clean package
Then type to start the backend 
mvn sprint-boot:run 

