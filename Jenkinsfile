properties([pipelineTriggers([githubPush()])])

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
                 docker { image 'mcr.microsoft.com/dotnet/sdk:6.0-focal' }
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
                 docker { image 'mcr.microsoft.com/dotnet/sdk:6.0-focal' }
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
                 docker { 
                    image 'abubakarriaz/dotnet-sdk:6.0-focal-jre-11'
                 }
            }
            environment {
                    HOME = '/tmp'
                    DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
                    SCANNER_HOME = "$WORKSPACE$DOTNET_CLI_HOME/.dotnet/tools"
            }
            steps {
                echo "${env.PATH}"  
                //sh 'dotnet tool uninstall dotnet-sonarscanner --tool-path $SCANNER_HOME' 
                sh 'dotnet tool install dotnet-sonarscanner --version 5.7.1 --tool-path $SCANNER_HOME'
                sh 'dotnet tool list --tool-path $SCANNER_HOME' 
                sh 'export PATH="$PATH:$SCANNER_HOME"'
                sh '$SCANNER_HOME/dotnet-sonarscanner begin /k:"CAPSrage" /d:sonar.host.url="http://20.15.204.53:9000"  /d:sonar.login="sqp_aa175b0b08e2d771e72b3add648abd898c9781e6"'
                sh 'dotnet build'
                sh '$SCANNER_HOME/dotnet-sonarscanner end /d:sonar.login="sqp_aa175b0b08e2d771e72b3add648abd898c9781e6"'
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
