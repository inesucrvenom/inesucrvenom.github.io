---
title: Example DWH for bank account's transactions (Talend, MySQL)
image: assets/post-data.png
---
Learning DWH, ETL using Talend on simplified exercise.

## Task
Using Talend for ETL, create simple system of combining the data from multiple sources of different type. Generate several reports from that system.

#### Inputs
  - databases - clients, transactions
  - excel - exchange rate list
    - for specific days, pick several currencies
    - cover at least one month period

#### DWH
  - use Talend to implement simple ETL jobs which extracts the data from the sources, and combined together saves them into database
  - save history for data if it makes sense
  - document E/R model of a database

#### Output report examples
  - monthly report of transactions for a given month and a client
  - shopping habits for a given client - where the client spends most, which shops, through the months

## Discussion
I've never seen DWH or ETL before in my life.
After roughly 3 weeks of research and implementation, I've made a solution that made me proud.

Unfortunately, I lost Talend files for it, but I have materials that I've prepared as a backup for the presentation in case my borrowed notebook fails to run it.
It's mix of English and Croatian, but I think it can still illustrate the process quite well.

First, I had to do some research and experiment. While doing that I've made [this notes](https://github.com/inesucrvenom/practice-archive/tree/master/job-interview-data/talend-bank-transactions/talend-research.pdf).

From that and through the project, I've prepared myself for [presenting my findings](https://github.com/inesucrvenom/practice-archive/tree/master/job-interview-data/talend-bank-transactions/talend-notes-for-presenting.pdf).

And I've also prepared screenshots and details from Talend, which can be [seen here](https://github.com/inesucrvenom/practice-archive/tree/master/job-interview-data/talend-bank-transactions/talend-presentation.pdf).
