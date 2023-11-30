# Calorify

A Smart Calorie Burn Analyzer Using Linear Regression Algorithm

## System Flow Chart of Proposed Methodology

```mermaid
flowchart

user("User")
device("Android Device")
enter_calorie["Enter daily calorie intake"]
calorie_entake("Calorie\nIntake")
measure_calorie["Measure calorie burn\n based on activity level\n using mobile app"]
algorithm{{"Linear Regression\n Algorithm"}}
calorie_burn("Calorie Burn")
database[("Database")]

user --> enter_calorie
user --> device
enter_calorie --> calorie_entake
calorie_entake --> database
device --> measure_calorie
measure_calorie --> algorithm
algorithm --> calorie_burn
calorie_burn --> database
database

```

## Technologies Stack

1. [Flutter](https://flutter.dev/) for mobile development
2. [SQLite](https://www.sqlite.org/index.html) for data persistence
