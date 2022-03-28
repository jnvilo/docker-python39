REGISTRY_URL=jnvilo
PROJECT=library
IMAGE_NAME=python39
TAG=3.9.6

.PHONY: build  all build_image pull tag clean 

all:  build tag push

build_image:
	docker build -t "${IMAGE_NAME}:latest" -f "Dockerfile" .

pull:   
	docker  pull ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest 

tag: build
	docker tag ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${TAG} ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest


build: build_image 
	docker tag "${IMAGE_NAME}:latest"  ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest
	docker tag "${IMAGE_NAME}:latest"  ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${TAG}
 
push:  build
	docker push ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest
	docker push ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${TAG}

shell: build 
	docker run \
		--rm -it ${IMAGE_NAME}:latest /bin/bash 

clean:
	sudo rm -rf var

