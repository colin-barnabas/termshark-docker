.PHONY: all
all: build

.SILENT: build
build: Dockerfile entrypoint.sh termshark.toml
	docker buildx build \
		--progress=auto \
		--load \
		-t termshark:latest \
		-f $< \
		--cache-to=type=local,dest=./.cache \
		--cache-from=type=local,src=./.cache \
		.
