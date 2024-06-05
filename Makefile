# ╭──────────────────────────────────────────────────────────╮
# │                  Termshark Docker Image                  │
# ╰──────────────────────────────────────────────────────────╯


SHELL       = /bin/zsh
.SHELLFLAGS = -o local_options -o errexit -o pipefail -o nounset -c


IMG         = "termshark"
BACKUP_TAG  = "prior"
LATEST_TAG  = "latest"
BAK_IMG     = $(shell printf '%s' "$(IMG):$(BACKUP_TAG)" )
LTS_IMG     = $(shell printf '%s' "$(IMG):$(LATEST_TAG)" )
IMG_ID      = $(shell docker images --format '{{ .ID }}' $(LTS_IMG))

ifneq ($(strip $(IMG_ID)),)
IMG_SHA256  = $(shell docker image inspect --format '{{ .Id }}' $(IMG_ID))
endif

ifneq ($(strip $(IMG_SHA256)),)
$(shell docker tag $(IMG_SHA256) $(BAK_IMG))
endif

.PHONY: all
all: build

.PHONY: showvars
showvars:
	@ :
	$(info $$IMG: [${IMG}])
	$(info $$BACKUP_TAG: [${BACKUP_TAG}])
	$(info $$LATEST_TAG: [${LATEST_TAG}])
	$(info $$BAK_IMG: [${BAK_IMG}])
	$(info $$LTS_IMG: [${LTS_IMG}])
	$(info $$IMG_ID: [${IMG_ID}])
	$(info $$IMG_SHA256: [${IMG_SHA256}])

.SILENT: build
build: Dockerfile entrypoint.sh termshark.toml
	docker buildx build \
		--progress=auto \
		--load \
		-t $(LTS_IMG) \
		-f $< \
		--cache-to=type=local,dest=./.cache \
		--cache-from=type=local,src=./.cache \
		.
