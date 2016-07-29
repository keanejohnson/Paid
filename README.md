![Build Status](https://codeship.com/projects/8986a430-2f26-0134-93e4-5ebc8f268022/status?branch=master)
![Code Climate](https://codeclimate.com/github/keanejohnson/Paid.png)
![Coverage Status](https://coveralls.io/repos/keanejohnson/Paid/badge.png)

# Paid

# App Name:
PAID

# Demo Site:
https://paid.herokuapp.com/

# Description:
PAID is a Rails-based web application that enables users to easily split
bills with their friends. A user creates a group and adds other registered users
to their group. Each group member can add a bill that they have paid for in
full. When it comes time to repay each other, a user creates a settlement.
A settlement sums all the bills that have been added since the previous
settlement and calculates a per person total cost. PAID then sums all the bills
for which each group member has paid. The difference between these calculations
is what each member owes to every other member to ensure they pay their bills
equally. After repaying friends, users can delete bills and settlements from
their group!

# Features:
1) Authenticated users can create a group
2) Authenticated users can add other members to a group
3) Authenticated users can add a bill to their group
4) Authenticated users can create a settlement
5) Authenticated users can delete bills and settlements

# Why Did I Build PAID?
I wanted to build PAID because I remembered the difficulty that my college
roommates and I had trying to evenly split bills. We could have taken advantage
of a an application that recorded bills and how much each member of a group
owed each other.

# Dependencies:
Ruby 2.2.3
Rails 4.2.5
PostgresSQL Database

# Download:
```git clone https://github.com/keanejohnson/Paid.git
cd Paid
bundle install
rake db:create && rake db:migrate
rails s
localhost:3000```
