FactoryGirl.define do
  sequence :number do |n|
    "#{n}"
  end
  factory :profile do
    name_first "MyString"
    name_last "MyString"
    roster_epoch "2017-01-01"
  end
  
  factory :user do
    email "name@domain.com"
    password "password"
    password_confirmation "password"
    base_roster
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
    number { generate(:number) }
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
    factory :base_roster_with_lines do
      # lines_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        lines_count 10
      end

      # the after(:create) yields two values; the base_roster instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the base_roster is associated properly to the line
      after(:create) do |base_roster, evaluator|
        create_list(:line, evaluator.lines_count, base_roster: base_roster)
      end
    end
  end
end
