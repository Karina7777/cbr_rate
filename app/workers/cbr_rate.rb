require 'net/http'

class Cbr_rate
  @queue = :cbr_rate

  class << self

    def perform
      data = get_data
      Rails.cache.write('cbr_data', data, :expires_in => 1.day)
      data
    end

  private

    def get_data
      uri = URI.parse('http://www.cbr-xml-daily.ru/daily_eng_utf8.xml')
      req = Net::HTTP::Get.new(uri.to_s)
      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
      hash_data = Hash.from_xml(res.body)
      rate_value_usd = hash_data['ValCurs']['Valute'].select{|hash, key| hash['ID'] == 'R01235' }
      date = hash_data['ValCurs']['Date']
      { date: date, rate_value_usd: rate_value_usd.first['Value'] }
    end

  end
end


