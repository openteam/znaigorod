FactoryGirl.define do

  factory :institution_class do
    title "Institution Class"
  end

  factory :institution_kind do
    title "Institution Kind"
    association :institution_class
  end

  factory :parameter do
    title "Parameter"
    association :institution_kind
    kind "string"
    required false
    searchable false
  end

end