pipeline {

    environment {
        NEXUS = credentials('nexus-user-credentials')
        
        TWINE_REPOSITORY_URL="http://20.4.227.77:8081/repository/geeruh-fe/"
    }

    agent {
        docker {
            image 'flutter-pis'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh 'flutter pub get'
                sh 'flutter pub run build_runner build --delete-conflicting-outputs'
                sh 'flutter build web --release'
            }
        }

        // stage('Unit tests') {
        //     steps {
        //         sh 'flutter test test/widget_test.dart'
        //     }
        // }

        // stage('Automatic tests') {
        //     steps {
        //         sh 'flutter config --enable-linux-desktop'
        //         sh 'xvfb-run flutter test integration_test/automatic_test.dart -d Linux'
        //     }
        // }
        stage('Publish') {
             steps {
                sh 'zip -r build.zip build/web'
                sh "curl -v -u ${env.NEXUS_USR}:${env.NEXUS_PSW} --upload-file ./build.zip http://20.4.227.77:8081/repository/PIS-geeruh/"
            }
        }
        
        // stage('Launch') {
        //     when {
        //         expression { env.JOB_NAME == 'Deployment' }
        //     }
        //     steps {
        //         sh "apt-get update && apt-get install ssh -y"
        //         script{
        //             remote = [:]
        //             remote.name = "name"
        //             remote.host = "20.86.0.224"
        //             remote.allowAnyHosts = true
        //             remote.failOnError = true
        //             remote.user = env.LAUNCH_USR
        //             remote.password = env.LAUNCH_PSW
        //             sshCommand remote: remote, command: "nohup ./launch.sh &> /dev/null"
        //         }
        //     }
        // }
    }
}
