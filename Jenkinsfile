pipeline {
  agent any
   environment {
      docker_username = 'praqmasofus'
    }
  
  stages {
    stage('Clone down'){
      steps{
        stash excludes: '.git', name: 'code'
      }
    }
    stage('Parallel execution') {
      parallel {
        stage('Say Hello') {
          steps {
            sh 'echo "hello world"'
          }
        }

        stage('build app') {
          options {
            skipDefaultCheckout()
          }
          agent {
            docker {
              image 'gradle:jdk11'
            }

          }
          steps {
            unstash 'code'
            sh 'ci/build-app.sh'
            archiveArtifacts 'app/build/libs/'
            stash excludes: '.git', name: 'code'
          }
        }
        stage('test app') {
          options {
            skipDefaultCheckout()
          }
          agent {
            docker {
              image 'gradle:jdk11'
            }

          }
          steps {
            unstash 'code'
            sh 'ci/unit-test-app.sh'
            
            junit 'app/build/test-results/test/TEST-*.xml'
          }
        }

      }
        }
        stage('build docker app') {
          options {
            skipDefaultCheckout()
          }
steps {
      unstash 'code' //unstash the repository code
      sh 'ci/build-docker.sh'
}
    }
        stage('push app') {
          when{
            branch 'master'
          }
          options {
            skipDefaultCheckout()
          }
          environment {
      DOCKERCREDS = credentials('docker_login') //use the credentials just created in this stage
}
steps {
      sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin' //login to docker hub with the credentials above
      sh 'ci/push-docker.sh'
}
    }
      stage('component test') {
      options {
        skipDefaultCheckout(true)
      }
      steps {
        unstash 'code'
        sh 'ci/component-test.sh'
      }
    }

  }
}