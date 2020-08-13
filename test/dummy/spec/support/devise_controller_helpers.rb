module DeviseControllerHelpers
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      user
    end
  end

  def login_admin(user = nil)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in (user || FactoryBot.create(:admin)) # Using factory bot as an example
      user
    end
  end

  def login_as(user)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
      user
    end
  end
end
