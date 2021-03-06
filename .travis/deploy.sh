#!/bin/bash -x

#variable that change build result
DOCKER_BRANCH=docker/${TRAVIS_BRANCH}
GIT_USER_NAME="Mickael Guene"
GIT_USER_EMAIL=mickael.guene@st.com

#get script location
SCRIPTDIR=`dirname $0`
SCRIPTDIR=`(cd $SCRIPTDIR ; pwd)`

#create working directory
WDIR=`mktemp -d` && trap "rm -Rf $WDIR" EXIT

#add deploy key
cd ${SCRIPTDIR}
set +x
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key
rm deploy_key
set -x

#switch to tmp dir and setup new git repo
cd ${WDIR}
git init
git config user.name ${GIT_USER_NAME}
git config user.email ${GIT_USER_EMAIL}
git remote add origin https://github.com/"$TRAVIS_REPO_SLUG"

#pull last commit
git pull --depth=1 origin ${DOCKER_BRANCH}
git checkout -b ${DOCKER_BRANCH}

#create commit
cat << EOF > Dockerfile
FROM scratch
MAINTAINER ${GIT_USER_NAME} <${GIT_USER_EMAIL}>

ADD rootfs.tar.xz /

CMD ["/usr/bin/openocd", "-v"]
EOF
cp ${SCRIPTDIR}/rootfs.tar.xz .
git add .
git commit -m "Trig by original commit $TRAVIS_COMMIT"

#push commit
git push git@github.com:"$TRAVIS_REPO_SLUG" ${DOCKER_BRANCH}
