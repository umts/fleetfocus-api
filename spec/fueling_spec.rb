# frozen_string_literal: true

require 'fueling'

RSpec.describe Fueling do
  it 'uses row_id as its primary key' do
    fueling = create :fueling
    expect(fueling.row_id).to eq(fueling.id)
  end
end
