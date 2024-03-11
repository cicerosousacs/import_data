class SearchHistoryController < ApplicationController
  def index
    history = SearchHistory.history_list(params)
    render json: { history: history}
  end
end
