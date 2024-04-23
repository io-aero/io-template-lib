"""Configuration file for the Sphinx documentation builder."""
import importlib.metadata
import sys
from datetime import UTC, datetime
from pathlib import Path

from rinoh.frontend.rst import DocutilsInlineNode

# Debug: Print the current working directory and sys.path
print("==========>") # noqa: T201
print("==========> Current working directory:", Path.cwd()) # noqa: T201
print("==========>") # noqa: T201
sys.path.insert(0, Path("../../iotemplatelib").resolve())
print("==========>") # noqa: T201
print("==========> Updated sys.path:", sys.path) # noqa: T201
print("==========>") # noqa: T201

# -- Project information -----------------------------------------------------

author = "IO-Aero Team"
copyright: str = "2022 - 2024, IO-Aero" # noqa: A001
github_url = "https://github.com/io-aero/io-template-lib"
project = "IO-TEMPLATE-LIB"

try:
    version = importlib.metadata.version("iotemplatelib")
except importlib.metadata.PackageNotFoundError:
    version = "unknown"
    print("==========>")  # noqa: T201
    print("==========> Warning: Version not found, defaulting to 'unknown'.") # noqa: T201
    print("==========>") # noqa: T201

release = version.replace(".", "-")

todays_date = datetime.now(tz=UTC)

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

exclude_patterns = [
    ".DS_Store",
    "README.md",
    "Thumbs.db",
    "_build",
    "img/README.md",
]

# Check if building with RinohType for PDF
if "rinoh" in sys.argv:
    # Add the files you want to exclude specifically from PDF
    exclude_patterns.extend([
        "process_logs.rst",
        "process_logs/*.md",
    ])

extensions = [
    "sphinx.ext.autodoc",  # Automatically generates documentation from docstrings in the source code. # noqa: E501
    "sphinx.ext.extlinks",  # Simplifies linking to external sites with short aliases instead of full URLs. # noqa: E501
    "sphinx.ext.githubpages",  # Creates .nojekyll file to publish the doc as GitHub Pages correctly. # noqa: E501
    "sphinx.ext.napoleon",  # Allows for support of NumPy and Google style docstrings, improving docstring readability. # noqa: E501
    "myst_parser",  # Adds support for Markdown sources, allowing Sphinx to read and parse Markdown files. # noqa: E501
]

# Configuration for autodoc extension
autodoc_default_options = {
    "member-order": "bysource",  # Order members by source order
    "special-members": "__init__",  # Document special members such as __init__
    "undoc-members": True,  # Document members without docstrings
    "exclude-members": "__weakref__",  # Exclude specific members
}

extlinks = {
    "repo": ("https://github.com/io-aero/io-template-lib%s", "GitHub Repository"),
}

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_favicon = "img/IO-Aero_1_Favicon.ico"
html_logo = "img/IO-Aero_1_Logo.png"
html_show_sourcelink = False
html_theme = "furo"  # Chosen for its clean and modern design that improves navigation and readability. # noqa: E501
html_theme_options = {
    "sidebar_hide_name": True,
}

# The master toctree document.
master_doc = "index"

# -- Options for PDF output --------------------------------------------------
rinoh_documents = [
    dict(
        doc="index",
        logo="img/IO-Aero_1_Logo.png",
        subtitle="Manual",
        target="manual",
        title="Template Library",
        toctree_only=False,
    ),
]

# rst_epilog = f"""
#             .. |version| replace:: {version}
#             .. |today| replace:: {todays_date}
#             .. |release| replace:: {release}
#             """

source_suffix = {
    ".rst": "restructuredtext",
    ".txt": "markdown",
    ".md": "markdown",
}

class Desc_Sig_Space(DocutilsInlineNode):  # noqa: N801

    """A custom inline node for managing space in document signatures.

    This class extends `DocutilsInlineNode` to provide specific handling
    for spacing within descriptive parts of a document, such as signatures.
    It can be used to insert custom spacing or separation where the standard
    docutils nodes do not suffice, ensuring that the document's formatting
    meets specific requirements or aesthetics.

    Attributes
    ----------
        None specific to this class. Inherits attributes from `DocutilsInlineNode`.

    Methods
    -------
        Inherits all methods from `DocutilsInlineNode` and does not override or extend them.

    Usage:
        This node should be instantiated and manipulated via docutils' mechanisms
        for handling custom inline nodes. It's primarily intended for extensions
        or custom processing within Sphinx documentation projects.

    """
