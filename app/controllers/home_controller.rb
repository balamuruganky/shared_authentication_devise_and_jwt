class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :terms, :privacy]

  def index
  end

  def terms
  end

  def privacy
  end
end
