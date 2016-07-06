class UserPolicy < ApplicationPolicy
  attr_reader :current_u, :model 
  
  def initialize(current_u, model) 
    @current_u = current_u 
    @user = model 
  end
  
  def index? 
    @current_u.admin?
  end
  
  def show? 
    @current_u.admin? or @current_u == @user
  end
  
  def update? 
    @current_u.admin?
  end
  
  def destroy? 
    @current_u.admin?
  end
end
