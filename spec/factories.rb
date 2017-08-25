FactoryGirl.define do

  factory :channel do
    title "Test Channel"
    slug "test-channel"
    description "Descriptive stuff right here"
    status "open"
    #data {"custom_fields"=>[{"foo"=>"bar"}]}
  end

  factory :entry do
    channel_id {FactoryGirl.create(:channel).id}
    title "Test Entry"
    slug "test-entry"
    description "Descriptive stuff right here"
    open 2.days.ago
    close 3.days.from_now
    #data {"foo"=>"bar"}
  end

  factory :setting do
    title "Test Setting"
    slug "test-setting"
    description "Descriptive stuff right here"
    #data {"options"=>[{"key"=>"Yes", "value"=>"yes"}, {"key"=>"No", "value"=>"no"}]}
  end

  factory :upload do
    name "Test Upload"
    entry_id {FactoryGirl.create(:entry).id}
    attachment_uid "uid"
    attachment_name "name"
    attachment_size "123"
  end

end

