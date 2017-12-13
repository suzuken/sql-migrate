CROSS_IMAGE_NAME = docker-cli-cross$(IMAGE_TAG)
MOUNTS = -v "$(CURDIR)":/go/src/github.com/rubenv/sql-migrate
VERSION = $(shell cat VERSION)
ENVVARS = -e VERSION=$(VERSION) -e GITCOMMIT -e PLATFORM

.PHONY: build_cross_image
build_cross_image:
	docker build ${DOCKER_BUILD_ARGS} -t $(CROSS_IMAGE_NAME) -f Dockerfile .

# build the CLI for multiple architectures using a container
.PHONY: cross
cross: build_cross_image
	docker run --rm $(ENVVARS) $(MOUNTS) $(CROSS_IMAGE_NAME) make cross

.PHONY: binary-windows
binary-windows: build_cross_image
	docker run --rm $(ENVVARS) $(MOUNTS) $(CROSS_IMAGE_NAME) make $@

.PHONY: binary-osx
binary-osx: build_cross_image
	docker run --rm $(ENVVARS) $(MOUNTS) $(CROSS_IMAGE_NAME) make $@
