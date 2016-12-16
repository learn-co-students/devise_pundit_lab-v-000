class StaticController < ApplicationController

  def home
    render '/static/home.html.erb'
  end

  def about
    render '/static/about.html.erb'
  end

end
