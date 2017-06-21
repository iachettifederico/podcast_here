require "spec_helper"

RSpec.describe PodcastHere do
  it "has a version number" do
    expect(PodcastHere::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
