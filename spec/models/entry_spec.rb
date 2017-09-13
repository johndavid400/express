require 'rails_helper'

RSpec.describe Entry, type: :model do

  it { should validate_presence_of(:title) }
  it { should belong_to(:channel) }
  it { should have_many(:uploads) }

  context "instance methods" do

    it "to_s returns title" do
      entry = create(:entry)
      expect(entry.to_s).to eq(entry.title)
    end

    it "get_data returns data attribute" do
      entry = create(:entry, data: {"foo" => "bar"})
      expect(entry.get_data("foo")).to eq("bar")
    end

    it "dynamic instance returns data attribute using key as method name" do
      entry = create(:entry, data: {"foo" => "bar"})
      expect(entry.foo).to eq("bar")
    end

    it "dynamic instance method returns NoMethodError (super) if data attribute is not present" do
      entry = create(:entry)
      expect{entry.oops}.to raise_error(NoMethodError)
    end

  end

  context "class methods scope Entries" do

    it "open returns open entries" do
      entry1 = create(:entry, status: "open")
      entry2 = create(:entry, status: "closed")
      expect(Entry.open).to eq([entry1])
    end

    it "closed returns closed entries" do
      entry1 = create(:entry, status: "open")
      entry2 = create(:entry, status: "closed")
      expect(Entry.closed).to eq([entry2])
    end

    it "dynamic class method should scope by Channel using channel slug" do
      channel1 = create(:channel, slug: "feature")
      entry1 = create(:entry, channel_id: channel1.id)
      channel2 = create(:channel, slug: "event")
      entry2 = create(:entry, channel_id: channel2.id)
      expect(Entry.event).to eq([entry2])
    end

    it "dynamic class method returns NoMethodError (super) if Channel scope is not present" do
      expect{Entry.oops}.to raise_error(NoMethodError)
    end

  end

end
