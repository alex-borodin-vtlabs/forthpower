module DeviseMacros
  def login_user_with_role(u)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(u)
      sign_in user
    end
  end
end
