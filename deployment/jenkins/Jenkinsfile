pipeline {
	agent any
		stages {
			stage('Build') {
				steps {
					echo 'Building..'
					sh 'touch /tmp/BUILDING'
				}
			}
			stage('Test') {
				steps {
					echo 'Testing..'
					sh 'touch /tmp/TESTING'
				}
			}
			stage('Deploy') {
				steps {
					echo 'Deploying....'
					sh 'touch /tmp/DEPLOYING'
				}
			}
		}
}
