.DEFAULT_GOAL := help

MODULE=iotemplatelib
PYTHONPATH=${MODULE} docs scripts tests

export ENV_FOR_DYNACONF=test
export LANG=en_US.UTF-8

##                                                                            .
## =============================================================================
## make Script       The purpose of this Makefile is to support the whole
##                   software development process for a library. It
##                   contains also the necessary tools for the CI activities.
##                   -----------------------------------------------------------
##                   The available make commands are:
## -----------------------------------------------------------------------------
## help:               Show this help.
## -----------------------------------------------------------------------------
## action:             Run the GitHub Actions locally.
action: action-std
## dev:                Format, lint and test the code.
dev: format lint tests
## docs:               Check the API documentation, create and upload the user documentation.
docs: sphinx
## everything:         Do everything precheckin
everything: dev docs nuitka
## final:              Format, lint and test the code and create the documentation.
final: format lint docs tests
## format:             Format the code with Black and docformatter.
format: isort black docformatter
## lint:               Lint the code with ruff, Bandit, vulture, Pylint and Mypy.
lint: ruff bandit vulture pylint mypy
## pre-push:           Preparatory work for the pushing process.
pre-push: format lint tests next-version docs
## tests:              Run all tests with pytest.
tests: pytest
## -----------------------------------------------------------------------------

help:
	@sed -ne '/@sed/!s/## //p' ${MAKEFILE_LIST}

# Run the GitHub Actions locally.
# https://github.com/nektos/act
# Configuration files: .act_secrets & .act_vars
action-std:         ## Run the GitHub Actions locally: standard.
	@echo "Info **********  Start: action ***************************************"
	@echo "Copy your .aws/credentials to .aws_secrets"
	@echo "----------------------------------------------------------------------"
	act --version
	@echo "----------------------------------------------------------------------"
	act --quiet \
        --secret-file .act_secrets \
        --var IO_LOCAL='true' \
        --verbose \
        -P ubuntu-latest=catthehacker/ubuntu:act-latest \
        -W .github/workflows/github_pages.yml
	act --quiet \
        --secret-file .act_secrets \
        --var IO_LOCAL='true' \
        --verbose \
        -P ubuntu-latest=catthehacker/ubuntu:act-latest \
        -W .github/workflows/standard.yml
	@echo "Info **********  End:   action ***************************************"

# Bandit is a tool designed to find common security issues in Python code.
# https://github.com/PyCQA/bandit
# Configuration file: none
bandit:             ## Find common security issues with Bandit.
	@echo "Info **********  Start: Bandit ***************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	bandit --version
	@echo "----------------------------------------------------------------------"
	bandit -c pyproject.toml -r ${PYTHONPATH}
	@echo "Info **********  End:   Bandit ***************************************"

# The Uncompromising Code Formatter
# https://github.com/psf/black
# Configuration file: pyproject.toml
black:              ## Format the code with Black.
	@echo "Info **********  Start: black ****************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	black --version
	@echo "----------------------------------------------------------------------"
	black ${PYTHONPATH}
	@echo "Info **********  End:   black ****************************************"

# Byte-compile Python libraries
# https://docs.python.org/3/library/compileall.html
# Configuration file: none
compileall:         ## Byte-compile the Python libraries.
	@echo "Info **********  Start: Compile All Python Scripts *******************"
	python3 --version
	@echo "----------------------------------------------------------------------"
	python3 -m compileall
	@echo "Info **********  End:   Compile All Python Scripts *******************"

# Miniconda - Minimal installer for conda.
# https://docs.conda.io/en/latest/miniconda.html
# Configuration file: none
conda-dev:          ## Create a new environment for development.
	@echo "Info **********  Start: Miniconda create development environment *****"
	conda config --set always_yes true
	conda --version
	echo "PYPI_PAT=${PYPI_PAT}"
	@echo "----------------------------------------------------------------------"
	conda env remove -n ${MODULE} 2>/dev/null || echo "Environment '${MODULE}' does not exist."
	conda env create -f config/environment_dev.yml
	@echo "----------------------------------------------------------------------"
	conda info --envs
	conda list
	@echo "Info **********  End:   Miniconda create development environment *****"
conda-prod:         ## Create a new environment for production.
	@echo "Info **********  Start: Miniconda create production environment ******"
	conda config --set always_yes true
	conda --version
	@echo "----------------------------------------------------------------------"
	conda env remove -n ${MODULE} 2>/dev/null || echo "Environment '${MODULE}' does not exist."
	conda env create -f config/environment.yml
	@echo "----------------------------------------------------------------------"
	conda info --envs
	conda list
	@echo "Info **********  End:   Miniconda create production environment ******"

# Requires a public repository !!!
# Python interface to coveralls.io API
# https://github.com/TheKevJames/coveralls-python
# Configuration file: none
coveralls:          ## Run all the tests and upload the coverage data to coveralls.
	@echo "Info **********  Start: coveralls ************************************"
	pytest --cov=${MODULE} --cov-report=xml --random-order tests
	@echo "----------------------------------------------------------------------"
	coveralls --service=github
	@echo "Info **********  End:   coveralls ************************************"

# Formats docstrings to follow PEP 257
# https://github.com/PyCQA/docformatter
# Configuration file: pyproject.toml
docformatter:       ## Format the docstrings with docformatter.
	@echo "Info **********  Start: docformatter *********************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	docformatter --version
	@echo "----------------------------------------------------------------------"
	docformatter --in-place -r ${PYTHONPATH}
