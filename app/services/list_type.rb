class ListType
  ALLOWED_TYPES = [
    String,
    Numeric
  ].freeze

  class << self
    def valid_attribute?(value, *criteria)
      criteria.flatten.include?(value)
    end

    def valid_criteria?(criteria)
      criteria.is_a?(Array) &&
      all_types_allowed?(criteria)
    end

    def all_types_allowed?(criteria)
      # There is a better implementation for this
      !criteria.any?{ |criteria| !ALLOWED_TYPES.any?{ |at| criteria.is_a?(at) } }
    end
  end
end
