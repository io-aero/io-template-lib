First Steps
===========

To get started, you'll first need to clone the repository, which contains essential scripts for various operating systems.
After cloning, you will use these scripts to install the necessary foundational software.
Finally, you will complete the repository-specific installation to set up your environment correctly.
Detailed instructions for each of these steps are provided below.

Cloning the Repository
----------------------

Start by cloning the `io-template-lib` repository. This repository contains essential scripts and configurations needed for the project.

.. code-block:: bash

    git clone https://github.com/io-aero/io-template-lib

Install Foundational Software
-----------------------------

Once you have successfully cloned the repository, navigate to the cloned directory.

To set up the project on an Ubuntu system, the following steps should be performed in a terminal window within the repository directory:

a. Grant Execute Permission to Installation Scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Provide execute permissions to the installation scripts:

.. code-block:: bash

    chmod +x scripts/*.sh

b. Install Python and pip
~~~~~~~~~~~~~~~~~~~~~~~~~

Run the script to install Python and pip:

.. code-block:: bash

    ./scripts/run_install_python.sh

c. Install AWS Command Line Interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Execute the script to install the AWS CLI:

.. code-block:: bash

    ./scripts/run_install_aws_cli.sh

d. Install Miniconda and the Correct Python Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the following script to install Miniconda and set the right Python version:

.. code-block:: bash

    ./scripts/run_install_miniconda.sh

e. Install Docker Desktop
~~~~~~~~~~~~~~~~~~~~~~~~~

This step is not required for WSL (Windows Subsystem for Linux) if Docker Desktop is installed in Windows and is configured for WSL 2 based engine.

To install Docker Desktop, run:

.. code-block:: bash

    ./scripts/run_install_docker.sh

f. Install Terraform
~~~~~~~~~~~~~~~~~~~~

To install Terraform, run:

.. code-block:: bash

    ./scripts/run_install_terraform.sh

g. Optionally Install DBeaver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If needed, install DBeaver using the following script:

.. code-block:: bash

    ./scripts/run_install_dbeaver.sh

h. Close the Terminal Window
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once all installations are complete, close the terminal window.

Repository-Specific Installation
--------------------------------

After installing the basic software, you need to perform installation steps specific to the `io-template-lib` repository.
This involves setting up project-specific dependencies and environment configurations.
To perform the repository-specific installation, the following steps should be performed in a command prompt or a terminal window (depending on the operating system) in the repository directory.

Setting Up the Python Environment
---------------------------------

To begin, you'll need to set up the Python environment using Miniconda, which is already pre-installed.
You can use the provided Makefile for managing the environment.

a. For **production** use, run the following command:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   make conda-prod

b. For **software development**, use the following command:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   make conda-dev

These commands will create and configure a virtual environment for your Python project, ensuring a clean and reproducible development or production environment.
The virtual environment is automatically activated by the Makefile, so you don't need to activate it manually.

Minor Adjustments for GDAL
..........................

The installation of the GDAL library requires the following minor operating system-specific adjustments:

In Ubuntu, the GDAL library must be installed as follows:

.. code-block:: bash

   sudo apt-get install gdal-bin libgdal-dev

System Testing with Unit Tests
------------------------------

If you have previously executed `make conda-dev`, you can now perform a system test to verify the installation using `make test`.
Follow these steps:

a. Run the System Test:
~~~~~~~~~~~~~~~~~~~~~~~

Execute the system test using the following command:

.. code-block:: bash

   make tests

This command will initiate the system tests using the previously installed components to verify the correctness of your installation.

b. Review the Test Results:
~~~~~~~~~~~~~~~~~~~~~~~~~~~

After the tests are completed, review the test results in the terminal. Ensure that all tests pass without errors.

If any tests fail, review the error messages to identify and resolve any issues with your installation.
