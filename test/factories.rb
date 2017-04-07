FactoryGirl.define do
  factory :profile do
    name_first "MyString"
    name_last "MyString"
    roster_epoch "2017-03-31"
  end
  
  factory :user do
    email "name@domain.com"
    password "password"
    password_confirmation "password"
    profile
  end
  
  factory :turn do
    name "1"
    time_on "0500"
    time_off "0600"
    sun false
    mon true
    tue true
    wed true
    thu true
    fri true
    sat false
  end

  factory :line do
    number "1"
    sun "201"
    mon "1"
    tue "41"
    wed "RD"
    thu "RD"
    fri "A/R"
    sat "101"
    base_roster
  end
  
  factory :day do
    name "day"
    line
    turn
  end

  factory :base_roster do
    name "MyString"
    version "MyString"
    depot "MyString"
    link "MyString"
    duration 13
    #commencement_date 2016-08-01
  end
end
