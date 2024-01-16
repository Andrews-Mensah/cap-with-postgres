# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch` 
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.


## Postgres setup and deployment

Step 1:
Create a new cap project with command cds init

Step 2:
Add Schema.cds undr db and Service.cds under srv folder respectively

Step 3:
Add some mock data as csv format under db/data folder. The file format should be <namespace_entity.csv>

Step 4:
Test the service using cds watch

Step 5:
Add user authorization to Service.cds file

Step 6:
Add local test user to .cdsrc.json

Step 7:
First install docker desktop
Add docker-compose.yml under cap-pg -> This will create a docker image. The following command docker compose up will create the container within which Postgresql will run as a db server
After creating docker-compose.yml file, add this to the file
version: '3.1'

services:
  db:
    image: postgres:alpine
    restart: always
    environment:
      POSTGRES_PASSWORD: 'postgres'
    ports:
      - '5432:5432'
  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

Step 8:
Open http://localhost:8080 and login to Postgresql Server and create a database 'Student'

Step 9:
Add db deployment configuration under package.json

A. cds add postgres -> will add new cap service as dependency

"@cap-js/postgres": "^1"'
Execute npm install

B. Add local database information in Package.json or .cdsrc.json

C. cds deploy which will create underlined views and tables in PG.

Step 10:
Make the app ready for cf deployment.

A. Add passport -> npm add passport

B. Add xssecurity - > npm add @sap./xssec

C. Add xsuaa -> cds add xsuaa , will create xs-security.json

Step 11:
Build the app -> cds build

Step 12:
Add MTA to the project -> cds add mta

Step 13:
Create two files under cap-app

pg-package.json
pg-build.sh
Step 14:
A few corrections are required for mta.yaml file.

As the app I am planning to deploy in BTP trial (AWS). So the service plan should be 'Trial'.
rename the postgres instance name to 'cpapp-postgres' - done becuase I already create Postgresql instance in BTP with this name.
Under mta.yaml -> Builder section, Add pg-build.sh
Finally run mbt build to create mtar file
Step 15:
Deploy previously generated mtar file into cloud foundry

cf login
cf deploy mta_archives/cap-app_1.0.0.mtar
Backend service will be successfuly uploaded to BTP

Step 16:
Add role for user in BTP

A. Go to Trial Sub Account -> Security -> Role Collection -> Create new role collection

B. Edit the role collection and add the required roles as mainatined under xs-security.json (StudentAdmin & StudentViewer)

C.Add user ID and finally save

Step 17:
Test Service ==> using POSTMAN with oAuth2.0 authentication

Step 18:
Enable SSH to access BTP DB from

Execute command cf enable-ssh <app name>
Restart the App cf restart <app name>
Create a service key for Postgresql instance - cf create-service-key <postgresql instance name> srv_key
Display service key details - cf service-key <postgresql instance name> srv_key
Create the SSH Tunnel - cf ssh -L 63306:<postgress-instance-host-name>:<pg-instance-port-name> <app-name>
You need to install Postgresql cli client - choco install postgres14
Finally access the database service locally from command prompt - psql -d <dbname> -U <user name> -p 63306 -h localhost
Step 19:
psql commands to check database entries

psql number of database available
select datname from pg_catalog.pg_database;

to switch to table
\c 'db name'

To check available tables
\dt;

fetch records
select * from 'table';

insert new record
insert into 'table' (field1, field2, field3) values ('val1', 'val2', 'val3');
