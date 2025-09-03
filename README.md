# RSpec: Custom Error Messages & Helper Methods: Making Specs Clear (and Kind)

Have you ever run a test, seen a failure, and thought, “What does that even mean?” Custom error messages and helper methods are your tools for making specs readable, helpful, and even a little bit friendly. In this lesson, we’ll show you how to add custom messages to your expectations and write helper methods to keep your specs DRY, clear, and easy to debug.

---

## Why Add Custom Error Messages?

RSpec’s default failure messages are good, but sometimes you want to be even clearer about what went wrong. Custom error messages let you:

- Explain the intent of your test in plain English
- Give yourself (or your teammates) a helpful nudge in the right direction
- Make debugging less mysterious and more actionable

## How to Add a Custom Error Message

Just add a string as the second argument to your `expect(...).to` statement:

```ruby
# /spec/custom_error_spec.rb
expect(plot.plants).to include(tomato), "Expected plot to include Tomato, but got: #{plot.plants.map(&:name)}"
```

**Expected RSpec Output:**

```text
Failure/Error: expect(plot.plants).to include(tomato), "Expected plot to include Tomato, but got: #{plot.plants.map(&:name)}"

  Expected plot to include Tomato, but got: ["Carrot", "Lettuce"]
```

---

### More Custom Error Message Examples

Here are additional examples using our garden domain to show different types of custom messages:

```ruby
# /spec/custom_error_spec.rb
expect(plot.tallest_plant.name).to eq('Sunflower'), "Tallest plant should be Sunflower, got #{plot.tallest_plant.name}"
```

**Expected Output (if tallest plant is actually Tomato):**

```text
Failure/Error: expect(plot.tallest_plant.name).to eq('Sunflower'), "Tallest plant should be Sunflower, got #{plot.tallest_plant.name}"

  Tallest plant should be Sunflower, got Tomato
```

```ruby
# /spec/custom_error_spec.rb
expect(plot.all_watered?).to eq(true), "All plants should be watered"
```

**Expected Output (if some plants aren't watered):**

```text
Failure/Error: expect(plot.all_watered?).to eq(true), "All plants should be watered"

  All plants should be watered
```

```ruby
# /spec/custom_error_spec.rb
expect(tomato.height).to be_between(1, 5), "Tomato height should be between 1 and 5, but was #{tomato.height}"
```

**Expected Output (if tomato height is 8):**

```text
Failure/Error: expect(tomato.height).to be_between(1, 5), "Tomato height should be between 1 and 5, but was #{tomato.height}"

  Tomato height should be between 1 and 5, but was 8
```

```ruby
# /spec/custom_error_spec.rb
expect(tomato.watered).to eq(true), "Expected Tomato to be watered, but it wasn't"
```

**Expected Output (if tomato isn't watered):**

```text
Failure/Error: expect(tomato.watered).to eq(true), "Expected Tomato to be watered, but it wasn't"

  Expected Tomato to be watered, but it wasn't
```

---

## Helper Methods: Keeping Your Specs DRY

Helper methods let you extract repeated logic and make your tests more readable. Define them directly in your spec files or in shared contexts.

### Basic Helper Method Example

```ruby
# /spec/custom_error_spec.rb
def water_and_grow(plant, sunlight: 0)
  plant.water!
  plant.give_sunlight(sunlight)
  plant.grow!
end

RSpec.describe GardenPlot do
  it "waters and grows a plant with helper" do
    carrot = Plant.new('Carrot', height: 2)
    expect { water_and_grow(carrot, sunlight: 4) }.to change { carrot.height }.by(2)
  end
end
```

### String Manipulation Helper Example

```ruby
# /spec/string_manipulator_spec.rb
def reverse_and_upcase(str)
  str.reverse.upcase
end

RSpec.describe "String manipulation" do
  it "reverses and upcases a string" do
    result = reverse_and_upcase("hello")
    expect(result).to eq("OLLEH")
  end
end
```

**Expected Output (if the method works correctly):**

```text
String manipulation
  reverses and upcases a string

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

**If the method is broken (e.g., only does upcase):**

```text
Failure/Error: expect(result).to eq("OLLEH")

  expected: "OLLEH"
       got: "HELLO"

  (compared using ==)
```

### Advanced Helper Example (with arguments and let)

Helper methods can take arguments, return values, and even use `let` or instance variables if needed. Just remember: keep them simple and focused on making your tests easier to read.

```ruby
# /spec/custom_error_spec.rb
let(:plot) { GardenPlot.new }
let(:carrot) { Plant.new('Carrot', height: 2) }

def water_and_grow(plant, sunlight: 0)
  plant.water!
  plant.give_sunlight(sunlight)
  plant.grow!
end

RSpec.describe 'helper methods for repeated logic' do
  it 'helper methods for repeated logic' do
    expect { water_and_grow(carrot, sunlight: 4) }.to change { carrot.height }.by(2)
  end
end
```

**Expected Output:**

```text
helper methods for repeated logic
  helper methods for repeated logic

Finished in 0.01 seconds (files took 0.1 seconds to load)
2 examples, 0 failures
```

## When to Use Custom Messages and Helpers

- Use custom error messages when the default message isn’t clear enough, or when you want to add extra context. But be careful: overly verbose messages can actually obscure the intent of your test. Aim for clarity and brevity—your message should make the failure easier to understand, not harder.
- Use helper methods when you have repeated logic or want to make your tests more expressive. Helpers, `let`, and before/after hooks all work together to keep your specs DRY and maintainable.
- Don’t overdo it! Too many custom messages or helpers can make your specs harder to follow. Always prioritize clarity and simplicity.

---

## Getting Hands-On: Student Instructions

This lesson repo is set up for you to get hands-on practice with RSpec's custom error messages and helper methods using a real-world garden domain (GardenPlot/Plant).

**To get started:**

1. **Fork and Clone** this repository to your own GitHub account and local machine.
2. **Install dependencies:**

    ```sh
    bundle install
    ```

3. **Run the specs:**

    ```sh
    bin/rspec
    ```

4. **Explore the code:**

   - The main domain code is in `lib/garden_plot.rb`.
   - The robust example specs are in `spec/custom_error_spec.rb`.

5. **Implement the pending specs:**

   - There are at least two pending specs marked with `pending` in `spec/custom_error_spec.rb`.
   - Your task: Remove the `pending` line and implement the expectation so the spec passes.

6. **Experiment:**

   - Try adding your own examples using custom error messages and helper methods.
   - Make the specs fail on purpose to see the error messages and learn from them.

All specs should pass except the pending ones. When you finish, all specs should be green!

---

## Resources

- [RSpec Expectations: Custom Failure Messages](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/eq-matcher#adding-a-custom-failure-message)
- [Better Specs: Custom Messages](https://www.betterspecs.org/#messages)
- [RSpec: Helper Methods](https://relishapp.com/rspec/rspec-core/v/3-10/docs/example-groups/shared-context)

---

## What's Next?

Lab 3 follows this lesson! In Lab 3, you'll get to refactor messy specs using helper methods, `let`, and hooks. This is your chance to practice making your tests DRY, clear, and maintainable before moving on.
