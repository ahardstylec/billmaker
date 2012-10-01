require 'spec_helper'

describe "Email Model" do
  let(:email) { Email.new }
  it 'can be created' do
    email.should_not be_nil
  end
end
