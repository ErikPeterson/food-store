# POST /api/v1/stock_units

Request:

```
Headers
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQ4NjI0OTExLCJleHAiOjE1NDg3MTEzMTEsImp0aSI6IjhkNWQxOGVkLWE4NTctNGViNi1iNmNiLTNjMzVjYWQzOWNhZCJ9.tfAVzah8JE9Qhfs_asGmljz_Eg0ooc68vid71ewxE2c

Body
{
  "stock_unit": {
    "stock_unit_type_name": "coffee",
    "description": "Yirga Cheffe",
    "mass_in_grams": 150,
    "expiration_date": "2019-03-10",
    "unit_attributes": {
      "cupping score": 99,
      "tasting notes": "very tasty :)",
      "variety": "Arabica"
    }
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
  "stock_unit": {
    "id": 2,
    "owner_id": 1,
    "description": "Yirga Cheffe",
    "expiration_date": "2019-03-10",
    "created_at": "2019-01-27T21:53:16.162Z",
    "unit_attributes": {
      "cupping score": 99,
      "tasting notes": "very tasty :)",
      "variety": "Arabica"
    },
    "stock_unit_type_name": "coffee",
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

# POST /api/v1/stock_units/:id

Request:

```
Headers
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQ4NjI0OTExLCJleHAiOjE1NDg3MTEzMTEsImp0aSI6IjhkNWQxOGVkLWE4NTctNGViNi1iNmNiLTNjMzVjYWQzOWNhZCJ9.tfAVzah8JE9Qhfs_asGmljz_Eg0ooc68vid71ewxE2c

Body
{
  "stock_unit": {
    "description": "Yirga Cheffe from a specific place",
    "mass_in_grams": 151,
    "expiration_date": "2019-04-10",
    "unit_attributes": {
      "cupping score": 80,
      "tasting notes": "very tasty and specific :)",
      "variety": "Arabica"
    }
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
  "stock_unit": {
    "id": 2,
    "owner_id": 1,
    "description": "Yirga Cheffe from a specific place",
    "expiration_date": "2019-04-10",
    "created_at": "2019-01-27T21:53:16.162Z",
    "unit_attributes": {
      "cupping score": 80,
      "tasting notes": "very tasty and specific :)",
      "variety": "Arabica"
    },
    "stock_unit_type_name": "coffee",
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

# GET /api/v1/stock_units/:id

Request:

```
Headers
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQ4NjI0OTExLCJleHAiOjE1NDg3MTEzMTEsImp0aSI6IjhkNWQxOGVkLWE4NTctNGViNi1iNmNiLTNjMzVjYWQzOWNhZCJ9.tfAVzah8JE9Qhfs_asGmljz_Eg0ooc68vid71ewxE2c
```

Response:

```
Status 200

Headers
Content-Type: application/json

Body
{
  "stock_unit": {
    "id": 2,
    "owner_id": 1,
    "description": "Yirga Cheffe from a specific place",
    "expiration_date": "2019-04-10",
    "created_at": "2019-01-27T21:53:16.162Z",
    "unit_attributes": {
      "cupping score": 80,
      "tasting notes": "very tasty and specific :)",
      "variety": "Arabica"
    },
    "stock_unit_type_name": "coffee",
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

# DELETE /api/v1/stock_units/:id

Request:

```
Headers
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQ4NjI0OTExLCJleHAiOjE1NDg3MTEzMTEsImp0aSI6IjhkNWQxOGVkLWE4NTctNGViNi1iNmNiLTNjMzVjYWQzOWNhZCJ9.tfAVzah8JE9Qhfs_asGmljz_Eg0ooc68vid71ewxE2c
```

Response:

```
Status 204
```