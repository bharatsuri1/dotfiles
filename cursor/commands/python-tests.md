# Production Library Test Generation Guide

## Purpose

You are tasked with generating high-quality, production-ready tests using the pytest framework for a production library. Your tests must be maintainable, self-documenting, and focused on meaningful coverage rather than arbitrary metrics. Quality always takes precedence over quantity.

## Core Testing Principles

### 1. Test Behavior, Not Implementation

- Focus on **what** the code does, not **how** it does it
- Tests should remain valid when internal implementation changes
- Verify outcomes, side effects, and contracts—not private methods or internal state

### 2. Single Responsibility Principle

- Each test should verify one specific behavior or scenario
- If a test name requires "and" or "or", it likely tests multiple concepts
- Focused tests make failures easier to diagnose and fix

### 3. Arrange-Act-Assert (AAA) Pattern

Structure every test clearly:

- **Arrange**: Set up test data and preconditions
- **Act**: Execute the code under test
- **Assert**: Verify the expected outcome

Use blank lines to visually separate these sections.

### 4. Test Isolation and Independence

- Tests must run successfully in any order
- No shared mutable state between tests
- Each test should set up its own data
- Clean up resources properly (use fixtures for this)

### 5. Avoid Redundancy

- Don't write multiple tests that verify the same behavior
- Don't test framework or library code (e.g., testing that a dict stores values)
- Don't test trivial code (simple getters/setters without logic)

## pytest Framework Best Practices

### Fixtures

**Use fixtures for:**

- Setup and teardown operations
- Providing test data
- Sharing common objects across tests
- Managing resources (files, connections, etc.)

**Fixture scoping:**

- `function` (default): New instance per test
- `class`: One instance per test class
- `module`: One instance per test module
- `session`: One instance per test session

**Placement:**

- Test-specific fixtures: Same file as tests
- Shared fixtures: `conftest.py` at appropriate level

### Parametrization

Use `@pytest.mark.parametrize` to test multiple scenarios without duplication:

- Multiple input/output combinations
- Boundary conditions
- Different data types or formats
- Error conditions with different invalid inputs

### Marks

Apply pytest marks judiciously:

- `@pytest.mark.skip`: Known issues or platform-specific tests
- `@pytest.mark.xfail`: Expected failures during development
- `@pytest.mark.slow`: Tests that take significant time
- Custom marks: For categorizing tests (integration, unit, smoke, etc.)

### Test Discovery

Follow pytest conventions:

- Test files: `test_*.py` or `*_test.py`
- Test functions: `test_*`
- Test classes: `Test*` (no `__init__` method)
- Test methods in classes: `test_*`

## Test Quality Standards

### Descriptive Test Names

Test names should read like specifications:

- Use complete sentences describing the scenario
- Include the condition being tested
- State the expected outcome
- Format: `test_<function>_<condition>_<expected_result>`

Example: `test_divide_by_zero_raises_value_error`

### Self-Documenting Tests

- The test itself should be clear without extensive comments
- Use meaningful variable names
- Keep test logic simple and linear
- Add docstrings only when the test scenario needs additional context

### Comprehensive Scenarios

Test the full spectrum:

- **Happy path**: Expected inputs and normal operation
- **Edge cases**: Boundary values (empty, zero, maximum, minimum)
- **Error conditions**: Invalid inputs, null/None, wrong types
- **State transitions**: Before/after comparisons
- **Concurrent scenarios**: Thread safety if applicable

### Exception Testing

Verify both that exceptions are raised and their messages are meaningful:

- Use `pytest.raises()` context manager
- Check exception type
- Verify exception message when important
- Test exception attributes if applicable

### Mocking and Patching

Mock external dependencies appropriately:

- **Mock**: External services, APIs, databases, file systems
- **Don't mock**: Code under test, simple data structures, standard library types
- Use `unittest.mock` or `pytest-mock`
- Verify mock calls when the interaction is the behavior being tested
- Prefer dependency injection over excessive patching

## Test Organization

### File Structure

Mirror your source code structure:

```
src/
  mylib/
    module.py
    subpackage/
      another.py
tests/
  test_module.py
  subpackage/
    test_another.py
```

### Class-Based Organization

Use classes to group related tests:

- Tests for the same component/function
- Tests requiring shared fixtures
- Tests representing different scenarios for the same feature

Classes provide namespace organization—not object-oriented test design.

### Test Type Separation

Organize by test type when appropriate:

```
tests/
  unit/
  integration/
  functional/
  conftest.py
```

Or use marks to categorize without directory separation.

## Coverage Strategy

### Focus on What Matters

**Prioritize testing:**

