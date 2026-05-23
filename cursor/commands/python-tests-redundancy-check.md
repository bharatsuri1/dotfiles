# Prompt: Identify Redundancies in Python Test Code

## Objective

Analyze Python test code to identify and report redundant tests, duplicate test logic, overlapping test coverage, and opportunities for test consolidation. The goal is to maintain high-quality, maintainable test suites that follow industry best practices while eliminating unnecessary duplication.

## Context

You are analyzing Python test files that may use:

- `unittest.TestCase` framework
- `pytest` framework
- Both frameworks within the same codebase
- Bazel build system for test execution

## Industry Standards & Principles

Apply the following testing principles when identifying redundancies:

1. **DRY (Don't Repeat Yourself)**: Tests should not duplicate the same logic or assertions
2. **Test Independence**: Each test should verify a distinct behavior or edge case
3. **Single Responsibility**: Each test should focus on one specific aspect of functionality
4. **Test Clarity**: Test names should clearly indicate what is being tested
5. **Maintainability**: Redundant tests increase maintenance burden and reduce code quality
6. **Coverage Efficiency**: Multiple tests covering the same code paths without adding value are redundant

## Types of Redundancies to Identify

### 1. **Duplicate Test Cases**

- Tests with identical or near-identical logic that verify the same behavior
- Tests that differ only in variable names or values but test the same code path
- Multiple tests asserting the same outcome with no meaningful difference
- Tests that verify identical business logic with different test data that doesn't exercise different code paths

**Example of redundancy:**

```python
# test_user_service.py
def test_create_user_with_valid_email():
    service = UserService()
    user = service.create_user(
        username="john_doe",
        email="john@example.com",
        password="SecurePass123!"
    )
    assert user.username == "john_doe"
    assert user.email == "john@example.com"
    assert user.is_active is True

def test_user_creation_success():
    service = UserService()
    user = service.create_user(
        username="jane_smith",
        email="jane@example.com",
        password="AnotherPass456!"
    )
    assert user.username == "jane_smith"
    assert user.email == "jane@example.com"
    assert user.is_active is True
    # Same validation logic, same code path, only input values differ
```

**More subtle example:**

```python
# test_api_client.py
def test_get_request_with_headers():
    client = APIClient(base_url="https://api.example.com")
    headers = {"Authorization": "Bearer token123"}
    response = client.get("/users", headers=headers)
    assert response.status_code == 200
    assert "data" in response.json()

def test_api_get_with_auth_header():
    client = APIClient(base_url="https://api.example.com")
    headers = {"Authorization": "Bearer token123"}
    result = client.get("/users", headers=headers)
    assert result.status_code == 200
    assert "data" in result.json()
    # Identical test logic, only variable names differ (response vs result)
```

### 2. **Overlapping Test Coverage**

- Tests that exercise the same code paths with different inputs but don't add unique value
- Tests that verify the same behavior at different levels of abstraction (e.g., unit test and integration test covering identical logic)
- Multiple tests for the same edge case or boundary condition
- Tests that validate the same validation rules or business constraints

**Example of redundancy:**

```python
# test_validation.py
def test_validate_email_format_rejects_invalid():
    validator = EmailValidator()
    result = validator.validate("not-an-email")
    assert result.is_valid is False
    assert "invalid format" in result.error_message

def test_email_validator_rejects_malformed_email():
    validator = EmailValidator()
    result = validator.validate("bad-email-format")
    assert result.is_valid is False
    assert "invalid format" in result.error_message
    # Both test the same validation rule with equivalent invalid inputs

# test_cache_service.py
def test_cache_expiration_after_ttl():
    cache = CacheService(ttl_seconds=60)
    cache.set("key1", "value1")
    time.sleep(61)
    assert cache.get("key1") is None

def test_cache_entry_expires_after_timeout():
    cache = CacheService(ttl_seconds=60)
    cache.set("key2", "value2")
    time.sleep(61)
    assert cache.get("key2") is None
    # Same expiration logic tested with different keys - no unique coverage
```

**Integration vs Unit test overlap:**

```python
# test_unit.py - Unit test
@mock.patch('requests.post')
def test_send_notification_calls_api(mock_post):
    service = NotificationService()
    service.send_notification("user@example.com", "Hello")
    mock_post.assert_called_once_with(
        "https://api.notify.com/send",
        json={"email": "user@example.com", "message": "Hello"}
    )

# test_integration.py - Integration test
def test_notification_service_sends_email():
    service = NotificationService()
    # Uses real API but tests identical logic path
    result = service.send_notification("user@example.com", "Hello")
    assert result.success is True
    # If the integration test only verifies the same code path without
    # testing network failures, retries, or other integration concerns,
    # it may be redundant with the unit test
```

### 3. **Redundant Test Fixtures and Setup**

- Duplicate setup/teardown code that could be consolidated
- Repeated fixture creation that tests the same preconditions
- Similar test data preparation that could be parameterized
- Multiple tests that create identical test fixtures or database states

**Example of redundancy:**

```python
# test_order_processing.py
def test_process_order_with_discount():
    # Extensive setup duplicated across tests
    customer = Customer(id=1, name="John", email="john@example.com", tier="premium")
    product = Product(id=100, name="Widget", price=50.00, in_stock=True)
    inventory = InventoryService()
    inventory.add_product(product, quantity=100)
    order = Order(customer=customer, items=[OrderItem(product=product, quantity=2)])
    discount = DiscountService().get_discount(customer.tier)

    processor = OrderProcessor()
    result = processor.process(order, discount)
    assert result.total == 90.00  # 50% discount applied

def test_process_order_with_shipping():
    # Identical setup repeated
    customer = Customer(id=1, name="John", email="john@example.com", tier="premium")
    product = Product(id=100, name="Widget", price=50.00, in_stock=True)
    inventory = InventoryService()
    inventory.add_product(product, quantity=100)
    order = Order(customer=customer, items=[OrderItem(product=product, quantity=2)])
    discount = DiscountService().get_discount(customer.tier)

    processor = OrderProcessor()
    result = processor.process(order, discount)
    assert result.shipping_cost == 10.00
    # Same 15+ lines of setup, should use fixtures or setUp method
```

**Pytest fixture redundancy:**

```python
# test_database_operations.py
@pytest.fixture
def db_connection():
    conn = create_test_connection()
    yield conn
    conn.close()

def test_insert_user(db_connection):
    # Uses fixture
    db_connection.execute("INSERT INTO users VALUES (...)")

@pytest.fixture
def database():
    conn = create_test_connection()
    yield conn
    conn.close()

def test_update_user(database):
    # Identical fixture with different name
    database.execute("UPDATE users SET ...")
```

### 4. **Parameterizable Test Patterns**

- Multiple tests that follow the same pattern and differ only in input/output values
- Tests that could be consolidated using `@pytest.mark.parametrize` or `unittest.subTest`
- Sequential tests that verify similar logic with different data
- Tests that validate the same business rule with different input combinations

**Example of redundancy (should be parameterized):**

```python
# test_permissions.py
def test_admin_can_access_admin_panel():
    user = User(role="admin")
    permissions = PermissionChecker(user)
    assert permissions.can_access("admin_panel") is True

def test_manager_cannot_access_admin_panel():
    user = User(role="manager")
    permissions = PermissionChecker(user)
    assert permissions.can_access("admin_panel") is False

def test_user_cannot_access_admin_panel():
    user = User(role="user")
    permissions = PermissionChecker(user)
    assert permissions.can_access("admin_panel") is False

def test_guest_cannot_access_admin_panel():
    user = User(role="guest")
    permissions = PermissionChecker(user)
    assert permissions.can_access("admin_panel") is False
    # Should be: @pytest.mark.parametrize("role,expected", [("admin", True), ...])

# test_data_transformation.py
def test_transform_date_format_iso_to_us():
    transformer = DateTransformer()
    result = transformer.transform("2024-01-15", from_format="ISO", to_format="US")
    assert result == "01/15/2024"

def test_transform_date_format_iso_to_european():
    transformer = DateTransformer()
    result = transformer.transform("2024-01-15", from_format="ISO", to_format="EU")
    assert result == "15/01/2024"

def test_transform_date_format_iso_to_uk():
    transformer = DateTransformer()
    result = transformer.transform("2024-01-15", from_format="ISO", to_format="UK")
    assert result == "15/01/2024"
    # Same transformation logic, only output format differs
```

### 5. **Redundant Assertions**

- Multiple assertions in the same test that verify the same condition
- Assertions that are logically equivalent or test the same state
- Overlapping validation checks
- Assertions that test derived properties when the source property is already tested

**Example of redundancy:**

```python
# test_api_response.py
def test_api_response_structure():
    response = api_client.get("/users/123")
    assert response.status_code == 200
    assert response.ok is True  # Redundant: ok is True when status_code == 200
    assert response.json() is not None
    data = response.json()
    assert "id" in data
    assert data.get("id") is not None  # Redundant: already checked with "in"
    assert data["id"] == 123  # This is the meaningful assertion

# test_user_model.py
def test_user_activation():
    user = User(email="test@example.com", is_active=False)
    user.activate()
    assert user.is_active is True
    assert user.is_active == True  # Redundant: same boolean check
    assert not user.is_active is False  # Redundant: logically equivalent
    assert user.deactivated_at is None  # This adds value - different property

# test_validation.py
def test_validate_required_fields():
    validator = FormValidator()
    result = validator.validate({"name": "", "email": "test@example.com"})
    assert result.is_valid is False
    assert result.has_errors is True  # Redundant if is_valid=False implies has_errors=True
    assert len(result.errors) > 0  # Redundant if has_errors already checked
    assert "name" in result.errors  # This is the meaningful assertion
```

### 6. **Dead or Unreachable Test Code**

- Test methods that are never executed due to conditional logic
- Tests that are commented out but have active equivalents
- Test code that cannot be reached due to early returns or exceptions
- Test methods that are conditionally skipped but have equivalent active tests

**Example of redundancy:**

```python
# test_authentication.py
def test_login_with_valid_credentials():
    auth_service = AuthService()
    result = auth_service.login("user@example.com", "password123")
    assert result.success is True
    assert result.token is not None

# This test is never executed due to environment check
@pytest.mark.skipif(os.getenv("ENV") != "test", reason="Only run in test env")
def test_user_login_success():
    auth_service = AuthService()
    result = auth_service.login("user@example.com", "password123")
    assert result.success is True
    assert result.token is not None
    # Redundant: same test logic, but skipped in most environments

# test_data_processing.py
def test_process_data_with_valid_input():
    processor = DataProcessor()
    data = {"field1": "value1", "field2": "value2"}
    result = processor.process(data)
    assert result.processed is True

# Commented out but has active equivalent
# def test_data_processing_success():
#     processor = DataProcessor()
#     data = {"field1": "value1", "field2": "value2"}
#     result = processor.process(data)
#     assert result.processed is True

# test_error_handling.py
def test_handle_error_gracefully():
    service = ErrorProneService()
    try:
        service.operation_that_fails()
        assert False, "Should have raised exception"
    except ServiceError as e:
        assert e.error_code == "E001"
        return  # Early return prevents code below from executing

    # This code is unreachable
    assert service.get_last_error() is not None
```

### 7. **Semantic Duplicates**

- Tests with different names but identical or equivalent test logic
- Tests that verify the same behavior using different assertion styles
- Tests that check the same post-condition through different means
- Tests that validate equivalent conditions through different API methods or properties

**Example of redundancy:**

```python
# test_cache.py
def test_cache_is_empty_after_clear():
    cache = CacheService()
    cache.set("key1", "value1")
    cache.set("key2", "value2")
    cache.clear()
    assert cache.size() == 0

def test_cache_has_zero_items_after_clear():
    cache = CacheService()
    cache.set("key1", "value1")
    cache.set("key2", "value2")
    cache.clear()
    assert len(cache) == 0  # Semantically equivalent to size() == 0

def test_cache_is_empty_when_cleared():
    cache = CacheService()
    cache.set("key1", "value1")
    cache.clear()
    assert cache.is_empty() is True  # Same post-condition, different method

# test_database.py
def test_transaction_rollback_on_error():
    db = Database()
    db.begin_transaction()
    try:
        db.execute("INSERT INTO users VALUES (NULL)")  # Will fail
    except:
        db.rollback()
    assert db.in_transaction() is False
    assert db.get_transaction_count() == 0  # Redundant: both check transaction state

def test_transaction_not_active_after_rollback():
    db = Database()
    db.begin_transaction()
    db.rollback()
    assert not db.in_transaction()  # Semantically equivalent to above
```

## Analysis Guidelines

### When Analyzing Tests:

1. **Compare Test Logic, Not Just Names**: Look at what the test actually does, not just the test name. Two tests with different names may be redundant if they exercise identical code paths.

2. **Consider Test Intent**: Two tests might look similar but test different aspects (e.g., happy path vs. error handling, input validation vs. output correctness) - these are NOT redundant. Understand the business logic being tested.

3. **Evaluate Code Path Coverage**: Use static analysis to determine if tests exercise identical code paths. Consider:

   - Branch coverage: Do tests exercise different conditional branches?
   - Statement coverage: Do tests execute different lines of code?
   - Edge case coverage: Do tests validate different boundary conditions?

4. **Check Test Dependencies**: Tests that depend on each other's side effects may appear redundant but serve different purposes. However, tests that are truly independent but verify identical behavior are redundant.

5. **Assess Value Addition**: A test is redundant if removing it doesn't reduce:

   - Code coverage metrics
   - Confidence in correctness
   - Ability to catch regressions
   - Documentation value

6. **Review Test Granularity**: Multiple small tests may be preferable to one large test - distinguish between redundancy and appropriate granularity. However, if multiple small tests verify the exact same behavior, they may be redundant.

7. **Examine Test Data**: Different test data may serve different purposes if it exercises different code paths or validates different business rules. However, if test data variations don't change the code path or validation logic, the tests may be redundant.

8. **Consider Test Maintenance Cost**: Redundant tests increase maintenance burden. If updating one test requires updating multiple identical tests, they are likely redundant.

### What is NOT Redundant:

- Tests that verify different aspects of the same function (e.g., input validation vs. output correctness)
- Tests at different levels of the testing pyramid (unit vs. integration vs. e2e)
- Tests that verify different edge cases or boundary conditions
- Tests that check different error conditions or exception types
- Tests that validate different code paths or branches
- Tests that serve as regression tests for different bugs

## Output Format

For each identified redundancy, provide:

1. **Redundancy Type**: One of the categories listed above
2. **Location**: File path(s) and line number(s) of redundant tests
3. **Description**: Clear explanation of why these tests are redundant
4. **Evidence**: Specific code snippets showing the redundancy
5. **Recommendation**: Suggested action (merge, remove, parameterize, etc.)
6. **Confidence Level**: High, Medium, or Low confidence in the redundancy identification
7. **Impact Assessment**: Estimate of maintenance reduction and risk if tests are consolidated

### Output Structure:

````markdown
## Redundancy Report

### Redundancy #1: [Type]

- **Files**: `path/to/test_file1.py:10-15`, `path/to/test_file2.py:20-25`
- **Description**: [Clear explanation]
- **Evidence**:

  ```python
  # Test 1
  [code snippet]

  # Test 2
  [code snippet]
  ```
````

- **Recommendation**: [Specific action]
- **Confidence**: [High/Medium/Low]
- **Impact**: [Maintenance reduction and risk assessment]

```

## Additional Considerations

1. **Test Framework Context**: Consider framework-specific patterns:
   - Pytest fixtures vs. unittest setUp/tearDown methods
   - Pytest parametrization vs. unittest subTest
   - Different assertion styles (assert vs. unittest assertions)
   - Framework-specific decorators and markers

2. **Test Execution Order**: Be aware that some tests may depend on execution order (though this is an anti-pattern). Tests that appear redundant but depend on shared state may not actually be redundant, but they indicate a design issue.

3. **Mocking and Stubbing**: Tests with different mocks/stubs may not be redundant even if logic is similar:
   - Different mock behaviors test different scenarios
   - Different stub return values validate different code paths
   - However, identical mocks with identical test logic indicate redundancy

4. **Test Data**: Tests using different test data may serve different purposes:
   - Different data types test type handling
   - Boundary values test edge cases
   - Invalid data tests error handling
   - But equivalent test data with identical assertions indicate redundancy

5. **Documentation Value**: Some "redundant" tests may serve as documentation:
   - Examples for developers learning the codebase
   - Regression tests for specific bugs
   - However, this value should be weighed against maintenance cost

6. **Test Organization**: Consider whether tests are in the same file or different files:
   - Redundant tests in the same file are easier to consolidate
   - Redundant tests across files may indicate organizational issues
   - Cross-file redundancy may be acceptable if tests serve different test suites (unit vs. integration)

7. **Performance Considerations**: Multiple redundant tests increase test execution time. Consolidating them can improve CI/CD pipeline performance.

8. **Test Failure Isolation**: Parameterized tests may make it harder to identify which specific case failed. However, this is generally outweighed by the benefits of eliminating redundancy.

## Quality Criteria

A high-quality redundancy analysis should:
- Be thorough and identify all significant redundancies
- Provide actionable recommendations
- Distinguish between true redundancy and appropriate test coverage
- Consider the broader context of the test suite
- Prioritize redundancies by impact and confidence level
- Suggest improvements that maintain or improve test quality

## Instructions

1. Analyze the provided Python test code systematically
2. Identify all instances of redundancy using the criteria above
3. Group related redundancies together
4. Provide clear, actionable recommendations
5. Prioritize findings by confidence and impact
6. Be conservative - when in doubt, mark confidence as "Low" and explain the uncertainty

Begin your analysis now.

```
