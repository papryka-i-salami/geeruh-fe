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

                sh "twine upload --repository-url ${env.TWINE_REPOSITORY_URL} --username ${env.NEXUS_USR} --password ${env.NEXUS_PSW} build/web/*"
            }
        }
    }
}
