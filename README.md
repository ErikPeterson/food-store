# README

## Installation

You will need to have PostgreSQL > 9, and Ruby at 2.5.0 installed. Postgres installation is very platform specific, so I won't give instructions here. However, I will reccomend the use of [RVM](https://rvm.io) to install Ruby and manage gemsets.

If you don't already have bundler installed, install with `gem install bundler`.

To set up, first clone this repository and enter the project directory.

We need to provision the app with the secret key used for signing JWTs. We'll use a `.env` file in the project directory to do so. Run `rails secret` to generate a key, then copy and paste the resulting key into your `.env` file like so:

```
DEVISE_JWT_SECRET_KEY=YOUR_KEY_HERE
```

Then run the following commands in the project directory:

```
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec rails s
```

This will install dependencies, create the local database, seed it with a base set of data, and start a server at `localhost:3000`

To run the test suite, run `rspec` in the project directory

## Data Model

### StockUnitType

A `StockUnitType` record describes the schema and name for a particular type. The `schema` attribute is an array of arrays, with the first member of each array being the name of the attribute, the second being the type/validator for the attribute, and the remaining members any required criteria for validating StockUnit attribute values against the type. The available types are `ListType`, `RangeType` and `TextType`. The `ListType` defines a set of allowed values for the attribute as its criteria. The `RangeType` accepts two numbers for its criteria, the attribute value must be between these two numbers (inclusive). The `TextType` allows an arbitrary text value, but does not allow any non-string values.

For example, the folowing:

```
StockUnitType.create!({
    name: 'coffee',
    schema: [
        [ 'cupping score', 'RangeType', 1, 100 ],
        [ 'tasting notes', 'TextType'],
        [ 'variety', 'ListType', 'Arabica', 'Robusto']
    ]
})
```

defines a type with three attributes. `cupping score` must be a number between 1 and 100, inclusive, 'tasting notes' can be an arbitrary string, and 'variety' must be one of the three listed values.

This definition:

```
StockUnitType.create!({
    name: 'fish',
    schema: [
        [ 'rating', 'RangeType', 100, 1 ],
        [ 'catch coordinates', 'LatLongType' ],
        [ 'species', 'ListType' ]
    ]
})
```

Will result in a validation error because `RangeType` criteria must be in order of smallest to largest, `LatLongType` is not a defined type, and `ListType` requires a list of allowed values as its criteria. All of the available types are stored in `app/services`, and use a standard interface for validating both criteria and attribute values.

### StockUnit

A `StockUnit` record represents a unit of stock of a particular type. All `StockUnit` records have a unique text `description`, a `mass_in_grams`, a `created_at` and `updated_at` timestamp, and an `expiration_date`. `StockUnit` records also have an `owner_id`, corresponding to the user that owns the record, and a `stock_unit_type_id`, which ties the `StockUnit` to a particular type for validation of its `unit_attributes`, a JSON blob which must conform to the `schema` of the associated type. The `StockUnitType` for a `StockUnit` can also be set through the ephemeral attribute `stock_unit_type_name`, which it accepts the string name of an existing `StockUnitType` for convenience.

For example, given the existence of the valid 'coffee' `StockUnitType` described above:

```
StockUnitType.create!({
    description: 'Half kilo of Yirga Cheffe',
    owner_id: 1,
    stock_unit_name: 'coffee',
    expiration_date: '2019-02-28',
    unit_attributes: {
        'cupping score' => 50,
        'tasting notes' => 'Very fruity, with notes of chocolate and smoke',
        'variety' => 'Arabica'
    }
})
```

results in a new, valid `StockUnit` record. However the following:

```
StockUnitType.create!({
    description: 'Half kilo of Bad Beans',
    owner_id: 1,
    stock_unit_name: 'coffee',
    expiration_date: '2019-02-28',
    unit_attributes: {
        'cupping score' => -1,
        'tasting notes' => 'Very fruity, with notes of chocolate and smoke',
        'variety' => 'Arabica'
    }
})
```

will result in a validation error, because the `cupping score` unit attribute does not fall in the range defined by the type.

### User

Users are very basic records, containing only an `id`, `email`, and an encrypted password for authentication.

### Assumptions

- `StockUnitType` should be an ownerless record that can be created, but not updated or deleted through the API, so that all users of the system can create and use any types. Because of this the `name` attribute of `StockUnitType` records must be unique.

- Arbitrary attributes should not be allowed on `StockUnit` records, so all keys in the `unit_attributes` attribute must be present in the schema of the relevant type.

- All attributes defined in a `StockUnitType` schema must be present in the `unit_attributes` of an associated `StockUnit`

- All attributes of a `StockUnit` are updatable via the API, except for the `owner_id`, `stock_unit_type`, and `created_at` values.

- `StockUnit` responses should include the `schema` of associated `StockUnitType` so clients/end users can determine allowed attributes and criteria

### Shortcomings

- No bulk create or update actions
- Error handling/reporting in the API is very basic
- In order to add/remove attributes from a type schema, a new type must be created
- All attributes in schema are required, no mechanism for marking an attribute optional
- No caching (application-layer caching is trivial to add in Rails but seemed unecessary for this exercise)

## API Docs

Located in `doc/api` for signup, signin, resource creation, and resource deletion. See `spec/requests/*` for documentation of index routes.