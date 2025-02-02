pipeline {
    agent any 
    environment {
        SCANNER_HOME = tool "sonar-scanner"
    }
        stages {
            stage("clean workspace") {
                steps {
                    cleanWs()
                }
            }

            stage("git checkout") {
                steps {
                    git branch: "main" , url: "https://github.com/abhi-kr07/netflix-clone.git"
                }
            }

            stage("sonarqube") {
                steps {
                    withSonarQubeEnv("sonar-server") {
                        sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonaer.projectName=Netflix \
                        -Dsonar.projectKey=Netflix'''
                    }
                }  
            }

            // stage("OWASP check") {
            //     steps {
            //         dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'OWASP DP-Check'
            //         dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            //     }
            // }

            stage("trivy fs scan") {
                steps {
                    script {
                        try {
                            sh "trivy fs . > trivyfs.txt" 
                        }catch(Exception e){
                            input(message: "Are you sure to proceed?", ok: "Proceed")
                        }
                    }
                }
            }

            stage("docker build") {
                steps {
                    sh "docker build --build-arg API_KEY=56e9a888e0ba5c16898bb7d75d09d723 -t netflix-clone-app ."
                }
            }

            stage("TRIVY") {
                steps {
                    sh "trivy image netflix-clone-app > trivyimage.txt"
                    script{
                        input(message: "Are you sure to proceed?", ok: "Proceed")
                    }
                }
            }

            stage("docker push") {
                steps {
                    script {
                        withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker'){   
                        sh "docker tag netflix-clone-app abhishekk4/netflix-clone-app:v1 "
                        sh "docker push abhishekk4/netflix-clone-app:v1"
                        }
                    }
                }
            }
        }
    
}