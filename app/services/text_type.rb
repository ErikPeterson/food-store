class TextType
  class << self
    def valid_criteria?(criteria)
      ( criteria.count == 0 || criteria.count == 1 ) &&
      ( criteria[0].nil? ||
        ( criteria[0].is_a?(Integer) &&
         criteria[0] > 0 ))
    end

    def valid_attribute?(attribute, *criteria)
      attribute.is_a?(String) &&
      ( criteria.flatten.first.nil? ||
        criteria.flatten.first >= attribute.length )
    end
  end
end
