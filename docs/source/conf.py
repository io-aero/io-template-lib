# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os
import sys
from datetime import date

sys.path.insert(0, os.path.abspath("../../"))

from iocommon import io_glob
import importlib.metadata

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

author = "IO-Aero Team"
copyright = "2022 - 2024, IO-Aero"
github_url = "https://github.com/io-aero/io-template-lib"
project = "IO-TEMPLATE-LIB"

try:
    version = importlib.metadata.version("iotemplatelib")
except importlib.metadata.PackageNotFoundError:
    version = "?.?.?"

release = version.replace(".", "-")
todays_date = date.today()

rst_epilog = f"""
            .. |version| replace:: {version}
            .. |today| replace:: {todays_date}
            .. |release| replace:: {release}
            """

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.coverage",
    "sphinx.ext.extlinks",
    "sphinx.ext.githubpages",
    "sphinx.ext.linkcode",
    "sphinx.ext.napoleon",
    "sphinx.ext.viewcode",
    "myst_parser"
]

source_suffix = {
    ".rst": "restructuredtext",
    ".txt": "markdown",
    ".md": "markdown",
}

# templates_path = ['_templates']
# exclude_patterns = []

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_favicon = "img/IO-Aero_1_Favicon.ico"
html_logo = "img/IO-Aero_1_Logo.png"
html_static_path = ["_static"]
html_theme = "furo"
html_theme_options = {
    "sidebar_hide_name": True,
}

extlinks = {
    'repo': ('https://github.com/io-aero/io-template-lib%s', 'GitHub Repository')
}

# -- Options for PDF output --------------------------------------------------
rinoh_documents = [
    dict(
        doc="index",
        logo="img/IO-Aero_1_Logo.png",
        subtitle="Manual",
        target="manual",
        title="IO Template Lib Documentation",
        toctree_only=False,
    ),
]

def linkcode_resolve(domain, info):
    if domain != "py" or not info["module"]:
        return None
    filename = info["module"].replace(".", "/")
    return f"https://github.com/io-aero/io-template-lib/blob/master/{filename}.py"