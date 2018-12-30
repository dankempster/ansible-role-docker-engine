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

  agent any

  stages {

    stage ('Get latest code') {
      steps {
        checkout scm
      }
    }

    stage ('Setup Python virtual environment') {
      steps {
        sh '''
          virtualenv virtenv
          source virtenv/bin/activate
          pip install --upgrade ansible molecule docker jmespath
        '''
      }
    }

    stage ('Display versions') {
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

    stage ('Debian 9 test') {
      steps {
        sh '''
          source virtenv/bin/activate
          
          molecule -e molecule/debian9_env.yml test
        '''
      }
    }

    stage ('CentOS 7 test') {
      steps {
        sh '''
          source virtenv/bin/activate
          
          molecule -e molecule/centos7_env.yml test
        '''
      }
    }

  }

}
