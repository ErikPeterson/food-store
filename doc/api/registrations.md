# POST /signup

Request:

```
Headers

Content-Type: application/json

Body

{
  "user": {
    "email": "eriksalgstrom@gmail.com",
    "password": "123456"
  }
}
```

Response:

```
Status 200

Body
{
  "user": {
    "id": 1,
    "email": "eriksalgstrom@gmail.com",
    "created_at": "2019-01-27T21:34:24.677Z",
    "updated_at": "2019-01-27T21:34:24.677Z"
  }
}
```