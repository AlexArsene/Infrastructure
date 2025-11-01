pipeline {
  agent any
  stages {
    stage('Build') {
      steps { sh 'docker build -t frontend-app:v001 .' }
    }
    stage('Test') {
      steps { sh 'docker run --rm -d -p 80:80 --name frontend-test frontend-app:v001 && sleep 10 && curl --fail http://localhost:80 || exit 1' }
    }
    stage('Deploy Staging') {
      steps { sh 'ssh deploy@192.168.0.242 "docker pull frontend-app:v001 && docker stop frontend || true && docker rm frontend || true && docker run -d --name frontend -p 80:80 frontend-app:v001"' }
    }
    stage('Deploy Production') {
      when { branch 'production' }
      steps { sh 'ssh deploy@192.168.0.79 "docker pull frontend-app:v001 && docker stop frontend || true && docker rm frontend || true && docker run -d --name frontend -p 80:80 frontend-app:v001"' }
    }
  }
}
