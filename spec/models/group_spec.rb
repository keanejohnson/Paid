require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_valid(:name).when('Cool Guys and Girls', '33 Harrison') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:size).when(4, 5, 10, 100) }
  it { should_not have_valid(:size).when(nil, '', -1, 0, 13.1, 'four') }

  it { should have_many(:bills) }
  it { should have_many(:users).through(:user_groups) }
end
