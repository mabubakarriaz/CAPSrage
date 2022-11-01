﻿properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '5', artifactNumToKeepStr: '5', daysToKeepStr: '5', numToKeepStr: '5')
        timeout(time: 12, unit: 'HOURS')
        timestamps()
    }

    triggers {
          cron '@midnight'
    }

    stages {

        stage('Branch Check-in') {
            agent any
            steps {
                echo "${env.PATH}"
                checkout([
                 $class: 'GitSCM',
                 branches: [[name: 'main']],
                 userRemoteConfigs: [[url: 'https://github.com/mabubakarriaz/CAPSrage.git', credentialsId: '',]]
                ])
            }
        }

        stage('Source') {
            agent {
                 docker { image 'mcr.microsoft.com/dotnet/sdk:6.0' }
            }
            steps {
                echo "${env.PATH}"
                sh 'dotnet --version'
                sh 'git --version'
                git branch: 'main', url: 'https://github.com/mabubakarriaz/CAPSrage.git'
            }
        }
        
        stage('Build') {
            agent {
                 docker { image 'mcr.microsoft.com/dotnet/sdk:6.0' }
            }
            environment {
                    HOME = '/tmp'
                    DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
            } 
            steps {
                echo "${env.PATH}"
                sh "dotnet publish -p:PublishProfile=FolderProfile"
            }
        }

        stage('Code Quality') {
            agent {
                 docker { image 'mcr.microsoft.com/dotnet/sdk:6.0' }
            }
            environment {
                    HOME = '/tmp'
                    DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
                    SCANNER_HOME = "$DOTNET_CLI_HOME/.dotnet/tools"
                    PATH="$SCANNER_HOME:$PATH"
            } 
            steps {
                echo "${env.PATH}"   
                sh 'chmod -R 777 /opt/sonar-scanner-msbuild'
                //sh "dotnet tool install dotnet-sonarscanner --tool-path /tmp/DOTNET_CLI_HOME/.dotnet/tools --version 5.7.1"
                sh 'dotnet sonarscanner begin /k:"CapsRage" /d:sonar.host.url="http://20.237.254.87:9000" /d:sonar.login="sqp_9cee5034550e24e3cdf92b32436fdd76f7f4c689"'
                sh 'dotnet build'
                sh 'dotnet sonarscanner end /d:sonar.login="sqp_9cee5034550e24e3cdf92b32436fdd76f7f4c689"'
            }
        }

       
        stage('Docker Build') {
            agent any
            steps {       
                sh "docker build -t abubakarriaz/capsrage:$env.BUILD_NUMBER ."    
            }
        }   

        stage('Docker push') {         
            agent any
            environment {
		        DOCKERHUB_CREDENTIALS=credentials('docker-hub-abubakarriaz')
	        }
            steps {       
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push abubakarriaz/capsrage:$env.BUILD_NUMBER"  
                sh "docker save abubakarriaz/capsrage:$env.BUILD_NUMBER -o CAPSrage_image.gz" 
            }
        }  

        stage('Archive') {
            agent any
            steps {       
                echo "${env.PATH}"
                echo "${env.WORKSPACE}"
                echo "Creating artifacts..."
                archiveArtifacts artifacts: "bin/x64/Release/net6.0/publish/**.*", followSymlinks: false
                archiveArtifacts artifacts: "*.gz", followSymlinks: false
            }
        }   

    }

}
