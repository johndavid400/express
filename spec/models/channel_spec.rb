require 'rails_helper'

RSpec.describe Channel, type: :model do

  it { should validate_presence_of(:title) }
  it { should have_many(:entries) }

  context "instance methods" do

    it "to_s returns title" do
      channel = create(:channel, title: "Test Channel")
      expect(channel.to_s).to eq(channel.title)
    end

    it "custom_fields returns data['custom_fields']" do
      channel = create(:channel, data: {"custom_fields" => [{'foo' => 'bar'}] })
      expect(channel.custom_fields).to eq(channel.data['custom_fields'])
    end

  end

end
