#
# This Makefile build the nhs-piper image, tags it and pushes it to local docker repos
#
# make
#
APP    := bionic-mongo-python
PUBLIC_REPO := pajmd
NAME   := pjmd-ubuntu.com/${APP}
TAG    := $$(git describe --tag)
IMG    := ${NAME}:${TAG}
PUBLIC_IMG := ${PUBLIC_REPO}/${APP}:${TAG}
LATEST := ${NAME}:latest

all: push

build:
	@git fetch origin
	@docker build -t ${IMG} --build-arg GIT_VERSION=${TAG} .
	@docker tag ${IMG} ${LATEST}
	@docker tag ${IMG} ${PUBLIC_IMG}

push: build
	@docker push ${IMG}
