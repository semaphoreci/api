.PHONY: test clean

install:
	wget -O /tmp/protoc.zip https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip
	cd /tmp && unzip protoc.zip
	sudo mv /tmp/bin/protoc /usr/local/bin/protoc

test:
	mkdir -p /tmp/protoc-test-out
	for p in $(shell ls semaphore/*.proto); do protoc --cpp_out=/tmp/protoc-test-out $$p; done
