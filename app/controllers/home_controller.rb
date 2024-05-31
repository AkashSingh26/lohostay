class HomeController < ApplicationController
  def index
    @villas = Villa.all
    @today = Date.today
  end
end
