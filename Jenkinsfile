properties([pipelineTriggers([githubPush()])])

pipeline {
    agent {
        docker { image 'mcr.microsoft.com/dotnet/sdk:6.0' }
    }

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
            steps {
                echo "${env.PATH}"
                sh 'dotnet --version'
                sh 'git --version'
                git branch: 'main', url: 'https://github.com/mabubakarriaz/CAPSrage.git'
            }
        }
        
        stage('Build') {
          environment {
                    HOME = '/tmp'
                    DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
                    } 
            steps {
                echo "${env.PATH}"
                sh "dotnet publish -p:PublishProfile=FolderProfile"
            }
        }
        stage('Test') {
            steps {
                echo "${env.PATH}"
                echo 'Testing..'
            }
        }
        stage('Report') {
            steps {
                echo "${env.PATH}"
                echo 'Reporting....'
            }
        }
        stage('Docker Build') {
            agent {
                dockerfile true
            }
            steps {
                echo "${env.PATH}"
                sh 'docker build -t mabubakarriaz/CAPSrage:latest .'
            }
        }   

        
    }

    post {
        // the always stage will always be run
        always {
            echo "${env.PATH}"
            echo "Creating artifacts..."
            archiveArtifacts artifacts: "bin/x64/Release/net6.0/publish/*.*", followSymlinks: false
        }
    }
}
