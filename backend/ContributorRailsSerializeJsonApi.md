### Serialize JSON:API

```
bundle add jsonapi-serializer

bundle install
```

The JSON:API documentation gives us some rules to follow regarding the formatting of the JSON document.

Thus, our document must contain these keys:

• data: which must contain the data we send back
• errors which must contain an array of errors that have occurred
• meta which contains a meta object

## Serialize

```
rails generate serializer User email
```
