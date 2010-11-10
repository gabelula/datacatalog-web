class MainController < ApplicationController

  def dashboard
    if current_user
      render 'dashboard'
    else
      @source_count = DataRecord.count
      render 'welcome'
    end
  end

  def about

  end

  def blog
    @entries = []
  end
end
