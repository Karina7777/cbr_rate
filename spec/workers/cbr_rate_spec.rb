require 'spec_helper'

def example_response
  '<ValCurs Date="16.06.2017" name="Foreign Currency Market">
    <Valute ID="R01010">
      <NumCode>036</NumCode>
      <CharCode>AUD</CharCode>
      <Nominal>1</Nominal>
      <Name>Australian Dollar</Name>
      <Value>43,6630</Value>
    </Valute>
    <Valute ID="R01035">
      <NumCode>826</NumCode>
      <CharCode>GBP</CharCode>
      <Nominal>1</Nominal>
      <Name>British Pound Sterling</Name>
      <Value>73,0109</Value>
    </Valute>
    <Valute ID="R01235">
      <NumCode>840</NumCode>
      <CharCode>USD</CharCode>
      <Nominal>1</Nominal>
      <Name>US Dollar</Name>
      <Value>57,4437</Value>
    </Valute>
  </ValCurs>'
end

def mock_response
  expect_any_instance_of(Net::HTTP).to receive(:request).and_return(response = double)
  allow(response).to receive(:code).and_return '200'
  allow(response).to receive(:body).and_return example_response
end

describe Cbr_rate do

 it 'should return value of rate by ID' do
  mock_response
  rate = Cbr_rate.perform
  expect(rate[:rate_value_usd]).to eq('57,4437')
 end

end