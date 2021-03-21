# CDSS SQL Deep Dive Workshop

Hosted by Bailey Hwa: bnh2128@columbia.edu and Soohyun Ahn: sa3782@columbia.edu of Columbia Data Science Society (check us out [here](https://cdssatcu.com/)!)



## About

This repo contains code examples for the workshop written by me for SQL Deep Dive Workshop Spring 2021, hosted by Columbia Data Science Society, covering basic-intermediate SQL and database concepts. The examples in this repo covers intermediate/practical SQL used in an industry setting.

## Installation

### MySQL Workbench

1. Install the most recent versions of MySQL and MySQL Workbench. The download links are:
   - [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)
   - [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

- Follow the online installation instructions.


- When installing MySQL Community Server,
    - Choose the old/legacy password security option.
    - Choose ```root``` for the administrative user.
    - If MySQL generates a root password, make sure you write it down in a place where you will not loose it. If you set the password, make sure your write it down. <u>**DON'T LOSE IT**</u>
    
#### Testing MySQL Workbench & Loading the Example Database

- Start MySQL Workbench.
- There should be an already defined connection button. Connect to the DB server.
- If there is not a connection, click to create one. Accept the default options but use the password you set.
    - The host should be 127.0.0.1
    - Port: 3306
    - User: root
- clone this repo: <code>git clone https://github.com/bnhwa/SQL_Deep_Dive_Workshop.git</code>
- In MySQL Workbench, go to "File"->"Open SQL Script"-> `create_db.sql` which should be in the cloned repo.
- Once you have that open, go to the tab "Query"->"Execute all" or if you like keyboard shortcuts `Ctrl+Shift+Enter`
- Voila!

## Running

#### SQL Examples

1. To initialize the example database, in MySQL Workbench, go to "File"->"Open SQL Script"-> `create_db.sql` which should be in the cloned repo. Execute that.
   - `create_db.sql`  creates the schema `sql_workshop` and everything needed for it. The file and its documentation covers DDL, DML, Integrity Constraints, database design principles, views, stored procedures, functions, and permissioning, as well as nested querying, and joins. Read it top do down and uncomment to see what things do.

2. To test the query examples open `queries.sql` and execute that. You can see the topmost queries will be displayed towards the left in the tabs under "Result Grid"



## Further Resources

Now that you've got a taste of the sql essentials, have fun messing around data:

[Lahman Baseball database:](http://www.seanlahman.com/baseball-archive/statistics/)

[Game of Thrones Database/visualization:](https://jeffreylancaster.github.io/game-of-thrones/) 



If you want to learn about the algorithms regarding how databases more efficiently retrieve info, knock yourself out [here](https://nlp.stanford.edu/IR-book/)

