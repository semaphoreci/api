swagger:
	$(MAKE) g YAML=semaphore/dashboards.v1alpha.yml PROTO=semaphore/dashboards.v1alpha.proto
	$(MAKE) g YAML=semaphore/secrets.v1beta.yml PROTO=semaphore/secrets.v1beta.proto

g:
	protoc -I/usr/local/include -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		--swagger_out=logtostderr=true,grpc_api_configuration="$(YAML)":. \
		$(PROTO)
