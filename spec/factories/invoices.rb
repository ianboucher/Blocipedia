FactoryGirl.define do
  factory :invoice do
    ref_no ""
    charge_id "MyString"
    amount 1.5
    membership_id nil
  end
end
