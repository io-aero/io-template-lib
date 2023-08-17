Configuration
=============

settings.io_template_lib.toml
-----------------------------

This file controls the behaviour of the **IO-TEMPLATE-LIB** library.

The customisable entries are:

========== ======= =========================================
Parameter  Default Description
========== ======= =========================================
is_verbose true    Display progress messages for processing.
========== ======= =========================================

The configuration parameters can be set differently for the individual
environments (``dev``, ``prod`` and ``test``).

**Examples**:

::

   [default]
   is_verbose = true
   [dev]
   [prod]
   [test]
   is_verbose = true
   ...
