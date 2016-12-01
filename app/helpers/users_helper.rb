module UsersHelper
  def mode
    @user.new_record? ? :new : :edit
  end
end
