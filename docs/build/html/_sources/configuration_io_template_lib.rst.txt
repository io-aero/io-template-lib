=============================
Configuration IO-TEMPLATE-LIB
=============================

.act_secrets
------------

This file controls the secrets of the ``make action`` functionality.
This file is not included in the repository.
The file ``.act_secrets_template`` can be used as a template.

The customisable entries are:

======================= ======================================
Parameter               Description
======================= ======================================
AWS_ACCESS_KEY_ID       AWS access key
AWS_SECRET_ACCESS_KEY   AWS secret access key
GLOBAL_USER_EMAIL       The global email address for GitHub
======================= ======================================

**Examples**:

.. code-block::

    AWS_ACCESS_KEY_ID=<tbd>>
    AWS_SECRET_ACCESS_KEY=<tbd>>
    GLOBAL_USER_EMAIL=a@b.com

.settings.io_aero.toml
----------------------

This file controls the secrets of the **IO-TEMPLATE-LIB** library.
This file is not included in the repository.
The file ``.settings.io_aero_template.toml`` can be used as a template.

The customisable entries are:

======================= ======================================
Parameter               Description
======================= ======================================
postgres_password       Password of the database user
postgres_password_admin Password of the database administrator
======================= ======================================

The secrets can be set differently for the individual
environments (``default`` and ``test``).

**Examples**:

.. code-block::

    [default]

    [test]
    postgres_password = "postgres_password"
    postgres_password_admin = "postgres_password_admin"

settings.io_aero.toml
---------------------

This file controls the behaviour of the **IO-TEMPLATE-LIB** library.

The customisable entries are:

======================== =========================================
Parameter                Description
======================== =========================================
check_value              ``default`` for productive operation,
                         ``test`` for test operation
is_verbose               Display progress messages for processing
======================== =========================================

The configuration parameters can be set differently for the individual
environments (``default`` and ``test``).

**Examples**:

.. code-block::

    [default]
    check_value = "default"
    is_verbose = true

    [test]
    check_value = "test"
