class StockUnitAttributeValidator
  class << self
    def validate!(schema, attributes)
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
