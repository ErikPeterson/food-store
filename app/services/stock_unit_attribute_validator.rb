class StockUnitAttributeValidator
  class << self
    def validate!(schema, attributes)
      valid_attributes = schema.map(&:first)

      if (invalid_key = attributes.keys.detect{ |k| !valid_attributes.include?(k.to_s) })
        raise "'#{invalid_key} is not a valid attribute for this type"
      end

      schema.each do |(name, type, *criteria)|
        value = attributes[name]
        unless StockUnitTypeSchemaValidator.validators(type).valid_attribute?(value, criteria)
          raise "'#{value}' is not a valid value for attribute #{name}"
        end
      end

      true
    end
  end
end
