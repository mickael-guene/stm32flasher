#!/bin/bash -x

#variable that change build result
DOCKER_BRANCH=docker/${TRAVIS_BRANCH}

#get script location
SCRIPTDIR=`dirname $0`
SCRIPTDIR=`(cd $SCRIPTDIR ; pwd)`
