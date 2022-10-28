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
        /* checkout repo */
        stage('Checkout SCM') {
            steps {
                checkout([
                 $class: 'GitSCM',
                 branches: [[name: 'main']],
                 userRemoteConfigs: [[
                    url: 'https://github.com/mabubakarriaz/CAPSrage.git',
                    credentialsId: '',
                 ]]
                ])
            }
        }
        stage('Source') {
            steps {
                sh 'dotnet --version'
                sh 'git --version'
                git branch: 'main',
                    url: 'https://github.com/mabubakarriaz/CAPSrage.git'
            }
        }
        
        stage('Requirements') {
            steps {
                echo 'Installing requirements...'
            }
        }
        stage('Build') {
          environment {
                    HOME = '/tmp'
                    DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
                    } 
            steps {
                sh "dotnet build 'CAPSrage.csproj' -c Release -o ${env.WORKSPACE}/app/build"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('artifacts') {
            steps {
                echo "Hi there its done"
                archiveArtifacts artifacts: "bin/Release/net6.0/publish/*.*", followSymlinks: false
                }
            }
        stage('Report') {
            steps {
                echo 'Reporting....'
            }
        }
        
        }
    // the post section is a special collection of stages
    // that are run after all other stages have completed
    post {

        // the always stage will always be run
        always {

            // the always stage can contain build steps like other stages
            // a "steps{...}" section is not needed.
            echo "This step will run after all other steps have finished.  It will always run, even in the status of the build is not SUCCESS"
        }
    }
}
