Configuration
=============

.settings.io_aero.toml
----------------------

This file controls the secrets of the **IO-TEMPLATE-LIB** library.
This file is not included in the repository.

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
    postgres_password = "..."
    postgres_password_admin = "..."

settings.io_aero.toml
---------------------

This file controls the behaviour of the **IO-TEMPLATE-LIB** library.

The customisable entries are:

======================== ============================== =========================================
Parameter                Default                        Description
======================== ============================== =========================================
check_value              default                        ``default`` for productive operation,
                                                        ``test`` for test operation
is_verbose               true                           Display progress messages for processing
======================== ============================== =========================================

The configuration parameters can be set differently for the individual
environments (``default`` and ``test``).

**Examples**:

.. code-block::

    [default]
    check_value = "default"
    is_verbose = true

    [test]
    check_value = "test"
