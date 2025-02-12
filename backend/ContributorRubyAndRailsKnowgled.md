# Ruby

### I. The `&.` operator in Ruby

- "safe navigation operator"
- It's a way to safely chain method calls when an object might be nil.

Let's break down `@user&.authenticate(user_params[:password])`

1. Without `&.` raise NoMethodError if @user is nil

```
@user.authenticate(password)  # This would raise NoMethodError if @user is nil
```

2. With `&.` This returns nil if @user is nil

```
@user&.authenticate(password)  # This returns nil if @user is nil
```

3. Real-world example:

```
# Without safe navigation operator
def full_name
  if user
    if user.profile
      user.profile.full_name
    end
  end
end

# With safe navigation operator
def full_name
  user&.profile&.full_name
end
```

### II. The `!` operator in Ruby

`!` methods raise exceptions when something goes wrong

Example

```
create!      # Raises if validation fails
update!      # Raises if validation fails
save!        # Raises if validation fails
find!        # Raises if record not found
first!       # Raises if no records exist
last!        # Raises if no records exist
```

### Rescue in Ruby

The `rescue` keyword in Ruby is used for error handling - it's similar to `try/catch` in other programming languages.

```
def self.decode(token)
  decode = JWT.decode(token, SECRET_KEY).first
  HashWithIndifferentAccess.new decoded
rescue JWT::DecodeError  # If JWT decoding fails
  nil                    # Return nil instead of crashing
end
```

Another example

```
def divide_numbers(a, b)
  result = a / b
  puts "Result: #{result}"
rescue ZeroDivisionError
  puts "Can't divide by zero!"
rescue TypeError
  puts "Please provide numbers only!"
end
```

divide_numbers(10, 0) # Prints: "Can't divide by zero!"
divide_numbers(10, "a") # Prints: "Please provide numbers only!"
divide_numbers(10, 2) # Prints: "Result: 5"
