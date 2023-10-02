CHALLENGE_NAME = 4d
CHALLENGE_PORT = 12345
CHALLENGE_PORT_EXTERNAL = 8888
CHALLENGE_DIR = /home/4d

.PHONY: all build compose clean

all: build compose

build:
	DOCKER_BUILDKIT=1 docker build -t $(CHALLENGE_NAME):latest .

compose:
	echo 'version: "3.9"\n' > docker-compose.yml
	echo 'services:' >> docker-compose.yml
	echo '  $(CHALLENGE_NAME):' >> docker-compose.yml
	echo '    image: $(CHALLENGE_NAME):latest' >> docker-compose.yml
	echo '    ports:' >> docker-compose.yml
	echo '      - "$(CHALLENGE_PORT_EXTERNAL):$(CHALLENGE_PORT)"' >> docker-compose.yml

clean:
	$(RM) docker-compose.yml
	make clean -C src
