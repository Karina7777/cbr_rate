class Admin::MainController < ApplicationController

  def index
    @rate = Rate.new
    @rates = Rate.all
  end

  def create
    rate = Rate.create(permit_params_rate)
    if rate.valid?
      flash[:notice] = 'Добавление форсированной котировки прошло успешно'
    else
      flash[:notice] = 'Исправьте ошибки на форме'
    end
    redirect_to action: :index
  end


private

  def permit_params_rate
    param_rate = params.require(:rate).permit(:forced_till, :rate)
    { rate: param_rate[:rate], forced_till: parse_date(param_rate), symbol: 'USD' }
  end

  def parse_date(unparsed_date)
    DateTime.new( unparsed_date['forced_till(1i)'].to_i,
                  unparsed_date['forced_till(2i)'].to_i,
                  unparsed_date['forced_till(3i)'].to_i,
                  unparsed_date['forced_till(4i)'].to_i,
                  unparsed_date['forced_till(5i)'].to_i,
                  unparsed_date['forced_till(6i)'].to_i  )
  end

end