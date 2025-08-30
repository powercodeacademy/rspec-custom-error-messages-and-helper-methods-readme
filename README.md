# RSpec: Custom Error Messages & Helper Methods: Making Specs Clear (and Kind)

Welcome to Lesson 8! Have you ever run a test, seen a failure, and thought, “What does that even mean?” Custom error messages and helper methods are your tools for making specs readable, helpful, and even a little bit friendly. In this lesson, we’ll show you how to add custom messages to your expectations and write helper methods to keep your specs DRY, clear, and easy to debug.

---

## Why Add Custom Error Messages?

RSpec’s default failure messages are good, but sometimes you want to be even clearer about what went wrong. Custom error messages let you:

- Explain the intent of your test in plain English
- Give yourself (or your teammates) a helpful nudge in the right direction
- Make debugging less mysterious and more actionable

## How to Add a Custom Error Message

Just add a string as the second argument to your `expect(...).to` statement:

```ruby
# /spec/calculator_spec.rb
expect(Calculator.new.add(2, 2)).to eq(5), "Expected 2 + 2 to equal 5, but got something else!"
```

**Expected RSpec Output:**

```text
Failure/Error: expect(Calculator.new.add(2, 2)).to eq(5), "Expected 2 + 2 to equal 5, but got something else!"

  Expected 2 + 2 to equal 5, but got something else!
```

---

### More Examples

```ruby
# /spec/user_spec.rb
expect(user.name).to eq("Alice"), "User's name should be Alice, but was #{user.name.inspect}"
```

**Expected Output (if user.name is "Bob"):**

```text
Failure/Error: expect(user.name).to eq("Alice"), "User's name should be Alice, but was #{user.name.inspect}"

  User's name should be Alice, but was "Bob"
```

```ruby
# /spec/cart_spec.rb
expect(cart.items.count).to eq(3), "Cart should have 3 items, but had #{cart.items.count}"
```

**Expected Output (if cart.items.count is 1):**

```text
Failure/Error: expect(cart.items.count).to eq(3), "Cart should have 3 items, but had #{cart.items.count}"

  Cart should have 3 items, but had 1
```

---

### Even More Examples

```ruby
# /spec/temperature_spec.rb
expect(temperature).to be_between(65, 75), "Temperature should be comfortable, but was #{temperature}F"
```

**Expected Output (if temperature is 80):**

```text
Failure/Error: expect(temperature).to be_between(65, 75), "Temperature should be comfortable, but was #{temperature}F"

  Temperature should be comfortable, but was 80F
```

```ruby
# /spec/api_spec.rb
expect(response.status).to eq(200), "Expected a 200 OK response, got #{response.status} instead."
```

**Expected Output (if response.status is 404):**

```text
Failure/Error: expect(response.status).to eq(200), "Expected a 200 OK response, got #{response.status} instead."

  Expected a 200 OK response, got 404 instead.
```

## Writing Helper Methods in Specs

If you find yourself repeating the same logic in multiple tests, it’s time for a helper method! You can define helper methods inside your spec files (outside of your `it` blocks) to keep your tests DRY and readable. Helpers are a great complement to before/after hooks and `let`—all are tools for reducing repetition and clarifying intent.

> **Note:** Helper methods defined in one spec file are not shared with other spec files unless you explicitly include them (e.g., by using `require_relative` or shared context). Keep helpers local unless you have a good reason to share them.

### Simple Helper Example

```ruby
# /spec/string_manipulator_spec.rb
def reverse_and_upcase(str)
  str.reverse.upcase
end

RSpec.describe StringManipulator do
  it "reverses and upcases a string" do
    result = reverse_and_upcase("hello")
    expect(result).to eq("OLLEH")
  end
end
```

**Expected Output (if the method is correct):**

```text
StringManipulator
  reverses and upcases a string

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

**If the method is broken (returns str.upcase):**

```text
Failure/Error: expect(result).to eq("OLLEH")

  expected: "OLLEH"
       got: "HELLO"

  (compared using ==)
```

### Advanced Helper Example (with arguments and let)

Helper methods can take arguments, return values, and even use `let` or instance variables if needed. Just remember: keep them simple and focused on making your tests easier to read.

```ruby
# /spec/math_helper_spec.rb
let(:factor) { 2 }

def add_and_multiply(a, b)
  (a + b) * factor
end

RSpec.describe "add_and_multiply helper" do
  it "adds and multiplies numbers" do
    expect(add_and_multiply(2, 3)).to eq(10)
    expect(add_and_multiply(1, 1)).to eq(4)
  end
end
```

**Expected Output:**

```text
add_and_multiply helper
  adds and multiplies numbers

Finished in 0.01 seconds (files took 0.1 seconds to load)
2 examples, 0 failures
```

## When to Use Custom Messages and Helpers

- Use custom error messages when the default message isn’t clear enough, or when you want to add extra context. But be careful: overly verbose messages can actually obscure the intent of your test. Aim for clarity and brevity—your message should make the failure easier to understand, not harder.
- Use helper methods when you have repeated logic or want to make your tests more expressive. Helpers, `let`, and before/after hooks all work together to keep your specs DRY and maintainable.
- Don’t overdo it! Too many custom messages or helpers can make your specs harder to follow. Always prioritize clarity and simplicity.

## Practice Prompts

1. Add a custom error message to a failing expectation. What does the output look like?
2. Refactor a spec to use a helper method for repeated logic. How does it change the readability?
3. Write a helper method that takes arguments and returns a value. Use it in at least two examples.
4. When might a custom error message be more helpful than the default? Write your answer in your own words.

---

## Resources

- [RSpec Expectations: Custom Failure Messages](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/eq-matcher#adding-a-custom-failure-message)
- [Better Specs: Custom Messages](https://www.betterspecs.org/#messages)
- [RSpec: Helper Methods](https://relishapp.com/rspec/rspec-core/v/3-10/docs/example-groups/shared-context)

---

## What's Next?

Lab 3 follows this lesson! In Lab 3, you'll get to refactor messy specs using helper methods, `let`, and hooks. This is your chance to practice making your tests DRY, clear, and maintainable before moving on.
