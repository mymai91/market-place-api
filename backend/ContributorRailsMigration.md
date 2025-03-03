# Migration

Auto generate migration

```
rails g model User email:string password_digest:string

```

Update migration

```
rails g migration add_quantity_to_products quantity:integer
```

```
rails db:migrate
```
