# recipe-app-api

A recipe API project built with Django and Django REST Framework.

## Development Setup

1. Clone the repository
2. Run `docker-compose up` to start the development environment
3. Access the API at http://localhost:8000

## Linting & Formatting

This project uses modern Python linting and formatting tools:

### Build-time Linting

Linting is automatically performed during the Docker build process when DEV=true using Ruff, focusing on the application code in the `app` directory.

### Development-time Linting & Formatting

A separate lint service runs alongside the application in development mode:

- **Ruff**: A fast Python linter written in Rust that replaces Flake8, isort, and parts of Pylint
- **Black**: An opinionated code formatter that ensures consistent code style

You can manually run linting and formatting checks with:

```
docker-compose run --rm lint
```

To automatically format your code (fix issues):

```
docker-compose run --rm lint sh -c "cd /app && ruff check --fix . && black ."
```

## Git Pre-commit Hooks

The project includes pre-commit hooks to ensure code quality before each commit. To install:

```
pip install pre-commit
pre-commit install
```

## Project Structure

- `app/`: Main application code
- `requirements.txt`: Production dependencies
- `requirements.dev.txt`: Development dependencies
