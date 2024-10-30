# IO-TEMPLATE-LIB - Template for Library Repositories

This repository is a sample repository for developing Python related IO-Aero libraries.
## Quickstart

This is a quick start guide.
Detailed instructions can be found in the [documentation](https://io-aero.github.io/io-template-lib/) under Requirements, Installation and First Steps.

1. Run the following commands:

```
    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8
```

2. Add the following entries to your `~/.bashrc` file:

```
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
    export PYPI_PAT=<tbd>
```

3. Install Python 3.11
4. Install Conda or Miniconda
5. Clone this repository:

```
    git clone https://github.com/io-aero/io-template-lib
```

6. Create the virtual environment:

```
    make conda-dev
```

7. Switch to the created virtual environment:

```
    conda activate iotemplatelib
```

8. Create a file named `.settings.io_aero.toml` which contains the database access data

9. Test the whole functionality:

```
    make final
```

10. All Makefile commands can be found by running:

```
    make 
```
 or 
```
    make help
```

```
=============================================================================
make Script       The purpose of this Makefile is to support the whole
                  software development process for a library. It
                  contains also the necessary tools for the CI activities.
                  -----------------------------------------------------------
                  The available make commands are:
-----------------------------------------------------------------------------
help:               Show this help.
-----------------------------------------------------------------------------
action:             Run the GitHub Actions locally.
dev:                Format, lint and test the code.
docs:               Check the API documentation, create and upload the user documentation.
everything:         Do everything precheckin
final:              Format, lint and test the code and create the documentation.
format:             Format the code with Black and docformatter.
lint:               Lint the code with ruff, Bandit, vulture, Pylint and Mypy.
pre-push:           Preparatory work for the pushing process.
tests:              Run all tests with pytest.
-----------------------------------------------------------------------------
action-std:         Run the GitHub Actions locally: standard.
bandit:             Find common security issues with Bandit.
black:              Format the code with Black.
compileall:         Byte-compile the Python libraries.
conda-dev:          Create a new environment for development.
conda-prod:         Create a new environment for production.
coveralls:          Run all the tests and upload the coverage data to coveralls.
docformatter:       Format the docstrings with docformatter.
isort:              Edit and sort the imports with isort.
mypy:               Find typing issues with Mypy.
mypy-stubgen:       Autogenerate stub files.
next-version:       Increment the version number.
nuitka:             Create a dynamic link library.
pylint:             Lint the code with Pylint.
pytest:             Run all tests with pytest.
pytest-ci:          Run all tests with pytest after test tool installation.
pytest-first-issue: Run all tests with pytest until the first issue occurs.
pytest-ignore-mark: Run all tests without marker with pytest."
pytest-issue:       Run only the tests with pytest which are marked with 'issue'.
pytest-module:      Run test of a specific module with pytest.
ruff:               An extremely fast Python linter and code formatter.
sphinx:             Create the user documentation with Sphinx.
version:            Show the installed software versions.
vulture:            Find dead Python code.
=============================================================================
```

## Documentation

The complete documentation for this repository is contained in the GitHub pages [here](https://io-aero.github.io/io-template-lib/). 
See that documentation for installation instructions

Further IO-Aero software documentation can be found under the following links.

- [IO-AIRPLANE-SIM - Airplane Simulator](https://io-aero.github.io/io-airplane-sim/)
- [IO-AVSTATS - Aviation Event Statistics](https://io-aero.github.io/io-avstats/) 
- [IO-AX4-DI - Flight Data Interface](https://github.com/IO-Aero-Projects-2024/io-ax4-di/) 
- [IO-AX4-UI - Pilot Data Interface](https://github.com/io-swiss/io-ax4-ui/) 
- [IO-COMMON - Common Elements](https://io-aero.github.io/io-common/) 
- [IO-DATA-SOURCES - Data Source Documentation](https://io-aero.github.io/io-data-sources/) 
- [IO-EVAA-MAP-CREATOR - A tool to create EVAA elevation maps](https://io-aero.github.io/io-evaa-map-creator/) 
- [IO-LANDINGSPOT - Landing spot identification](https://io-aero.github.io/io-landingspot/) 
- [IO-LIDAR - Lidar Map Processing](https://io-aero.github.io/io-lidar/) 
- [IO-LIDAR-DATA - Lidar Data Management](https://io-aero.github.io/io-lidar-data/)
- [IO-MAP-APPS - IO Map Applications](https://io-aero.github.io/io-map-apps/) 
- [IO-RASTER - Raster Map Processing](https://io-aero.github.io/io-raster/) 
- [IO-RESOURCES - All relevant books, articles, etc](https://github.com/io-aero/io-resources/) 
- [IO-TEMPLATE-APP - Template for Application Repositories](https://io-aero.github.io/io-template-app/)
- [IO-TEMPLATE-LIB - Template for Library Repositories](https://io-aero.github.io/io-template-lib/)
- [IO-VECTOR - Vector Map Processing](https://io-aero.github.io/io-vector/) 
- [IO-XPA-CORE - IO-XPA Data Processing](https://io-aero.github.io/io-xpa-core/)
- [IO-XPI - X-Plane Interface](https://github.com/IO-Aero-Projects-2024/io-xpi/)

## Directory and File Structure of this Repository

### 1. Directories

| Directory         | Content                                                  |
|-------------------|----------------------------------------------------------|
| .github/workflows | GitHub Action workflows.                                 |
| .vscode           | Visual Studio Code configuration files.                  |
| config            | Configuration files.                                 |
| data              | Application data related files.                          |
| dist              | Dynamic link library version of **IO-TEMPLATE-LIB**.     |
| docs              | Documentation files.                                     |
| examples          | Scripts for examples and special tests.                  |
| iotemplatelib     | Python script files.                                     |
| libs              | Contains libraries that are not used via pip.         |
| resources         | Selected manuals and software.                           |
| scripts           | Scripts supporting Ubuntu.                   |
| tests             | Scripts and data for examples and tests.                 |

### 2. Files

| File                            | Functionality                                                        |
|---------------------------------|----------------------------------------------------------------------|
| .act_secrets_template           | Template file for the configuration of ``make action``.              |
| .gitattributes                  | Handling of the os-specific file properties.                         |
| .gitignore                      | Configuration of files and folders to be ignored.                    |
| .pylintrc                       | Pylint configuration file.                                           |
| .settings.io_aero_template.toml | Template file for the secret configuration data.                     |
| LICENSE.md                      | Text of the licence terms.                                           |
| logging_cfg.yaml                | Configuration of the Logger functionality.                           |
| Makefile                        | Tasks to be executed with the make command.                          |
| Pipfile                         | Definition of the Python package requirements.                       |
| pyproject.toml                  | Optional configuration data for the software quality tools.          |
| README.md                       | This file.                                                           |
| run_io_template_lib_pytest      | Main script for using the test functionality of **IO-TEMPLATE-LIB**. |
| settings.io_aero.toml           | Configuration data.                                                  |
| setup.cfg                       | Configuration data.                                       |
