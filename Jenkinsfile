pipeline {
    enviroment {
	IMAGE = "jairodh/django_jenkins"
	LOGIN = "USER_DOCKERHUB"
    }
    agent any
    stages {
        stage ('Build And Test Django') { 
            agent { 
                docker { image 'python:3'
                args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'master',url:'https://github.com/JairoDH/django_tutorial.git'
                    }
                }
                stage('Install') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'python3 manage.py test'
                    }
                } 
            }
        }
        stage('Build Image') {
            agent any
            stages {	
                stage('Build') {
                    steps {
                        script {
                            App = docker.build "$IMAGE:latest"
                        }
                    }
                }
		stage('UP') {
		    steps {
			script {
			   docker.withRegistry( '', LOGIN ) {
				App.push()
                           }
                        }
                    }
                }             
                stage('Remove image') {
                    steps {
                        sh "docker rmi $IMAGE:latest"
                    }
                }
            }
        }
        stage('Deploy') {
            agent any
            steps {
		sshagent(credentials: ['VPS_SSH'] {
                        sh "ssh -o StrictHostKeyChecking=no jairo@fekir.touristmap.es wget https://raw.githubusercontent.com/JairoDH/django_tutorial/master/docker-compose.yaml -O docker-compose.yaml"
                        sh "ssh -o StrictHostKeyChecking=no jairo@fekir.touristmap.es docker compose up -d --force-recreate"
                }
            }
        }
    }
    post {
        always {
            mail to: 'jairo@jairo.docker-jenkins.org',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
