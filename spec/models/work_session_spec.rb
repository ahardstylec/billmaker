require 'spec_helper'

describe "WorkSession Model" do
  let(:work_session) { WorkSession.new }
  it 'can be created' do
    work_session.should_not be_nil
  end
end
