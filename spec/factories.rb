FactoryGirl.define do

  puts "sup"
  factory :channel do
    title "Test Channel"
    slug "test-channel"
    description "Descriptive stuff right here"
    status "open"
    # data
  end

  factory :channel_entry do
    title "Test Entry"
    slug "test-entry"
    description "Descriptive stuff right here"
    open 2.days.ago
    close 3.days.from_now
    # data
  end

  factory :setting do
    title "Test Setting"
    slug "test-setting"
    description "Descriptive stuff right here"
    # data
  end

end

