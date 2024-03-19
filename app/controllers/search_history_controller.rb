class SearchHistoryController < ApplicationController
  before_action :authenticated?
  def index
    history = SearchHistory.history_list(params)
    render json: { history: history}
  end
end
