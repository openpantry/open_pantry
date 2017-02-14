FactoryGirl.define do
  factory :user do
    email "MyString"
    name "MyString"
    phone "MyString"
    ok_to_text false
    family_members 1
    credits ""
    facility nil
    primary_language nil
    inserted_at "2017-02-14 01:00:12"
    password_hash "MyString"
    admin false
  end
end
