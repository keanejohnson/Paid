require 'rails_helper'

RSpec.describe Bill, type: :model do
  it { should have_valid(:name).when('Groceries', '7/31') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:user_id).when(4, 100, 1) }
  it { should_not have_valid(:user_id).when('Leslie', nil, '') }

  it { should have_valid(:amount).when('100', '0.99', '20.21') }
  it { should_not have_valid(:amount).when('10.123', '$50', '-1.00', nil) }
end
