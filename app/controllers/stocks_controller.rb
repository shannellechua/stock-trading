class StocksController < ApplicationController
  def index
    @stocks = current_user.stocks
    @balance = current_user.balance
  end

  def intraday
    @balance = current_user.balance
    @stock_symbol = nil
    @inventory = 0
  
    if params[:symbol].present?
      api = AlphaVantageApi.new
      @intraday_data = api.time_series_intraday(params[:symbol])
  
      if @intraday_data.present? && @intraday_data['Meta Data']
        @stock_symbol = @intraday_data['Meta Data']['2. Symbol']
        @latest_open_value = @intraday_data['Time Series (5min)'].values.first.dig('1. open').to_f
      else
        flash[:alert] = "Unable to fetch intraday data for the provided symbol."
      end
    end
  
    if @stock_symbol
      stock = current_user.stocks.find_or_initialize_by(symbol: @stock_symbol, name: @stock_symbol)
      @inventory = stock.inventory
    end
  end

  def buy
    stock_symbol = params[:symbol]
    quantity = params[:quantity].to_i

    if stock_symbol.present? && quantity > 0
      api = AlphaVantageApi.new
      intraday_data = api.time_series_intraday(stock_symbol)
      
      if intraday_data.present? && intraday_data['Time Series (5min)']
        latest_open_value = intraday_data['Time Series (5min)'].values.first.dig('1. open').to_f
        total_price = quantity * latest_open_value

        current_user.transactions.create(
          type_of_transaction: "buy",
          symbol: stock_symbol.upcase,
          quantity: quantity,
          stock_price: total_price
        )

        stock = current_user.stocks.find_or_initialize_by(symbol: stock_symbol, name: stock_symbol)
        stock.inventory = stock.inventory.to_i + quantity
        stock.price = (stock.price || 0) + total_price
        stock.save!

        current_user.update!(balance: current_user.balance - total_price)

        flash[:notice] = "Transaction successful!"
      else
        flash[:alert] = "Unable to fetch stock data. Please try again."
      end
    else
      flash[:alert] = "Invalid purchase details. Quantity must be greater than 0."
    end

    redirect_to intraday_stocks_path(symbol: stock_symbol)
  end


  def sell
    stock_symbol = params[:symbol]
    quantity = params[:quantity].to_i

    if stock_symbol.present? && quantity > 0
      api = AlphaVantageApi.new
      intraday_data = api.time_series_intraday(stock_symbol)
      
      if intraday_data.present? && intraday_data['Time Series (5min)']
        latest_open_value = intraday_data['Time Series (5min)'].values.first.dig('1. open').to_f
        total_price = quantity * latest_open_value

        stock = current_user.stocks.find_by(symbol: stock_symbol)
      if stock.nil? || stock.inventory < quantity
        flash[:alert] = "You do not have enough of this stock to sell."
      else
        current_user.transactions.create(
          type_of_transaction: "sell",
          symbol: stock_symbol.upcase,
          quantity: quantity,
          stock_price: total_price
        )

        stock.inventory -= quantity
        stock.price = (stock.price || 0) - total_price
        stock.save!

        current_user.update!(balance: current_user.balance + total_price)

        flash[:notice] = "Transaction successful!"
        end
      else
        flash[:alert] = "Unable to fetch stock data. Please try again."
      end
    else
      flash[:alert] = "Invalid purchase details. Quantity must be greater than 0."
    end

    redirect_to intraday_stocks_path(symbol: stock_symbol)
  end
  
end