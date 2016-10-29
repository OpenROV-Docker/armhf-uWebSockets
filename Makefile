PACKAGE_NAME=uWebSockets
VERSION=1.0.0

DOCKER_CONTAINER=openrovdocker/armhf-uwebsockets
DOCKER_TAG=latest

GIT_REPO=https://github.com/OpenROV-forks/uWebSockets
GIT_BRANCH=enhancement/staticbuild
GIT_TAG=b3b15a1

docker:
	docker build -t ${DOCKER_CONTAINER} .

build:
	docker run \
	-e PACKAGE_NAME='${PACKAGE_NAME}' \
	-e GIT_REPO='${GIT_REPO}' \
	-e GIT_BRANCH='${GIT_BRANCH}' \
	-e GIT_TAG='${GIT_TAG}' \
	-v ${PWD}:/${PACKAGE_NAME} -w /${PACKAGE_NAME} ${DOCKER_CONTAINER}:${DOCKER_TAG} ./build.sh

package:
	docker run \
	-e PACKAGE_NAME='${PACKAGE_NAME}' \
	-e VERSION='${VERSION}' \
	-e GIT_TAG='${GIT_TAG}' \
	-e DOCKER_TAG='${DOCKER_TAG}' \
	-v ${PWD}:/${PACKAGE_NAME} -w /${PACKAGE_NAME} ${DOCKER_CONTAINER}:${DOCKER_TAG} ./package.sh

publish:
	docker run \
	-e PACKAGE_NAME='${PACKAGE_NAME}' \
	-e DEB_CODENAME='${DEB_CODENAME}' \
	-e s3Secret='${s3Secret}' \
	-e s3Key='${s3Key}' \
	-v ${PWD}:/${PACKAGE_NAME} -w /${PACKAGE_NAME} ${DOCKER_CONTAINER}:${DOCKER_TAG} ./publish.sh

clean:
	docker run \
	-v ${PWD}:/${PACKAGE_NAME} -w /${PACKAGE_NAME} ${DOCKER_CONTAINER}:${DOCKER_TAG} ./clean.sh
	docker rm $(docker ps -a -q) || true