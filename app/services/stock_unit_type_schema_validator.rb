class StockUnitTypeSchemaValidator
  VALIDATORS = {

  }.freeze

  class << self
    def validate!(schema)
      schema.each do |(_, type, *criteria)|
        validator = validators(type)

        if !validator.present?
          raise "#{type} is not a valid validator type"
        end

        if !validator.valid_criteria?(criteria)
          raise "#{criteria} are not valid criteria for the #{type} type"
        end

      end

      true
    end

    def validators(type)
      VALIDATORS[type]
    end
  end
end
