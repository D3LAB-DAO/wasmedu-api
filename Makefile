.PHONY: rust-build clippy clean rust-init


CONTAINER_NAME ?= "cosmonaut"
OWNER =
PROJ =
LEC =
TARGET_PATH = "cosm/$(OWNER)/$(PROJ)/$(LEC)"

cosm-init:
	@if docker ps -a --format "{{.Names}}" | grep "^$(CONTAINER_NAME)$$" > /dev/null; \
	then docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/init.sh --path $(TARGET_PATH)"; \
	else docker run -itd --name $(CONTAINER_NAME) -v $(CURDIR)/cargo-projects:/workspace cosmo-rust:1.0 /bin/bash > /dev/null \
	&& docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/init.sh --path $(TARGET_PATH)"; fi

cosm-build:
	@if docker ps -a --format "{{.Names}}" | grep "^$(CONTAINER_NAME)$$" > /dev/null; \
	then docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/build.sh --path $(TARGET_PATH)"; \
	else docker run -itd --name $(CONTAINER_NAME) -v $(CURDIR)/cargo-projects:/workspace cosmo-rust:1.0 /bin/bash > /dev/null \
	&& docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/build.sh --path=$(TARGET_PATH)"; fi

cosm-clean:
	@if docker ps -a --format "{{.Names}}" | grep "^$(CONTAINER_NAME)$$" > /dev/null; \
	then docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/clean.sh --path $(TARGET_PATH)"; \
	else docker run -itd --name $(CONTAINER_NAME) -v $(CURDIR)/cargo-projects:/workspace cosmo-rust:1.0 /bin/bash > /dev/null \
	&& docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/clean.sh --path=$(TARGET_PATH)"; fi

clippy:
	@if docker ps -a --format "{{.Names}}" | grep "^$(CONTAINER_NAME)$$" > /dev/null; \
	then docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/build.sh --path $(TARGET_PATH) --check"; \
	else docker run -itd --name $(CONTAINER_NAME) -v $(CURDIR)/cargo-projects:/workspace cosmo-rust:1.0 /bin/bash > /dev/null \
	 && docker exec -w /workspace $(CONTAINER_NAME) bash -c "./scripts/build.sh --path $(TARGET_PATH) --check"; fi

TARGET_RM = $(shell docker ps -a --format "{{.Names}}"|grep "^$(CONTAINER_NAME)$$")
clean:
	@if docker ps -a --format "{{.Names}}" | grep "^$(CONTAINER_NAME)$$" > /dev/null; \
	then docker stop $(TARGET_RM) > /dev/null && docker rm $(TARGET_RM); \
	else echo "** There is no target container to remove **"; fi
