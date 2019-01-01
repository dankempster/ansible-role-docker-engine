#!/usr/bin/env groovy

pipeline {

  // agent {
  //   // Node setup : minimal centos7, plugged into Jenkins, and
  //   // git config --global http.sslVerify false
  //   // sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
  //   // sudo yum -y install python36u python36u-pip python36u-devel git curl gcc
  //   // git config --global http.sslVerify false
  //   // sudo curl -fsSL get.docker.com | bash
  //   label 'Molecule_Slave'
  // }

  agent none

  stages {

    stage ('Get latest code') {
      parallel {
        
        stage('Get latest code (x86_64)') {
          agent {
            label 'x86_64'
          }
          steps {
            checkout scm
          }
        }

        stage('Get latest code (R-Pi 3)') {
          agent {
            label 'raspberrypi_3'
          }
          steps {
            checkout scm
          }
        }

      }
    }

    stage ('Setup Python virtual environment') {
      parallel {

        stage('Setup Python VirtEnv (x86_64)') {
          agent {
            label 'x86_64'
          }
          steps {
            sh '''
              virtualenv virtenv
              source virtenv/bin/activate
              pip install --upgrade ansible molecule docker jmespath
            '''
          }          
        }

        stage('Setup Python VirtEnv (R-Pi 3)') {
          agent {
            label 'raspberrypi_3'
          }
          steps {
            sh '''
              virtualenv virtenv
              source virtenv/bin/activate
              pip install --upgrade ansible molecule docker jmespath
            '''
          }
        }

      }
    }

    stage ('Display versions') {
      parallel {

        stage('Display versions (x86_64)') {
          agent {
            label 'x86_64'
          }
          steps {
            sh '''
              source virtenv/bin/activate

              docker -v
              python -V
              echo $PATH
              ansible --version
              molecule --version
            '''
          }         
        }

        stage('Display versions (R-Pi 3)') {
          agent {
            label 'raspberrypi_3'
          }
          steps {
            sh '''
              source virtenv/bin/activate

              docker -v
              python -V
              echo $PATH
              ansible --version
              molecule --version
            '''
          }
        }

      }
    }

    stage ('Debian 9 test (x86_64)') {
      agent {
        label 'x86_64'
      }
      steps {
        sh '''
          source virtenv/bin/activate
          
          molecule -e molecule/debian9_env.yml test
        '''
      }
    }

    stage ('CentOS 7 test (x86_64)') {
      agent {
        label 'x86_64'
      }
      steps {
        sh '''
          source virtenv/bin/activate
          
          molecule -e molecule/centos7_env.yml test
        '''
      }
    }

    stage ('Raspbian stretch test (R-Pi 3)') {
      agent {
        label 'raspberrypi_3'
      }
      steps {
        sh '''
          source virtenv/bin/activate
          
          molecule -e molecule/raspbian_stretch_env.yml test
        '''
      }
    }

  }

}