#	docformatter -r ${PYTHONPATH}
	@echo "Info **********  End:   docformatter *********************************"

# isort your imports, so you don't have to.
# https://github.com/PyCQA/isort
# Configuration file: pyproject.toml
isort:              ## Edit and sort the imports with isort.
	@echo "Info **********  Start: isort ****************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	isort --version
	@echo "----------------------------------------------------------------------"
	isort ${PYTHONPATH}
	@echo "Info **********  End:   isort ****************************************"

# Mypy: Static Typing for Python
# https://github.com/python/mypy
# Configuration file: pyproject.toml
mypy:               ## Find typing issues with Mypy.
	@echo "Info **********  Start: Mypy *****************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	mypy --version
	@echo "----------------------------------------------------------------------"
	mypy ${PYTHONPATH}
	@echo "Info **********  End:   Mypy *****************************************"

mypy-stubgen:       ## Autogenerate stub files.
	@echo "Info **********  Start: Mypy *****************************************"
	@echo "MODULE=${MODULE}"
	@echo "----------------------------------------------------------------------"
	rm -rf out
	stubgen --package ${MODULE}
	cp -f out/${MODULE}/* ./${MODULE}/
	rm -rf out
	@echo "Info **********  End:   Mypy *****************************************"

next-version:       ## Increment the version number.
	@echo "Info **********  Start: next_version *********************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	python3 --version
	@echo "----------------------------------------------------------------------"
	python3 scripts/next_version.py
	@echo "Info **********  End:   next version *********************************"

# Nuitka: Python compiler written in Python
# https://github.com/Nuitka/Nuitka
nuitka:             ## Create a dynamic link library.
	@echo "Info **********  Start: nuitka ***************************************"
	python -m nuitka --version
	@echo "----------------------------------------------------------------------"
	rm -rf dist
	mkdir -p dist
	python -m nuitka --disable-ccache --include-package=${MODULE} --module ${MODULE} --no-pyi-file --output-dir=dist --remove-output
	@echo "Info **********  End:   nuitka ***************************************"

# Pylint is a tool that checks for errors in Python code.
# https://github.com/PyCQA/pylint/
# Configuration file: .pylintrc
pylint:             ## Lint the code with Pylint.
	@echo "Info **********  Start: Pylint ***************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pylint --version
	@echo "----------------------------------------------------------------------"
	pylint ${PYTHONPATH}
	@echo "Info **********  End:   Pylint ***************************************"

# pytest: helps you write better programs.
# https://github.com/pytest-dev/pytest/
# Configuration file: pyproject.toml
pytest:             ## Run all tests with pytest.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered --cov-report=lcov -v tests
	@echo "Info **********  End:   pytest ***************************************"
pytest-ci:          ## Run all tests with pytest after test tool installation.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pip3 install pytest pytest-cov pytest-deadfixtures pytest-helpers-namespace pytest-random-order
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -v tests
	@echo "Info **********  End:   pytest ***************************************"
pytest-first-issue: ## Run all tests with pytest until the first issue occurs.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -rP -v -x tests
	@echo "Info **********  End:   pytest ***************************************"
pytest-ignore-mark: ## Run all tests without marker with pytest."
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures -m "not no_ci" tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered --cov-report=lcov -m "not no_ci" -v tests
	@echo Info **********  End:   pytest ***************************************
pytest-issue:       ## Run only the tests with pytest which are marked with 'issue'.
	@echo Info **********  Start: pytest ***************************************
	@echo CONDA     =${CONDA_PREFIX}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --capture=no --cov=${MODULE} --cov-report term-missing:skip-covered -m issue -rP -v -x tests
	@echo "Info **********  End:   pytest ***************************************"
pytest-module:      ## Run test of a specific module with pytest.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "TESTMODULE=tests/${TEST-MODULE}.py"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -v tests/${TEST-MODULE}.py
	@echo "Info **********  End:   pytest ***************************************"

# https://github.com/astral-sh/ruff
# Configuration file: pyproject.toml
ruff:               ## An extremely fast Python linter and code formatter.
	@echo "Info **********  Start: ruff *****************************************"
	ruff --version
	@echo "----------------------------------------------------------------------"
	ruff check --fix
	@echo "Info **********  End:   ruff *****************************************"

sphinx:             ## Create the user documentation with Sphinx.
	@echo "Info **********  Start: sphinx ***************************************"
	sphinx-apidoc --version
	sphinx-build --version
	@echo "----------------------------------------------------------------------"
	sudo rm -rf docs/build/*
	sphinx-apidoc -o docs/source ${MODULE}
	sphinx-build -M html docs/source docs/build
	sphinx-build -b rinoh docs/source docs/build/pdf
	@echo "Info **********  End:   sphinx ***************************************"

version:            ## Show the installed software versions.
	@echo "Info **********  Start: version **************************************"
	python3 --version
	pip3 --version
	@echo "Info **********  End:   version **************************************"

# Find dead Python code
# https://github.com/jendrikseipp/vulture
# Configuration file: pyproject.toml
vulture:            ## Find dead Python code.
	@echo "Info **********  Start: vulture **************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	vulture --version
	@echo "----------------------------------------------------------------------"
	vulture ${PYTHONPATH}
	@echo "Info **********  End:   vulture **************************************"

## =============================================================================
