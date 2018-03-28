.PHONY= dialyzer credo build test watch-test docker-reload docker docker-up docker-down

EX_FILES := $(shell find . -name *.ex)
TEST_FILES := $(shell find . -name *.exs)

deps: mix.exs mix.lock
	mix deps.get
	mix deps.compile
	touch $@

dialyzer:
	mix dialyzer

credo:
	mix credo

build: _build
_build: deps $(EX_FILES)
	mix compile
	touch $@


test: .test-done.mk
.test-done.mk: build $(TEST_FILES) $(EX_FILES)
	mix test
	touch $@

watch-test:
	ag -l | entr make test

test-localhost:
	mix test --include localhost

watch-test-localhost:
	ag -l | entr make test-localhost

docker: docker-up
docker-up:
	sudo docker-compose up -d

docker-down:
	sudo docker-compose down

docker-reload:
	sudo docker-compose down
	sudo docker-compose up -d
