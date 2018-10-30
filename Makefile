.PHONY: test clean

install:
	wget -O /tmp/protoc.zip https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip
	pushd /tmp
	unzip protoc.zip
	mkdir ~/bin
	sudo mv bin/protoc /usr/local/bin/protoc
	popd

test:
	mkdir -p /tmp/protoc-test-out
	for p in $(shell ls semaphore/*.proto); do protoc --go_out=/tmp/protoc-test-out $$p; done

clean:
	rm -fr *.pb.ex cpp
