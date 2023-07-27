# ✨ Shiny Rocks

**_✨ Shiny Rocks_** is a fictional company creating smartphones (_"those shiny rocks in our pockets"_). This project aims to provide a full working example of Kestra as you could have in a company.

**What is this repo?**

- A self-contained Kestra project. Useful for testing, exploring and play with Kestra features.


**What is this repo not?**

- A tutorial. You can check the documentation or videos for real tutorial contents. This project as some limitations due to its self-contained nature.

- A very complex projects. This repository aims to provide ideas and visions about Kestra, we try to keep things simple while showcase important or niche features.


**What's in?"**

- `docker-compose.yml`: to install the whole project in a self-contained environment.
- Terraform `main.tf` file: to deploy and manage Kestra assets.
- `./flows` folder: where we store Kestra Flows.
- `./shiny_rocks_dbt`: dbt project for data transformation
- `./dataset/produce`: script to generate data + historical data you could backfill in Kestra. As highlighted in introduction, it's all fake data.


## Data Model

![schema](misc/datastack_schema.png)

## Setup


