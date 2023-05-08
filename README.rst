===========================================================================
ppeclient -- a Python client for the Proofpoint Essentials Interface API v1
===========================================================================

`Proofpoint Essentials Interface API v1`_ describes a REST interface to manage
`Proofpoint Essentials`_ email endpoints.  Proofpoint also provides an OpenAPI_
3.0.0 description of the interface.

ppeclient is Python client that is generated from the OpenAPI description by
a prebuilt `swagger-codegen-cli v3`_.  Which is part of the `Swagger Open Source`_
project.


--------
Building
--------

To build ``ppeclient``, a UNIX-style build enviroment is needed along with a
Java application runner (called ``java``).  Then run:

        ``make client``

That will create the ``client`` subdirectory with all of Python source code.  Next,
switch to the ``client`` subdirectory and run:

        ``python setup.py install``

To install the ``ppeclient`` package.

-----------
Example Use
-----------

.. code: python

        from ppeclient import Configuration, ApiClient, UsersApi

        USERNAME = 'user@example.com'
        PASSWORD = 'password'
        DOMAIN = 'example.com'

        config = Configuration()
        # Choose appropriate endpoint for your domain
        config.host = "https://us1.proofpointessentials.com/api/v1"
        client = ApiClient(config)
        api = UsersApi(client)

        print(api.get_user(USERNAME, PASSWORD, DOMAIN, 'user2@example.com'))


----------
References
----------

.. _OpenAPI: https://www.openapis.org/
.. _Swagger Open Source: https://swagger.io/tools/open-source/
.. _swagger-codegen-cli v3: https://mvnrepository.com/artifact/io.swagger.codegen.v3/swagger-codegen-cli
.. _Proofpoint Essentials Interface API v1: https://us1.proofpointessentials.com/apidocs/documentation
.. _Proofpoint Essentials: https://help.proofpoint.com/Proofpoint_Essentials/Email_Security/User_Topics/010_aboutproofpointessentials
