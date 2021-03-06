require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:first_name).when('Ron', 'Leslie') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Swanson', 'Knope') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('ron@example.com', 'leslie@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'ur', 'ur@com', 'a.gm.com') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'differentpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  it { should have_many(:bills) }
  it { should have_many(:groups).through(:user_groups) }
end
