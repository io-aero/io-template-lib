Installation
============

Python
------

The project repository contains a ``scripts`` directory that includes operating system-specific installation scripts for Python, ensuring a smooth setup across various environments.

- **Ubuntu**: For users on Ubuntu, the ``run_install_python.sh`` script is provided. This Bash script is created to operate within the default shell environment of Ubuntu, facilitating the Python installation process.

AWS Command Line Interface
--------------------------

Within the project's ``scripts`` directory, you will find a set of scripts specifically designed for the installation of the AWS Command Line Interface (AWS CLI). These scripts facilitate the installation process on different operating systems, ensuring a consistent and reliable setup.

- **Ubuntu**: Ubuntu users should utilize the ``run_install_aws_cli.sh`` script. This script is a Bash script that simplifies the AWS CLI installation on Ubuntu systems by setting up the necessary repositories and installing the CLI via apt-get.

Miniconda
---------

The ``scripts`` directory includes a collection of operating system-specific scripts named ``run_install_miniconda`` to streamline the installation of Miniconda. These scripts are designed to cater to the needs of different environments, making the setup process efficient and user-friendly.

- **Ubuntu Bash Shell**: Ubuntu users can take advantage of the ``run_install_miniconda.sh`` script. This Bash script is intended for use within the Ubuntu terminal, encapsulating the necessary commands to install Miniconda seamlessly on Ubuntu systems.

Docker Desktop
--------------

The ``scripts`` directory contains scripts that assist with installing Docker Desktop on macOS and Ubuntu, facilitating an automated and streamlined setup.

- **Ubuntu**: The ``run_install_docker.sh`` script is available for Ubuntu users. This Bash script sets up Docker Desktop on Ubuntu systems by configuring the necessary repositories and managing the installation steps through the system's package manager.

DBeaver - optional
------------------

DBeaver is an optional but highly recommended tool for this software as it offers a user-friendly interface to gain insights into the database internals. The project provides convenient scripts for installing DBeaver on macOS and Ubuntu.

- **Ubuntu**: For Ubuntu users, the ``run_install_dbeaver.sh`` script facilitates the installation of DBeaver. This Bash script automates the setup process, adding necessary repositories and handling the installation seamlessly.

Python Libraries
----------------

The project's Python dependencies are managed partly through Conda and partly through pip. To facilitate a straightforward installation process, a Makefile is provided at the root of the project.

- **Development Environment**: Run the command ``make conda-dev`` from the terminal to set up a development environment. This will install the necessary Python libraries using Conda and pip as specified for development purposes.

- **Production Environment**: Execute the command ``make conda-prod`` for preparing a production environment. It ensures that all the required dependencies are installed following the configurations optimized for production deployment.

The Makefile targets abstract away the complexity of managing multiple package managers and streamline the environment setup. It is crucial to have both Conda and the appropriate pip tool available in your system's PATH to utilize the Makefile commands successfully.




