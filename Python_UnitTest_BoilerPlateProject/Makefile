## Directory
HOME = .
SRCDIR = $(HOME)/src
TSTDIR = $(HOME)/test
DOCDIR = $(HOME)/docs


## COMPILER/INTERPRETER
PYTHON = python3

## Run Unit Tests
.PHONY = test_all
test_all:
	$(PYTHON) -m unittest

.PHONY = test_circle
test_circle:
	$(PYTHON) -m unittest tests.test_circle


## TARGETS
#VENV = venv
#PYTHON = $(VENV)/bin/python3
#PIP = $(VENV)/bin/pip
#
#run: $(VENV)/bin/activate
# $(PYTHON) app.py
#
#
#$(VENV)/bin/activate: requirements.txt
# python3 -m venv $(VENV)
# $(PIP) install -r requirements.txt
#
#
#clean:
# rm -rf __pycache__
# rm -rf $(VENV)
