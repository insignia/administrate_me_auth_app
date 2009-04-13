require File.dirname(__FILE__) + '/spec_helper'

class Model < ActiveRecord::Base
end

class ModelObserver < ActiveRecord::Observer
  observe :model
end

describe "'observe' matcher" do
  it "should have the label 'observer to be observing <model>'" do
    observe(Model).description.should == "observe Model"
  end

  it "should match for an instance which is observing the model" do
    ModelObserver.instance.should observe(Model)
  end

  it "should have the failure message 'expected <observer> to observe <model>, but it was not included in [<observed classes>]'" do
    class Foo < ActiveRecord::Base
    end

    match = observe(Foo)
    ModelObserver.instance.should match rescue # This is the assertion being tested, and should fail.
    match.failure_message.should == 'expected ModelObserver to observe Foo, but it was not included in [Model]'
  end
end