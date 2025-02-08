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
