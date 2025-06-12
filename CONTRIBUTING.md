# Contributing to Gelatin

First off, thank you for considering contributing to Gelatin! It's people like you that make Gelatin such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by a Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible.
* **Provide specific examples to demonstrate the steps**.
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**
* **Include screenshots and animated GIFs** which show you following the described steps and clearly demonstrate the problem.
* **Include your environment details** (iOS version, device model, Xcode version).

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title** for the issue to identify the suggestion.
* **Provide a step-by-step description of the suggested enhancement** in as many details as possible.
* **Provide specific examples to demonstrate the steps** or mock-ups/designs if applicable.
* **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
* **Explain why this enhancement would be useful** to most Gelatin users.

### Pull Requests

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code follows the existing style.
6. Issue that pull request!

## Development Setup

1. Clone your fork of the repository
   ```bash
   git clone https://github.com/YOUR-USERNAME/Gelatin.git
   ```

2. Open Package.swift in Xcode
   ```bash
   cd Gelatin
   open Package.swift
   ```

3. Make your changes and test them in the demo app

## Style Guide

### Swift Style Guide

We follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/). Some key points:

* Use descriptive names for types, variables, and functions
* Prefer clarity over brevity
* Use proper access control (`public`, `internal`, `private`)
* Document all public APIs with proper DocC comments
* Keep line length under 120 characters when possible

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

### Documentation

* All public APIs must have DocC documentation
* Include code examples in documentation where appropriate
* Update README.md if you change any public APIs
* Update API.md with detailed documentation for new features

## Testing

* Write unit tests for any new functionality
* Ensure all tests pass before submitting a pull request
* Test your changes in the demo app
* Test on both iPhone and iPad if applicable

## Release Process

1. Update version numbers in relevant files
2. Update CHANGELOG.md with release notes
3. Create a GitHub release
4. Tag the release with semantic versioning (e.g., v1.2.3)

## Community

* Be welcoming to newcomers and encourage diverse new contributors from all backgrounds
* Be respectful and considerate in your communication
* Assume good intentions from other contributors

Thank you for contributing to Gelatin! 🍮 