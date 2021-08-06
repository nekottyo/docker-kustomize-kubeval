NAME = docker-kustomize-kubeval

test: test.v4 test.v3

build.v4:
	docker build --target kustomizev4 -t ${NAME}:kustomizev4 .

build.v3:
	docker build --target kustomizev3 -t ${NAME}:kustomizev3 .


test.v4: build.v4
	container-structure-test test -i ${NAME}:kustomizev4 -c tests/config-kustomizev4.yaml

test.v3: build.v3
	container-structure-test test -i ${NAME}:kustomizev3 -c tests/config-kustomizev3.yaml
