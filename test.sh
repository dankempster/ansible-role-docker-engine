#!/bin/bash

molecule -e molecule/debian_vars.txt test
molecule -e molecule/centos_vars.txt test
