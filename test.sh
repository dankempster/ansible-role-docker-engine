#!/bin/bash

molecule -e molecule/centos7_env.yml test && \
molecule -e molecule/debian9_env.yml test
