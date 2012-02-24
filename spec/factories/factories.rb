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

  factory :institution do
    title "Institution"
    address "Address"
  end

  factory :kind do
    association :institution_kind
    association :institution
  end

  factory :parameter_string do
    value "Value"
    association :parameter
    association :kind
  end

end