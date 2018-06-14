.PHONY: lint build test

IMAGE="us.gcr.io/semaphore2-prod/secrets-api"
IMAGE_TAG=$(shell git rev-parse --short HEAD)

pb.gen:
	protoc --elixir_out=plugins=grpc:lib/protos/ --plugin=`echo ~/.mix/escripts/protoc-gen-elixir` secrets.proto

lint:
	docker run --rm -v $(PWD):/home/credo/code:ro -t renderedtext/credo

build:
	-docker pull $(IMAGE):latest
	docker build --cache-from $(IMAGE):latest -t $(IMAGE) .

test:
	docker run --rm -e MIX_ENV=test -t $(IMAGE):latest mix test

push:
	docker tag $(IMAGE):latest $(IMAGE):$(IMAGE_TAG)
	docker push $(IMAGE):$(IMAGE_TAG)
	docker push $(IMAGE):latest

configure.gcloud:
	gcloud auth activate-service-account deploy-from-semaphore@semaphore2-prod.iam.gserviceaccount.com --key-file ~/semaphore2-prod-2fd29ae99af8.json
	gcloud config set project semaphore2-prod
	gcloud container clusters get-credentials prod --zone us-east4
	gcloud --quiet auth configure-docker
