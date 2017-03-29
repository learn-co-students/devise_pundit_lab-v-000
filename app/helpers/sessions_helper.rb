module SessionsHelper
  #def current_user
  #  User.find_by(id: session[:user_id])
  #end

  def sign_out_link
    if current_user
      link_to "Sign out", destroy_session_path(User.new), :method => :delete
    end
  end
end
