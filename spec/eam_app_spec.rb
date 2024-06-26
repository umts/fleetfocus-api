# frozen_string_literal: true

require 'fueling'
require 'eam_app'
require 'json'

RSpec.describe EAMApp do
  let(:parsed) { JSON.parse last_response.body }
  let(:fueling) { parsed.fetch 'fueling' }
  let(:buses) { fueling.map { |f| f.fetch 'EQ_equip_no' } }

  it 'returns a 404 for the root URL' do
    get '/'
    expect(last_response).to be_not_found
  end

  context 'when requesting valid data' do
    before do
      create :fueling
      get '/all/0'
    end

    it 'returns valid, parse-able JSON' do
      expect { parsed }.not_to raise_error
    end

    it 'reports the connection as valid' do
      expect(parsed.fetch('connection_valid')).to be(true)
    end

    it 'does not report any errors' do
      expect(parsed.fetch('error')).to be_blank
    end
  end

  context 'when requesting invalid data' do
    before { get '/vehicle/NONEXISTANT' }

    it 'reports the connection as invalid' do
      expect(parsed.fetch('connection_valid')).to be(false)
    end

    it 'wraps errors in the response JSON' do
      expect(parsed.fetch('error')).to be_present
    end
  end

  context 'with a vehicle id' do
    let(:fuel_dates) { [30.days.ago.change(sec: 0), 20.days.ago.change(sec: 0), Date.current.beginning_of_day] }

    before do
      fuel_dates.each { |date| create :fueling, ftk_date: date }
      create :fueling, EQ_equip_no: '3315'
      get '/vehicle/3201'
    end

    it 'returns all fuelings for that vehicle' do
      expect(fueling.count).to be(3)
    end

    it 'returns only fuelings for that vehicle' do
      expect(buses).not_to include('3315')
    end

    it 'returns the fuelings, most recent first' do
      fueling_times = fueling.map { |f| Time.parse(f.fetch('time_at')) }

      expect(fueling_times).to match_array(fuel_dates)
    end

    context 'with a single timestamp' do
      before { get "/vehicle/3201/#{25.days.ago.to_i}" }

      it 'returns all fuelings since that timestamp' do
        expect(fueling.count).to be(2)
      end

      it 'returns only fuelings since that timestamp' do
        dates = fueling.map { |f| Date.parse(f.fetch('time_at')) }
        expect(dates).to all(be > 25.days.ago)
      end

      it 'returns only fuelings for that vehicle' do
        expect(buses).not_to include('3315')
      end
    end

    context 'with two timestamps' do
      before { get "/vehicle/3201/#{25.days.ago.to_i}/#{15.days.ago.to_i}" }

      it 'returns all fuelings between those timestamps' do
        expect(fueling.count).to be(1)
      end

      it 'returns only fuelings between those timestamps' do
        time_of_fueling = Time.parse(fueling.first.fetch('time_at'))
        expect(time_of_fueling).to eq(fuel_dates[1])
      end
    end
  end

  context 'with /all/ as the specified vehicle' do
    before do
      create :fueling, ftk_date: 30.days.ago, EQ_equip_no: '3301'
      create :fueling, ftk_date: 20.days.ago, EQ_equip_no: '3302'
      create :fueling, ftk_date: 10.days.ago, EQ_equip_no: '3303'
      create :fueling, EQ_equip_no: '3304'
    end

    it 'is invalid without timestamps' do
      get '/all'
      expect(last_response).to be_not_found
    end

    context 'with a single timestamp' do
      it 'returns only fuelings since that timestamp' do
        get "/all/#{25.days.ago.to_i}"
        expect(buses).to contain_exactly('3302', '3303', '3304')
      end
    end

    context 'with two timestamps' do
      it 'returns only fuelings between those timestamps' do
        d1 = 25.days.ago.to_i
        d2 = 5.days.ago.to_i
        get "/all/#{d1}/#{d2}"
        expect(buses).to contain_exactly('3302', '3303')
      end
    end
  end
end
