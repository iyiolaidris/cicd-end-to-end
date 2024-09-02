pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: 'github-pat', 
                url: 'https://github.com/iyiolaidris/cicd-end-to-end.git',
                branch: 'main'
           }
        }

        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    docker build -t iyiolaidris/cicd-e2e:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps {
                script{
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        sh '''
                        echo 'Push to Repo'
                        docker push iyiolaidris/cicd-e2e:${BUILD_NUMBER}
                        '''
                    }     
                }
            }
        }
        
        stage('Checkout K8S manifest SCM'){
            steps {
                git credentialsId: 'github-pat', 
                url: 'https://github.com/iyiolaidris/repo.git',
                branch: 'main'
            }
        }
        
        stage('Update K8S manifest & push to Repo'){
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: 'github-pat', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        cat deploy.yaml
                        sed -i '' "s/32/${BUILD_NUMBER}/g" deploy.yaml
                        cat deploy.yaml
                        git add deploy.yaml
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push https://github.com/iyiolaidris/repo.git HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
