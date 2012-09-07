require 'spec_helper'

describe "Client Model" do
  let(:client) { Client.new }
  it 'can be created' do
    client.should_not be_nil
  end
end
