require 'fueling'
require 'eam_app'
require 'pry'

describe EAMApp do
  it 'returns a 404 for the root URL' do
    get '/'
    binding.pry
  end
  it 'contains its response in a wrapper JSON object'
  it 'wraps errors in the response JSON'

  context 'with a vehicle id' do
    it 'returns all fuelings for that vehicle'
    context 'with a single timestamp' do
      it 'returns only fuelings since that timestamp'
    end
    context 'with two timestamps' do
      it 'returns only fuelings between those timestamps'
    end
  end

  context 'with /all/ as the specified vehicle' do
    it 'is invalid without timestamps'
    context 'with a single timestamp' do
      it 'returns only fuelings since that timestamp'
    end
    context 'with two timestamps' do
      it 'returns only fuelings between those timestamps'
    end
  end
end
