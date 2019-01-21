class RangeType
  class << self
    def valid_criteria?(criteria)
      criteria.is_a?(Array) &&
      criteria.count == 2 &&
      criteria.all?{ |c| c.is_a?(Numeric) } &&
      criteria[1] > criteria[0]
    end

    def valid_attribute?(attribute, *criteria)
      start, stop = criteria.flatten
      attribute.is_a?(Numeric) &&
      attribute >= start &&
      attribute <= stop
    end
  end
end
