ALL_TARGETS = ubuntu cpp cpp-conan
PUSH_ALL_TARGETS = push-ubuntu push-cpp push-cpp-conan

.phony: all $(ALL_TARGETS) push-all $(PUSH_ALL_TARGETS)

all: $(ALL_TARGETS)

ubuntu: ubuntu/Dockerfile
	docker build -t trainiteu/ubuntu:latest ubuntu

cpp: ubuntu cpp/Dockerfile
	docker build -t trainiteu/cpp:latest cpp

cpp-conan: cpp cpp-conan/Dockerfile
	docker build -t trainiteu/cpp-conan:latest --no-cache cpp-conan

irrlicht: vscode-cpp-conan irrlicht/Dockerfile
	docker build -t trainiteu/irrlicht:latest --build-arg --no-cache irrlicht

push-all: $(PUSH_ALL_TARGETS)

push-ubuntu: ubuntu
	docker push trainiteu/ubuntu:latest

push-vscode-base: push-base vscode-base
	docker push trainiteu/vscode-base:latest

push-vscode-cpp: push-vscode-base vscode-cpp
	docker push trainiteu/vscode-cpp:latest

push-vscode-cpp-conan: push-vscode-cpp vscode-cpp-conan
	docker push trainiteu/vscode-cpp-conan:latest

push-irrlicht: push-vscode-cpp-conan irrlicht
	docker push trainiteu/irrlicht:latest
