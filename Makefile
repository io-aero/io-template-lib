.DEFAULT_GOAL := help

ifeq ($(OS),Windows_NT)
	export ALL_IO_TEMPLATE_LIB_CHECKED_DIRS=iotemplatelib iotemplatelib\\tools iotemplatelib\\lidar tests
	export ALL_IO_TEMPLATE_LIB_CHECKED_FILES=iotemplatelib\\*.py iotemplatelib\\tools\\*.py iotemplatelib\\lidar\\*.py
	export CREATE_DIST=if not exist dist mkdir dist
	export DELETE_BUILD=if exist build rd /s /q build
	export DELETE_DIST=if exist dist rd /s /q dist
	export DELETE_PIPFILE_LOCK=del /f /q Pipfile.lock
	export DELETE_SPHINX_1=del /f /q docs\\build\\*
	export DELETE_SPHINX_2=del /f /q docs\\source\\modules.rst
	export ENV_FOR_DYNACONF=test
	export OPTION_NUITKA=
	export PIPENV=py -m pipenv
	export PYTHON=py
	export SPHINX_BUILDDIR=docs\\build
	export SPHINX_SOURCEDIR=docs\\source
else
	export ALL_IO_TEMPLATE_LIB_CHECKED_DIRS=iotemplatelib tests
	export ALL_IO_TEMPLATE_LIB_CHECKED_FILES=iotemplatelib/*.py
	export CREATE_DIST=mkdir -p dist
	export DELETE_BUILD=rm -rf build
	export DELETE_DIST=rm -rf dist
	export DELETE_PIPFILE_LOCK=rm -rf Pipfile.lock
	export DELETE_SPHINX_1=rm -rf docs/build/* docs/source/sua.rst docs/source/sua.vector3d.rst
	export DELETE_SPHINX_2=rm -rf docs/source/modules.rst
	export ENV_FOR_DYNACONF=test
	export OPTION_NUITKA=--disable-ccache
	export PIPENV=python3 -m pipenv
	export PYTHON=python3
	export SPHINX_BUILDDIR=docs/build
	export SPHINX_SOURCEDIR=docs/source
endif

export CONDA_ARG=--site-packages
export CONDA_ARG=
export MODULE=iotemplatelib
export PYTHONPATH=${MODULE} scripts
export VERSION_PIPENV=v2023.7.23
export VERSION_PYTHON=3.10

##                                                                            .
## =============================================================================
## IO-TEMPLATE-LIB - IO Aero Template Library - make Documentation.
##                   -----------------------------------------------------------
##                   The purpose of this Makefile is to support the whole
##                   software development process for io-template-lib. It
##                   contains also the necessary tools for the CI activities.
##                   -----------------------------------------------------------
##                   The available make commands are:
## -----------------------------------------------------------------------------
## help:               Show this help.
## -----------------------------------------------------------------------------
## everything:         Do everything precheckin
everything: dev docs nuitka
## dev:                Format, lint and test the code.
dev: format lint tests
## docs:               Check the API documentation, create and upload the user documentation.
docs: pydocstyle sphinx
## final:              Format, lint and test the code, create the documentation and a ddl.
#final: format lint docs tests nuitka
# wwe
final: format lint docs nuitka
## format:             Format the code with isort, Black and docformatter.
format: isort black docformatter
## lint:               Lint the code with Bandit, Flake8, Pylint and Mypy.
lint: bandit flake8 pylint mypy
## tests:              Run all tests with pytest.
tests: pytest
## -----------------------------------------------------------------------------

help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

# Bandit is a tool designed to find common security issues in Python code.
# https://github.com/PyCQA/bandit
# Configuration file: none
bandit:             ## Find common security issues with Bandit.
	@echo Info **********  Start: Bandit ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run bandit --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run bandit -c pyproject.toml -r ${PYTHONPATH}
	@echo Info **********  End:   Bandit ***************************************

# The Uncompromising Code Formatter
# https://github.com/psf/black
# Configuration file: pyproject.toml
black:              ## Format the code with Black.
	@echo Info **********  Start: black ****************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run black --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run black ${PYTHONPATH} tests
	@echo Info **********  End:   black ****************************************

# Byte-compile Python libraries
# https://docs.python.org/3/library/compileall.html
# Configuration file: none
compileall:         ## Byte-compile the Python libraries.
	@echo Info **********  Start: Compile All Python Scripts *******************
	@echo PYTHON=${PYTHON}
	@echo ----------------------------------------------------------------------
	${PYTHON} --version
	@echo ----------------------------------------------------------------------
	${PYTHON} -m compileall
	@echo Info **********  End:   Compile All Python Scripts *******************

# Miniconda - Minimal installer for conda.
# https://docs.conda.io/en/latest/miniconda.html
# Configuration file: pyproject.toml
conda-env:          ## Create a new environment.
	@echo Info **********  Start: Miniconda create environment *****************
	conda --version
	@echo ----------------------------------------------------------------------
	conda create --yes --name ${MODULE}
	conda activate ${MODULE}
	conda remove --yes --name ${MODULE} --all
	conda create --yes --name ${MODULE} python=${VERSION_PYTHON}
	conda activate ${MODULE}
	conda install --yes -c conda-forge gdal pdal python-pdal rasterio
	@echo ----------------------------------------------------------------------
	python --version
	conda info --envs
	conda list
	@echo Info **********  End:   Miniconda create environment *****************
conda-update:       ## Update Miniconda.
	@echo Info **********  Start: Miniconda update *****************************
	conda --version
	@echo ----------------------------------------------------------------------
	conda update --yes conda
	@echo ----------------------------------------------------------------------
	conda --version
	@echo Info **********  End:   Miniconda update *****************************

# Formats docstrings to follow PEP 257
# https://github.com/PyCQA/docformatter
# Configuration file: none
docformatter:       ## Format the docstrings with docformatter.
	@echo Info **********  Start: docformatter *********************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run docformatter --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run docformatter --in-place -r ${PYTHONPATH}
	${PIPENV} run docformatter --in-place -r tests
	@echo Info **********  End:   docformatter *********************************

# Flake8: Your Tool For Style Guide Enforcement.
# https://github.com/pycqa/flake8
# Configuration file: cfg.cfg
flake8:             ## Enforce the Python Style Guides with Flake8.
	@echo Info **********  Start: Flake8 ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run flake8 --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run flake8 ${PYTHONPATH} tests
	@echo Info **********  End:   Flake8 ***************************************

# isort your imports, so you don't have to.
# https://github.com/PyCQA/isort
# Configuration file: pyproject.toml
isort:              ## Edit and sort the imports with isort.
	@echo Info **********  Start: isort ****************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run isort --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run isort ${PYTHONPATH} tests
	@echo Info **********  End:   isort ****************************************

# Mypy: Static Typing for Python
# https://github.com/python/mypy
# Configuration file: pyproject.toml
mypy:               ## Find typing issues with Mypy.
	@echo Info **********  Start: Mypy *****************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run mypy --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run mypy ${PYTHONPATH}
	@echo Info **********  End:   Mypy *****************************************

mypy-stubgen:       ## Autogenerate stub files
	@echo Info **********  Start: Mypy *****************************************
	@echo PIPENV                          =${PIPENV}
	@echo ALL_IO_TEMPLATE_LIB_CHECKED_DIRS=${ALL_IO_TEMPLATE_LIB_CHECKED_DIRS}
	@echo ----------------------------------------------------------------------
	${PIPENV} run stubgen ${ALL_IO_TEMPLATE_LIB_CHECKED_FILES}
	mv out/iotemplatelib/*.pyi iotemplatelib/
	mv out/iotemplatelib/tools/*.pyi iotemplatelib/tools/
	mv out/iotemplatelib/lidar/*.pyi iotemplatelib/lidar/
	rm -rf out
	@echo Info **********  End:   Mypy *****************************************

# Nuitka: Python compiler written in Python
# https://github.com/Nuitka/Nuitka
nuitka:             ## Create a dynamic link library.
	@echo Info **********  Start: nuitka ***************************************
	@echo CREATE_DIST  =${CREATE_DIST}
	@echo DELETE_DIST  =${DELETE_DIST}
	@echo MODULE       =${MODULE}
	@echo OPTION_NUITKA=${OPTION_NUITKA}
	@echo PYTHON       =${PYTHON}
	@echo ----------------------------------------------------------------------
	${PIPENV} run ${PYTHON} -m nuitka --version
	@echo ----------------------------------------------------------------------
	${DELETE_DIST}
	${CREATE_DIST}
	${PIPENV} run ${PYTHON} -m nuitka ${OPTION_NUITKA} --include-package=iotemplatelib --module ${MODULE} --no-pyi-file --output-dir=dist --remove-output
	@echo Info **********  End:   nuitka ***************************************

# pip is the package installer for Python.
# https://pypi.org/project/pip/
# Configuration file: none
# Pipenv: Python Development Workflow for Humans.
# https://github.com/pypa/pipenv
# Configuration file: Pipfile
pipenv-dev:         ## Install the package dependencies for development.
	@echo Info **********  Start: Installation of Development Packages *********
	@echo DELETE_PIPFILE_LOCK=${DELETE_PIPFILE_LOCK}
	@echo PIPENV    =${PIPENV}
	@echo PYTHON    =${PYTHON}
	@echo ----------------------------------------------------------------------
	${PYTHON} -m pip install --upgrade pip
	${PYTHON} -m pip install --upgrade pipenv==${VERSION_PIPENV}
	${PYTHON} -m pip install --upgrade virtualenv
	${DELETE_BUILD}
	${DELETE_PIPFILE_LOCK}
	@echo ----------------------------------------------------------------------
	aws codeartifact login --tool pip --repository io-aero-pypi --domain io-aero --domain-owner 444046118275 --region us-east-1
	${PIPENV} install ${CONDA_ARG} --dev
	@echo ----------------------------------------------------------------------
	${PIPENV} run pip freeze
	@echo ----------------------------------------------------------------------
	${PYTHON} --version
	${PYTHON} -m pip --version
	${PYTHON} -m pipenv --version
	${PYTHON} -m virtualenv --version
	@echo Info **********  End:   Installation of Development Packages *********
pipenv-prod:        ## Install the package dependencies for production.
	@echo Info **********  Start: Installation of Production Packages **********
	@echo DELETE_PIPFILE_LOCK=${DELETE_PIPFILE_LOCK}
	@echo PIPENV             =${PIPENV}
	@echo PYTHON             =${PYTHON}
	@echo ----------------------------------------------------------------------
	${PYTHON} -m pip install --upgrade pip
	${PYTHON} -m pip install --upgrade pipenv==${VERSION_PIPENV}
	${PYTHON} -m pip install --upgrade virtualenv
	${DELETE_BUILD}
	${DELETE_PIPFILE_LOCK}
	@echo ----------------------------------------------------------------------
	aws codeartifact login --tool pip --repository io-aero-pypi --domain io-aero --domain-owner 444046118275 --region us-east-1
	${PIPENV} install ${CONDA_ARG}
	@echo ----------------------------------------------------------------------
	${PIPENV} run pip freeze
	@echo ----------------------------------------------------------------------
	${PYTHON} --version
	${PYTHON} -m pip --version
	${PYTHON} -m pipenv --version
	${PYTHON} -m virtualenv --version
	@echo Info **********  End:   Installation of Production Packages **********

# pydocstyle - docstring style checker.
# https://github.com/PyCQA/pydocstyle
# Configuration file: pyproject.toml
pydocstyle:         ## Check the API documentation with pydocstyle.
	@echo Info **********  Start: pydocstyle ***********************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run pydocstyle --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run pydocstyle --count --match='(?!PDFLIB\\)*\.py' ${PYTHONPATH} tests
	@echo Info **********  End:   pydocstyle ***********************************

# Pylint is a tool that checks for errors in Python code.
# https://github.com/PyCQA/pylint/
# Configuration file: .pylintrc
pylint:             ## Lint the code with Pylint.
	@echo Info **********  Start: Pylint ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run pylint --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run pylint ${PYTHONPATH} tests
	@echo Info **********  End:   Pylint ***************************************

# pytest: helps you write better programs.
# https://github.com/pytest-dev/pytest/
# Configuration file: pyproject.toml
pytest:             ## Run all tests with pytest.
	@echo Info **********  Start: pytest ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --dead-fixtures tests
	${PIPENV} run pytest --cache-clear --cov=${PYTHONPATH} --cov-report term-missing:skip-covered -v tests
	@echo Info **********  End:   pytest ***************************************
pytest-ci:          ## Run all tests with pytest after test tool installation.
	@echo Info **********  Start: pytest ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} install pytest
	${PIPENV} install pytest-cov
	${PIPENV} install pytest-deadfixtures
	${PIPENV} install pytest-helpers-namespace
	${PIPENV} install pytest-random-order
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --dead-fixtures tests
	${PIPENV} run pytest --cache-clear --cov=${PYTHONPATH} --cov-report term-missing:skip-covered -v tests
	@echo Info **********  End:   pytest ***************************************
pytest-first-issue: ## Run all tests with pytest until the first issue occurs.
	@echo Info **********  Start: pytest ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --cache-clear --cov=${PYTHONPATH} --cov-report term-missing:skip-covered -rP -v -x tests
	@echo Info **********  End:   pytest ***************************************
pytest-issue:       ## Run only the tests with pytest which are marked with 'issue'.
	@echo Info **********  Start: pytest ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --cache-clear --capture=no --cov=${PYTHONPATH} --cov-report term-missing:skip-covered -m issue -rP -v -x tests
	@echo Info **********  End:   pytest ***************************************
pytest-module:      ## Run tests of specific module(s) with pytest - test_all & test_cfg_cls_setup & test_db_cls.
	@echo Info **********  Start: pytest ***************************************
	@echo PIPENV    =${PIPENV}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --version
	@echo ----------------------------------------------------------------------
	${PIPENV} run pytest --cache-clear --cov=${PYTHONPATH} --cov-report term-missing:skip-covered -v tests/test_db_cls_action.py
	@echo Info **********  End:   pytest ***************************************

sphinx:            ##  Create the user documentation with Sphinx.
	@echo DELETE_SPHINX_1 =${DELETE_SPHINX_1}
	@echo DELETE_SPHINX_2 =${DELETE_SPHINX_2}
	@echo PIPENV          =${PIPENV}
	@echo SPHINX_BUILDDIR =${SPHINX_BUILDDIR}
	@echo SPHINX_SOURCEDIR=${SPHINX_SOURCEDIR}
	@echo ----------------------------------------------------------------------
	${DELETE_SPHINX_1}
	cd ${DOCUMENTATION_DIR}
	${PIPENV} run sphinx-apidoc -o ${SPHINX_SOURCEDIR} ${PYTHONPATH}
	${DELETE_SPHINX_2}
	${PIPENV} run sphinx-build -M html ${SPHINX_SOURCEDIR} ${SPHINX_BUILDDIR}
#	${PIPENV} run sphinx-build -b rinoh ${SPHINX_SOURCEDIR} ${SPHINX_BUILDDIR}/pdf
	cd ..
	@echo Info **********  End:   sphinx ***************************************

sphinx-api:
	${PIPENV} run sphinx-apidoc -o ${SPHINX_SOURCEDIR} ${PYTHONPATH}

# twine: Collection of utilities for publishing packages on io-aero-pypi.
# https://pypi.org/project/twine/
upload-io-aero:     ## Upload the distribution archive to io-aero-pypi.
	@echo Info **********  Start: twine io-aero-pypi ***************************
	@echo CREATE_DIST=${CREATE_DIST}
	@echo DELETE_DIST=${DELETE_DIST}
	@echo PYTHON     =${PYTHON}
	${PYTHON} -m build --version
	${PYTHON} -m twine --version
	@echo ----------------------------------------------------------------------
	${DELETE_DIST}
	${CREATE_DIST}
	${PYTHON} -m build
	aws codeartifact login --tool twine --repository io-aero-pypi --domain io-aero --domain-owner 444046118275 --region us-east-1
	${PYTHON} -m twine upload --repository codeartifact --verbose dist/*
	@echo Info **********  End:   twine io-aero-pypi ***************************

# twine: Collection of utilities for publishing packages on PyPI.
# https://pypi.org/project/twine/
upload-pypi:        ## Upload the distribution archive to PyPi.
	@echo Info **********  Start: twine pypi ***********************************
	@echo CREATE_DIST=${CREATE_DIST}
	@echo DELETE_DIST=${DELETE_DIST}
	@echo PYTHON     =${PYTHON}
	${PYTHON} -m build --version
	${PYTHON} -m twine --version
	@echo ----------------------------------------------------------------------
	${DELETE_DIST}
	${CREATE_DIST}
	${PYTHON} -m build
	${PYTHON} -m twine upload -p $(SECRET_PYPI) -u io-aero dist/*
	@echo Info **********  End:   twine pypi ***********************************

# twine: Collection of utilities for publishing packages on Test PyPI.
# https://pypi.org/project/twine/
# https://test.pypi.org
upload-testpypi:    ## Upload the distribution archive to Test PyPi.
	@echo Info **********  Start: twine testpypi *******************************
	@echo CREATE_DIST=${CREATE_DIST}
	@echo DELETE_DIST=${DELETE_DIST}
	@echo PYTHON     =${PYTHON}
	${PYTHON} -m build --version
	${PYTHON} -m twine --version
	@echo ----------------------------------------------------------------------
	${DELETE_DIST}
	${CREATE_DIST}
	${PYTHON} -m  build
	${PYTHON} -m  twine upload -p $(SECRET_TEST_PYPI) -r testpypi -u io-aero-test --verbose dist/*
	@echo Info **********  End:   twine testpypi *******************************

version:            ## Show the installed software versions.
	@echo Info **********  Start: version **************************************
	@echo PYTHON=${PYTHON}
	@echo ----------------------------------------------------------------------
	${PYTHON} -m pip --version
	${PYTHON} -m pipenv --version
	@echo Info **********  End:   version **************************************

## =============================================================================
