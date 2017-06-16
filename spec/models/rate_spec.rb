require 'spec_helper'

describe Rate, type: :model do
  let(:model) { Rate }

  it 'return rate from CBR when last_forced_rate return nil' do
    allow(model).to receive(:last_forced_rate).and_return(nil)
    example_response = {:date=>'16.06.2017', :rate_value_usd=>'57,4437'}
    allow(Cbr_rate).to receive(:perform).and_return(example_response)
    expect(model.get_current_rate).to eq(example_response)
  end

  it 'return rate from cache when last_forced_rate return nil' do
    allow(model).to receive(:last_forced_rate).and_return(nil)
    example_response = {:date=>'16.06.2017', :rate_value_usd=>'57,4437'}
    allow(Rails).to receive_message_chain(:cache, :read).and_return(example_response)
    expect(model.get_current_rate).to eq(example_response)
  end

  it 'return rate from model if forced time not end' do
    Time.zone = ActiveSupport::TimeZone['Moscow']
    rate_1 = model.create(forced_till: Time.now + 5.hours, rate: 50.0, symbol: 'USD')
    expect(model.get_current_rate[:rate_value_usd]).to eq(rate_1.rate)
  end

  it 'return rate more closest to current time' do
    Time.zone = ActiveSupport::TimeZone['Moscow']
    rate_1 = model.create(forced_till: Time.now + 5.hours, rate: 50.0, symbol: 'USD')
    rate_2 = model.create(forced_till: Time.now + 4.hours, rate: 51.0, symbol: 'USD')
    expect(model.get_current_rate[:rate_value_usd]).to eq(rate_2.rate)
  end
end
