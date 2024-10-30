Requirements
============

The required software is listed below.
Regarding the corresponding software versions, you will find the detailed information in the
`Release Notes <https://github.com/io-aero/io-template-lib/blob/main/docs/release_notes.md>`__\.

Operating System
------------------

The supported operating system is Ubuntu with the Bash shell.

`Python <https://docs.python.org/3/whatsnew/3.11.html>`__\
----------------------------------------------------------

This project utilizes Python from version 3.10, which introduced significant enhancements in type hinting and type annotations.
These improvements provide a more robust and clear definition of function parameters, return types, and variable types, contributing to improved code readability and maintainability.
The use of Python 3.11 ensures compatibility with these advanced typing features, offering a more structured and error-resistant development environment.

`Docker Desktop <https://www.docker.com/products/docker-desktop/>`__\
---------------------------------------------------------------------

The project employs PostgreSQL for data storage and leverages Docker images provided by PostgreSQL to simplify the installation process.
Docker Desktop is used for its ease of managing and running containerized applications, allowing for a consistent and isolated environment for PostgreSQL.
This approach streamlines the setup, ensuring that the database environment is quickly replicable and maintainable across different development setups.

`Miniconda <https://docs.conda.io/projects/miniconda/en/latest/>`__\
--------------------------------------------------------------------

Some of the Python libraries required by the project are exclusively available through Conda. To maintain a minimal installation footprint, it is recommended to install Miniconda, a smaller, more lightweight version of Anaconda that includes only Conda, its dependencies, and Python.

By using Miniconda, users can access the extensive repositories of Conda packages while keeping their environment lean and manageable. To install Miniconda, follow the instructions provided in the ``scripts`` directory of the project, where the operating system-specific installation script named ``run_install_miniconda`` is available for Ubuntu (Bash shell).

Utilizing Miniconda ensures that you have the necessary Conda environment with the minimal set of dependencies required to run and develop the project efficiently.

`DBeaver Community <https://dbeaver.io>`__\  - optional
-------------------------------------------------------

DBeaver is recommended as the user interface for interacting with the PostgreSQL database due to its comprehensive and user-friendly features.
It provides a flexible and intuitive platform for database management, supporting a wide range of database functionalities including SQL scripting, data visualization, and import/export capabilities.
Additionally, the project includes predefined connection configurations for DBeaver, facilitating a hassle-free and streamlined setup process for users.
