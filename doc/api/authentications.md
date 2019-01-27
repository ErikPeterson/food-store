# POST /login

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
Headers

Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQ4NjI0OTExLCJleHAiOjE1NDg3MTEzMTEsImp0aSI6IjhkNWQxOGVkLWE4NTctNGViNi1iNmNiLTNjMzVjYWQzOWNhZCJ9.tfAVzah8JE9Qhfs_asGmljz_Eg0ooc68vid71ewxE2c
ETag: W/"b1548e14e3958a45513fad4c9857e684

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