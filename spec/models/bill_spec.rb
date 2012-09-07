require 'spec_helper'

describe "Bill Model" do
  let(:bill) { Bill.new }
  it 'can be created' do
    bill.should_not be_nil
  end
end
