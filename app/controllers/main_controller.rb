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
#    require 'feedzirra'
#    url = "http://sunlightlabs.com/blog/feeds/tag/datacatalog/" #natdatcat or data.gov
#    feed = Feedzirra::Feed.fetch_and_parse(url)
#    @entries = feed.entries
    @entries = []
  end
end