- Public APIs and interfaces
- Business logic and algorithms
- Error handling and validation
- Complex conditional logic
- Integration points

**Lower priority:**

- Simple getters/setters without logic
- Trivial wrappers
- Configuration constants
- Code covered by integration tests

### Coverage as a Guide, Not a Goal

- 100% coverage doesn't guarantee quality
- Meaningful tests for critical paths beat arbitrary coverage metrics
- Uncovered code may indicate unused code
- Use coverage reports to find untested scenarios, not to chase percentages

### Test Through Public Interfaces

- Test private methods indirectly through public API
- If a private method needs direct testing, it might deserve to be public or a separate module
- Focus on behavior contracts, not implementation details

## Maintainability Guidelines

### DRY Principle in Tests

Reduce duplication while maintaining clarity:

- Extract common setup to fixtures
- Create test helper functions for complex assertions
- Use parametrization instead of copy-paste tests
- Balance DRY with test readability—some duplication is acceptable

### Test Data Management

- Use factories or builders for complex test objects
- Keep test data close to the test (unless shared)
- Make test data obviously fake (e.g., `user@example.com`, not real emails)
- Use meaningful test data that clarifies the scenario

### Evolving Tests with Code

Tests should be easy to update:

- Minimal coupling to implementation details
- Clear structure makes changes obvious
- Good naming helps identify what needs updating
- Fixtures centralize common setup changes

### Documentation in Tests

- Test name is primary documentation
- Docstrings for complex scenarios or business rules
- Comments for non-obvious test data or assertions
- Keep explanations minimal—prefer self-explanatory code

## Anti-Patterns to Avoid

### Testing Implementation Details

❌ Don't test internal state, private methods, or how something works
✓ Do test behavior, outputs, and side effects

### Overly Complex Test Logic

❌ Don't use complex conditionals, loops, or calculations in tests
✓ Do keep tests simple and linear—complexity belongs in production code

### Hidden Dependencies

❌ Don't rely on test execution order, external state, or implicit setup
✓ Do make all dependencies explicit through fixtures or parameters

### Excessive Mocking

❌ Don't mock everything, creating brittle tests tied to implementation
✓ Do mock external dependencies and boundaries, test real objects

### Test Code Smells

- **No assertions**: Tests that don't verify anything
- **Multiple concepts**: Tests that check unrelated behaviors
- **Copy-paste**: Duplicated test code with minor variations
- **Mystery guest**: Tests that depend on external data or state
- **Fragile tests**: Tests that break with minor refactoring
- **Slow tests**: Tests that take excessive time due to poor design

## Output Format Requirements

### File Organization

Generate one test file per source module:

- File name: `test_<source_module_name>.py`
- Location: Mirror source structure under `tests/` directory
- Include `conftest.py` if shared fixtures are needed

### Import Statement Organization

Organize imports in this order:

1. Standard library imports
2. Third-party imports (pytest, etc.)
3. Local application imports

Within each group, alphabetize imports.

### Test Structure Template

```python
"""Test module for <component_name>."""

# Standard library imports
from typing import Any

# Third-party imports
import pytest

# Local imports
from mylib import module_under_test


# Fixtures (if needed)
@pytest.fixture
def sample_data():
    """Provide sample test data."""
    return {"key": "value"}


# Test classes (optional, for grouping)
class TestComponentName:
    """Tests for ComponentName."""

    def test_specific_behavior_under_condition_produces_result(self):
        """Test that specific behavior produces expected result."""
        # Arrange
        input_data = "test"
        expected = "expected_output"

        # Act
        result = module_under_test.function(input_data)

        # Assert
        assert result == expected


# Standalone tests
def test_function_with_valid_input_returns_correct_output():
    """Test function with valid input."""
    # Arrange
    value = 42

    # Act
    result = module_under_test.another_function(value)

    # Assert
    assert result > 0
```

### Documentation Requirements

- Module docstring: Brief description of what's being tested
- Test docstrings: Only when the test name isn't self-explanatory
- Fixture docstrings: Describe what the fixture provides
- Class docstrings: Describe the component being tested

## Success Criteria

Your generated tests should:

1. **Run successfully** with pytest out of the box
2. **Be readable** by someone unfamiliar with the code
3. **Fail meaningfully** with clear error messages when code breaks
4. **Remain stable** across refactoring of implementation details
5. **Execute quickly** to encourage frequent running
6. **Cover critical paths** with purposeful test scenarios
7. **Require minimal maintenance** when functionality changes

Remember: The goal is not to maximize test count or coverage percentage, but to provide confidence that the code works correctly and will continue to work as it evolves.
