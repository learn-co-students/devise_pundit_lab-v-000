class StaticController < ApplicationController
  def home
    render plain: "Home"
  end
