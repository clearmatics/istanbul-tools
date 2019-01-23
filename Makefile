ifndef TAG
$(error The TAG variable is missing)
endif

ACCOUNT := clearmatics
SERVICE := istanbul-tools
IMAGE := $(ACCOUNT)/$(SERVICE)

default: image

image: login build push logout

login:
	$(info Make: Login to Docker Hub)
	@echo $(DOCKER_PASS) | docker login -u $(DOCKER_USER) --password-stdin

build:
	$(info Make: Building "$(TAG)" tagged image)
	@docker build -t $(IMAGE):$(TAG) -f Dockerfile .

push:
	$(info Make: Pushing "$(TAG)" tagged image)
	@docker push $(IMAGE):$(TAG)

logout:
	$(info Make: Clear Docker Hub credentials)
	@docker logout
