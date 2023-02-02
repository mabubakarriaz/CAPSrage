# CAPS Rage 

A simple .net console app to output strings into capital letters. Type exit to end.

## Docker file

used docker file to build caps rage code with .net code

## Jenkins file

used jenkins file to create declartive pipelines

### Branch Check-in

auto build pipeline on code check-in from github

### Source

source code fetched from github SCM

### Build

.net code is build and published using docker image

### Code Quality

.net code quality is checked using sonar qube.

### Docker Image

build code is then created into docker image.

### Docker push

docker image is push to docker registry and saved in gz format

### Archive

publish .net artifacts and docker image is archived

## script file

shell is used to setup pipeline and VM configurations.

--ftstd
