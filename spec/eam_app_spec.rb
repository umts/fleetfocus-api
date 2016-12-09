# frozen_string_literal: true
require 'fueling'
require 'eam_app'
require 'json'

RSpec.describe EAMApp do
  let :parsed do
    JSON.parse last_response.body
  end

  let :fueling do
    parsed.fetch 'fueling'
  end

  let :buses do
    fueling.map { |f| f.fetch 'EQ_equip_no' }
  end

  it 'returns a 404 for the root URL' do
    get '/'
    expect(last_response).to be_not_found
  end

  it 'contains its response in a wrapper JSON object' do
    create :fueling
    get '/all/0'
    expect { parsed }.not_to raise_error
    expect(parsed.fetch('connection_valid')).to be(true)
    expect(parsed.fetch('error')).to be_blank
  end

  it 'wraps errors in the response JSON' do
    get '/vehicle/NONEXISTANT'
    expect(parsed.fetch('connection_valid')).to be(false)
    expect(parsed.fetch('error')).to be_present
  end

  context 'with a vehicle id' do
    before :each do
      create :fueling, ftk_date: 30.days.ago
      create :fueling, ftk_date: 20.days.ago
      create :fueling
      create :fueling, EQ_equip_no: '3315'
    end

    it 'returns all fuelings for that vehicle' do
      get '/vehicle/3201'
      expect(fueling.count).to be(3)
      expect(buses).not_to include('3315')
    end

    context 'and a single timestamp' do
      it 'returns only fuelings since that timestamp' do
        get "/vehicle/3201/#{25.days.ago.to_i}"
        expect(fueling.count).to be(2)
        expect(buses).not_to include('3315')
        dates = fueling.map { |f| Date.parse(f.fetch('time_at')) }
        expect(dates).to all(be > 25.days.ago)
      end
    end

    context 'and two timestamps' do
      it 'returns only fuelings between those timestamps' do
        d1 = 25.days.ago.to_i
        d2 = 15.days.ago.to_i
        get "/vehicle/3201/#{d1}/#{d2}"
        expect(fueling.count).to be(1)
        expect(fueling.first.fetch('time_at')).to be > 20.days.ago - 5.minutes
        expect(fueling.first.fetch('time_at')).to be < 20.days.ago + 5.minutes
      end
    end
  end

  context 'with /all/ as the specified vehicle' do
    before :each do
      create :fueling, ftk_date: 30.days.ago, EQ_equip_no: '3301'
      create :fueling, ftk_date: 20.days.ago, EQ_equip_no: '3302'
      create :fueling, ftk_date: 10.days.ago, EQ_equip_no: '3303'
      create :fueling, EQ_equip_no: '3304'
    end

    it 'is invalid without timestamps' do
      get '/all'
      expect(last_response).to be_not_found
    end

    context 'and a single timestamp' do
      it 'returns only fuelings since that timestamp' do
        get "/all/#{25.days.ago.to_i}"
        expect(buses).to contain_exactly('3302', '3303', '3304')
      end
    end

    context 'and two timestamps' do
      it 'returns only fuelings between those timestamps' do
        d1 = 25.days.ago.to_i
        d2 = 5.days.ago.to_i
        get "/all/#{d1}/#{d2}"
        expect(buses).to contain_exactly('3302', '3303')
      end
    end
  end
end
