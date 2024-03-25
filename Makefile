BUILD_DIR := $(shell pwd)/_build

DRY_RUN ?= true
ENVIRONMENT ?= ptr
EXTRA_PACKER_ARGS ?=

.PHONY: init
init:
	packer init .
	ansible-galaxy install datadog.datadog

.PHONY: bake-ami
bake-ami:
	packer build \
		-var=build_directory=${BUILD_DIR} \
		-var=enable_dryrun=${DRY_RUN} \
		-var-file=${ENVIRONMENT}.pkrvars.hcl \
		${EXTRA_PACKER_ARGS} \
		.
