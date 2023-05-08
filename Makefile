NAME = ppeclient
VERSION = 1.0

PPECLIENT_SWAGGER_URL = "https://us1.proofpointessentials.com/apidocs/apidocs/docs"

CODEGEN_CLI_VERSION = 3.0.41
CODEGEN_CLI_REPO = https://repo1.maven.org/maven2/io/swagger/codegen/v3/swagger-codegen-cli
CODEGEN_CLI = swagger-codegen-cli-${CODEGEN_CLI_VERSION}.jar
CODEGEN_CLI_URL = ${CODEGEN_CLI_REPO}/${CODEGEN_CLI_VERSION}/${CODEGEN_CLI}


# Must have Java installed and on PATH
client: ${CODEGEN_CLI} ${NAME}.json ${NAME}.config
	rm -rf $@
	java -jar ${CODEGEN_CLI} generate \
		--input-spec ${NAME}.json \
		--config ${NAME}.config \
		--lang python \
		--output $@

wheel: client
	cd client && python3 setup.py $(SETUP_ARGS) bdist_wheel

${NAME}.json:
	curl ${PPECLIENT_SWAGGER_URL} > ${NAME}.json
	# "int" is not an OpenAPI data type, but "integer" is
	sed -i s/\"int\"/\"integer\"/ ${NAME}.json

${NAME}.config: config.in Makefile
	sed -e 's/VERSION/$(VERSION)/' \
	    -e 's/PACKAGE/$(NAME)/' config.in > ${NAME}.config

${CODEGEN_CLI}:
	curl ${CODEGEN_CLI_URL} > ${CODEGEN_CLI}

clean:
	rm -rf client

distclean: clean
	rm -f ${CODEGEN_CLI} ${NAME}.config ${NAME}.json

