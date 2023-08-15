NAME = ppeclient
VERSION = $(shell stat --format "%Z" docs)

PPECLIENT_SWAGGER_URL = "https://us1.proofpointessentials.com/apidocs/apidocs/docs"

CODEGEN_CLI_VERSION = 3.0.41
CODEGEN_CLI_REPO = https://repo1.maven.org/maven2/io/swagger/codegen/v3/swagger-codegen-cli
CODEGEN_CLI = swagger-codegen-cli-${CODEGEN_CLI_VERSION}.jar
CODEGEN_CLI_URL = ${CODEGEN_CLI_REPO}/${CODEGEN_CLI_VERSION}/${CODEGEN_CLI}


# Must have Java installed and on PATH
client: ${CODEGEN_CLI} docs ${NAME}.config
	rm -rf $@
	java -jar ${CODEGEN_CLI} generate \
		--input-spec docs \
		--config ${NAME}.config \
		--lang python \
		--output $@

wheel: client
	cd client && python3 setup.py $(SETUP_ARGS) bdist_wheel

docs:
	# want to use timestamping, but it doesn't work
	wget --timestamping ${PPECLIENT_SWAGGER_URL}

${NAME}.config: config.in Makefile
	sed -e 's/VERSION/$(VERSION)/' \
	    -e 's/PACKAGE/$(NAME)/' config.in > ${NAME}.config

${CODEGEN_CLI}:
	curl ${CODEGEN_CLI_URL} > ${CODEGEN_CLI}

rhel-prereqs:
	dnf install -y python3-wheel python3-urllib3 python3-certifi python3-six python3-dateutil
	
python-prereqs:
	python3 -m pip install wheel urllib3 certifi six python-dateutil

install:
	echo '"make wheel" first'
	python3 -m pip install client/dist/${NAME}-${VERSION}-py3-none-any.whl


clean:
	rm -rf client

distclean: clean
	rm -f ${CODEGEN_CLI} ${NAME}.config docs

