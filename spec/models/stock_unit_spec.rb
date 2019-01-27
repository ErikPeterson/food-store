require 'rails_helper'

RSpec.describe StockUnit, type: :model do
  context 'owner (User)' do
    it 'must be present' do
      expect{ create(:stock_unit, owner: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'stock_unit_type' do
    it 'must be present' do
      expect{ create(:stock_unit, stock_unit_type: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    context 'attributes' do
      it 'must be valid for the stock_unit_type' do
        type = create(
          :stock_unit_type,
          name: 'Jelly Beans',
          schema: [
            ['color', 'ListType', 'green', 'red'],
            ['size', 'RangeType', 0, 10],
            ['manufacturer', 'TextType']
        ])

        expect do
          create(:stock_unit,
            stock_unit_type: type,
            description: "Big ol' sack of jelly bellys",
            unit_attributes: {
              'color' => 'green',
              'size' => 2,
              'manufacturer' => 'JellyBelly'
            }
          )
        end.to_not raise_error

        expect do
          create(:stock_unit,
            description: "Nasty beans : (",
            unit_attributes: {
              'color' => 'fuschia',
              'size' => 11,
              'manufacturer' => 10.1
          })
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
