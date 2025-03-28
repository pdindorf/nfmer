.PHONY: install test coverage coverage-report coverage-html

install:
	poetry install

install-test:
	poetry install --with test

test: install-test
	poetry run pytest tests/

install-fmt:
	poetry install --with fmt

python-fmt: install-fmt
	poetry run black .
	poetry run isort .

python-check: install-fmt
	poetry run black . --check
	poetry run isort . --check
	poetry run flake8 --max-line-length 120 .
	poetry run mypy --show-error-codes .

schema: install
	generate_schema

coverage: install-test
	poetry run coverage run -m pytest tests/

coverage-report: coverage
	poetry run coverage report

coverage-html: coverage
	poetry run coverage html

# Run all coverage commands in sequence
coverage-all: coverage coverage-report coverage-html

