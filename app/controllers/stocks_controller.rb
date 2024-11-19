class StocksController < ApplicationController
  def intraday
    if params[:symbol].present?
      api = AlphaVantageApi.new
      @intraday_data = api.time_series_intraday(params[:symbol])
      
      if @intraday_data.present? && @intraday_data['Meta Data']
        @stock_symbol = @intraday_data['Meta Data']['2. Symbol']
        @latest_open_value = @intraday_data['Time Series (5min)'].values.first.dig('1. open')
        buy()
      else
        flash[:alert] = "Unable to fetch intraday data for the provided symbol."
      end
    end
  end

  def buy 
    current_user.transactions.create(type_of_transaction: "buy", symbol: @stock_symbol)
  end
end
