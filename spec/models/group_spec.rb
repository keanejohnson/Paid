require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_valid(:name).when('Cool Guys and Girls', '33 Harrison') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_many(:bills) }
  it { should have_many(:users).through(:user_groups) }
end
