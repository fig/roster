FactoryGirl.define do
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
    sun ""
    mon ""
    tue ""
    wed ""
    thu ""
    fri ""
    sat ""
    base_roster
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
