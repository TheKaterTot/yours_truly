require "rails_helper"

describe Letter do
  it { should validate_presence_of(:content) }
  it { should belong_to(:owner) }
end
