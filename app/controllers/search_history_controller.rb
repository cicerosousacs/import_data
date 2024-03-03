class SearchHistoryController < ApplicationController
  def index
    history = SearchHistory.history_list(params)#order('id desc')
    render json: { history: history}
  end
end
