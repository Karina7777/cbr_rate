module API

  class Base < Grape::API
    prefix 'api'

    mount RatesApi
  end

end