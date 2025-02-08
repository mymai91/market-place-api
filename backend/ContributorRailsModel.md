# Generate model

1. Generate

```
$ rails generate model User email:string password_digest:string invoke active_record
```

2. Undo generate mode

```
rails destroy model User
```

3. Add Index

```
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.index :email, unique: true
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
```

Use Index for `email`

Adding an index on the email column in the users table serves two main purposes:

_1._ Faster Lookups
In a typical authentication system, users log in using their email.
Every time a login request is made, the database queries for the user by email:

```
SELECT * FROM users WHERE email = 'user@example.com' LIMIT 1;
```

Without an index, the database performs a full table scan, meaning it checks every row in the users table.
With an indexed email column, the database can quickly find the email, making lookups much faster.

_2._ Ensuring Uniqueness

4. Run migrate

Run migrate

```
rails db:migrate
```

Rollback

```
rails db:rollback
```

# Password and password_digest in Rails

Let me explain the relationship between `password` and `password_digest` in Rails:

1. password_digest in the database:

In your migration

```
create_table :users do |t|
  t.string :password_digest  # This is the database column
end
```

2. has_secure_password in the model:

```
class User < ApplicationRecord
  has_secure_password  # This creates virtual password attribute
end
```

When you use `has_secure_password`, here's what happens:

1. Virtual Attributes:

```
user = User.new(email: "test@example.com", password: "123456")
# 'password' is a virtual attribute - it exists in memory but not in database
# The actual value "123456" never gets stored in the database
```

2. Behind the scenes:

When you set password:

```
user.password = "123456"
# has_secure_password automatically:
# 1. Takes "123456"
# 2. Uses bcrypt to hash it
# 3. Stores the hash in password_digest
```

3. For authentication:

```
user = User.find_by(email: "test@example.com")
user.authenticate("123456")  # Returns user if password correct, false if wrong
```

Think of it like:

- password: What the user types in (plain text, temporary)
- password_digest: What gets stored (hashed, permanent)

It's like having a one-way door:

You can go from password → password_digest easily
You can't go from password_digest back to password
You can only verify if a given password matches the digest
