class Rate < ApplicationRecord
  validates :rate, :forced_till, presence: true

  scope :last_forced_rate, -> { where('forced_till >= ?', Time.now.in_time_zone('Moscow')).order('forced_till ASC') }


  def self.get_current_rate
    res_last_forced_rate = last_forced_rate.try(:first)
    if res_last_forced_rate && (res_last_forced_rate.forced_till >= Time.now)
      res = { date: res_last_forced_rate.forced_till, rate_value_usd: res_last_forced_rate.rate }
    else
      res = Rails.cache.read('cbr_data') || Cbr_rate.perform
    end
    res
  end

end
