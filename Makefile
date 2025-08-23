ALL_TARGETS = ubuntu cpp cpp-conan mp-units
PUSH_ALL_TARGETS = push-ubuntu push-cpp push-cpp-conan push-mp-units


.phony: all $(ALL_TARGETS) push-all $(PUSH_ALL_TARGETS)

all: $(ALL_TARGETS)

ubuntu: ubuntu/Dockerfile
	docker build -t trainiteu/ubuntu:latest ubuntu

cpp: ubuntu cpp/Dockerfile
	docker build -t trainiteu/cpp:latest cpp

cpp-conan: cpp cpp-conan/Dockerfile
	docker build -t trainiteu/cpp-conan:latest --no-cache cpp-conan

mp-units: cpp-conan mp-units/Dockerfile
	docker build -t trainiteu/mp-units:latest mp-units

irrlicht: cpp-conan irrlicht/Dockerfile
	docker build -t trainiteu/irrlicht:latest irrlicht

push-all: $(PUSH_ALL_TARGETS)

push-ubuntu: ubuntu
	docker push trainiteu/ubuntu:latest

push-cpp: push-ubuntu cpp
	docker push trainiteu/cpp:latest

push-cpp-conan: push-cpp cpp-conan
	docker push trainiteu/cpp-conan:latest

push-mp-units: push-cpp-conan mp-units
	docker push trainiteu/mp-units:latest

push-irrlicht: push-cpp-conan irrlicht
	docker push trainiteu/irrlicht:latest
