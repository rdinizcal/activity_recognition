# Mobile based activity recognition
This repository contains the files and appropriate explanation on how to replicate our results for recognizing whether the owner of an Android mobile phone is stand still, walking or running.

## Dependencies

You will need:

- Python 3+
- Matlab 2019+

to execute the files.

## Repository Contents

The repository is divided in 4 files: 

 - sensorLog.txt is the data collected from the sensorfusion app
 - pre-process.py contains the algorithm to shape the data accordingly to the algorithm input
 - output.txt is the data in which the recognition is performed
 - algorithm is the activity recognition algorithm

## How we detect activity

We detect activity by manually analyzing the outcome from the algorithm. If the y axis stays at 1, it is most likely that the phone user was standing still. If it bounces frequently between 1 and 0, it is mos likely that the phone user is walking. And if it is 0, it is most likely that the phone user is running.

## Authors
* Johan Karlsson
* Ricardo Caldas
* Teodor Fredriksson
* Yu Ge
