# ULX Math Question Raffle
**A custom ULX script that adds timed math questions where the first user to answer correctly is added to a list of winners**


## Overview
This is a super simple and barebones script that sends a random addition question to the chat, and once a player answers correctly, it will record their name and SteamID to a file.


## Installation
This file should be put into the "garrysmod/lua/ulx/modules/" folder.

For the chat announcements, special syntax is used to color the messages in coordination with SCB chatbox, so edit that accordingly if needed. ({*text} and {cyan text} are the syntaxes I used)



## Commands / Usage

| Console Command | Chat Command     | Description                |
| :-------- | :------- | :------------------------- |
| `ulx enablemathquestions` | `!enablemathquestions` | Enables the script |
| `ulx disablemathquestions` | `!enablemathquestions` | Disables the script |

#### Configuration
This is all inside of the single file included within the repository.

| Parameter | Example     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `questionFrequency`      | `30` | Sets the frequency of questions to 30 seconds |
| `minNumber`      | `1` | Sets the minumum number to be used in each addition question |
| `maxNumber`      | `99` | Sets the maximum number to be used in each addition question |
| `resultFile`      | `correct_answers.txt` | Defines the file that correct user answers will be stored in (By default, located in garrysmod/data/correct_answers.txt) |


#### add(num1, num2)

Takes two numbers and returns the sum.


## Screenshots

![Demo screenshot](https://i.imgur.com/WNukb45.png)
![Demo screenshot](https://i.imgur.com/bx7snIb.gif)



## Authors

- [@SaladGFL](https://www.github.com/SaladGFL)

