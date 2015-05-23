# standard info
REGISTRY = registry.giantswarm.io
PROJECT = helloworld-formation
USERNAME :=  $(shell swarm user)
ORG := $(shell swarm env | cut -d"/" -f1)
ENV := $(shell swarm env | cut -d"/" -f2)
DOMAIN = hello-$(ORG).gigantic.io

# local info
MY_IP = $(shell boot2docker ip)

build:
	docker build -t $(REGISTRY)/$(ORG)/$(PROJECT) .

run: build
	@echo "#######################################################################"
	@echo "Your app $(PROJECT) is running at http://$(MY_IP):8000"
	@echo "#######################################################################"

	docker run --rm -ti \
		-p 8000:8000 \
		$(REGISTRY)/$(ORG)/$(PROJECT)
	
push: build
	docker push $(REGISTRY)/$(ORG)/$(PROJECT)

pull:
	docker pull $(REGISTRY)/$(ORG)/$(PROJECT)

up: push
	swarm up \
		--var=domain=$(DOMAIN) \
		--var=org=$(ORG) \
		--var=username=$(USERNAME) \

	@echo "###############################################################################"
	@echo "Your app '$(PROJECT)'' is running at http://$(DOMAIN)"
	@echo "###############################################################################"
    
