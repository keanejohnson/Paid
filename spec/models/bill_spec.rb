require 'rails_helper'

RSpec.describe Bill, type: :model do
  it { should have_valid(:title).when('Groceries', 'Dinner for 2') }
  it { should_not have_valid(:title).when(nil, '') }

  it { should have_valid(:description).when('A' * 140) }
  it { should_not have_valid(:description).when('B' * 141) }

  it { should have_valid(:amount).when(100.00, 50.43, 1.01) }
  it { should_not have_valid(:amount).when(nil, '', '$100', 1.123, -1.25) }

  it { should have_valid(:party_size).when(2, 1, 10, 100) }
  it { should_not have_valid(:party_size).when(nil, '', -1, 2.2) }
end
