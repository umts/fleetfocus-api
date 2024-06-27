# frozen_string_literal: true

require 'fueling'

RSpec.describe Fueling do
  it 'uses row_id as its primary key' do
    fueling = create(:fueling)
    expect(fueling.row_id).to eq(fueling.id)
  end

  describe '#readonly?' do
    subject { build(:fueling).readonly? }

    before { allow(ENV).to receive(:fetch).with('RACK_ENV', nil).and_return(environment) }

    context 'when in a production environment' do
      let(:environment) { 'production' }

      it { is_expected.to be(true) }
    end

    context 'when in a development environment' do
      let(:environment) { 'development' }

      it { is_expected.to be(true) }
    end
  end
end
