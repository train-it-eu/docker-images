ALL_TARGETS = gitpod-base gitpod-cpp vscode-base vscode-cpp vscode-cpp-conan
PUSH_ALL_TARGETS = push-gitpod-base push-gitpod-cpp push-vscode-base push-vscode-cpp push-vscode-cpp-conan

.phony: all $(ALL_TARGETS) push-all $(PUSH_ALL_TARGETS)

all: $(ALL_TARGETS)

gitpod-base: gitpod-base/Dockerfile
	docker build -t trainiteu/gitpod-base:latest gitpod-base

gitpod-cpp: gitpod-base cpp/Dockerfile
	docker build -t trainiteu/gitpod-cpp:latest --build-arg BASE_IMAGE=gitpod cpp

vscode-base: vscode-base/Dockerfile
	docker build -t trainiteu/vscode-base:latest vscode-base

vscode-cpp: vscode-base cpp/Dockerfile
	docker build -t trainiteu/vscode-cpp:latest --build-arg BASE_IMAGE=vscode cpp

vscode-cpp-conan: vscode-cpp cpp-conan/Dockerfile
	docker build -t trainiteu/vscode-cpp-conan:latest --build-arg BASE_IMAGE=vscode --no-cache cpp-conan

irrlicht: vscode-cpp-conan irrlicht/Dockerfile
	docker build -t trainiteu/irrlicht:latest --build-arg --no-cache irrlicht

push-all: $(PUSH_ALL_TARGETS)

push-gitpod-base: gitpod-base
	docker push trainiteu/gitpod-base:latest

push-gitpod-cpp: push-gitpod-base gitpod-cpp
	docker push trainiteu/gitpod-cpp:latest

push-vscode-base: vscode-base
	docker push trainiteu/vscode-base:latest

push-vscode-cpp: push-vscode-base vscode-cpp
	docker push trainiteu/vscode-cpp:latest

push-vscode-cpp-conan: push-vscode-cpp vscode-cpp-conan
	docker push trainiteu/vscode-cpp-conan:latest

push-irrlicht: push-vscode-cpp-conan irrlicht
	docker push trainiteu/irrlicht:latest
