# POST /api/v1/stock_unit_types

Request:

```
Headers

Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQ4NjI0OTExLCJleHAiOjE1NDg3MTEzMTEsImp0aSI6IjhkNWQxOGVkLWE4NTctNGViNi1iNmNiLTNjMzVjYWQzOWNhZCJ9.tfAVzah8JE9Qhfs_asGmljz_Eg0ooc68vid71ewxE2c

Body

{
  "stock_unit_type": {
    "name": "coffee",
    "schema": [
      [
        "cupping score",
        "RangeType",
        1,
        100
      ],
      [
        "tasting notes",
        "TextType"
      ],
      [
        "variety",
        "ListType",
        "Arabica",
        "Robusto"
      ]
    ]
  }
}
```

Response:

```
Status 200

Headers
Content-Type: application/json

Body
{
  "stock_unit_type": {
    "id": 1,
    "name": "coffee",
    "schema": [
      [
        "cupping score",
        "RangeType",
        1,
        100
      ],
      [
        "tasting notes",
        "TextType"
      ],
      [
        "variety",
        "ListType",
        "Arabica",
        "Robusto"
      ]
    ]
  }
}
```