class RatesApi < Grape::API
  version 'v1', using: :path
  format :json
  resource 'get_rate' do
    desc 'return rate USD considering forced time'
    get '/' do
      Rate.get_current_rate
    end
  end

end