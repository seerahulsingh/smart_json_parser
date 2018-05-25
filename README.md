## Smart JSON Parser

## Installation
Add below in Gemfile and do `$ bundle install`

```
gem "smart_json_parser", :git => 'https://github.com/seerahulsingh/smart_json_parser'
```

## Usage

Given sample json

```
{
  "data": {
    "type": "accounts",
    "id": "2593177",
    "attributes": {
      "title": "Ms",
      "first-name": "Joe",
      "last-name": "Bloggs",
      "date-of-birth": "1985-01-01",
      "contact-number": "0404000000",
      "email-address": "test@example.com",
      "email-address-verified": false,
      "email-subscription-status": false
    },
    "links": {
      "self": "http://localhost:3000/accounts/2593177"
    }
  },
  "included": [
    {
      "type": "services",
      "id": "0468874507",
      "attributes": {
        "msn": "0468874507",
      }
    },
    
    {
      "type": "products",
      "id": "4000",
      "attributes": {
        "name": "UNLIMITED 7GB",
        "included-data": null,
        "included-credit": null,
        "price": 3990
      }
    }
  ]
}

```

First create an  object of SmartJsonParser as below, the module will expect path of the json file as a parameter
```
parser_object = SmartJsonParser.new('collection.json')
```

1. use `get_default` method to get the value for phone, email, fullname and product name

```
parser_object.get_default
```

2. use `get` method to get the value of any attributes, given that you send attributes as a param in proper format

```
parser_object.get(attribute)

# where attributes can array or comma separated value but in the format of `parent.child.sub-child...`
# e.g. ["data.id", "data.attributes.title", "data.links"]
# another example ["included.products.attributes.name" "data.id", "data.links"] 
```

3. In case if you want to get concatenated values e.g title+first-name+last-name etc

```
parser_object.get(attribute)

# where attribute should be array or comma separated value in format of
e.g. "data.attributes.title+first-name+last-name,inlcuded.products.id"
etc
```

## Run it from irb
```
require 'smart_json_parser'
x = SmartJsonParser.new('collection.json')
x.get_default
x.get("included.products.attributes.name")
```
