module UsersHelper
  def admin_links(current_user)
    render :partial => 'users/admin_links' if current_user.admin?
  end

end
