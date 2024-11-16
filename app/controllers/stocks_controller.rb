class StocksController < ApplicationController
  def intraday
    if params[:symbol].present?
      api = AlphaVantageApi.new
      @intraday_data = api.time_series_intraday(params[:symbol])
      @stock_symbol = @intraday_data['Meta Data']['2. Symbol']
      @latest_open_value = @intraday_data['Time Series (5min)'].values.first.dig('1. open')
    end
  end
end
