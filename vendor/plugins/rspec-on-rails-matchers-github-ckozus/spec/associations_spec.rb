require File.dirname(__FILE__) + '/spec_helper'

class Model < ActiveRecord::Base
  belongs_to :parent
  has_many :children
  has_one :address
  has_and_belongs_to_many :categories
  
  # Prevent ActiveRecord initialisation, as we don't have a database
  def initialize; end
end

describe "'belong_to' matcher" do
  it "should have the label 'model to belong to <association>'" do
    belong_to(:foo).description.should == "model to belong to foo"
  end
  
  it "should match for a class when the association is present" do
    Model.should belong_to(:parent)
  end
  
  it "should match for an instance when the association is present" do
    Model.new.should belong_to(:parent)
  end

  it "should not match for a class when the association is not present" do
    Model.should_not belong_to(:foo)
  end
  
  it "should not match for an instance when the association is not present" do
    Model.new.should_not belong_to(:foo)
  end
end

describe "'have_many' matcher" do
  it "should have the label 'model to have many <association>'" do
    have_many(:foos).description.should == "model to have many foos"
  end
  
  it "should match for a class when the association is present" do
    Model.should have_many(:children)
  end
  
  it "should match for an instance when the association is present" do
    Model.new.should have_many(:children)
  end

  it "should not match for a class when the association is not present" do
    Model.should_not have_many(:foos)
  end
  
  it "should not match for an instance when the association is not present" do
    Model.new.should_not have_many(:foos)
  end
end

describe "'have_one' matcher" do
  it "should have the label 'model to have one <association>'" do
    have_one(:foo).description.should == "model to have one foo"
  end
  
  it "should match for a class when the association is present" do
    Model.should have_one(:address)
  end
  
  it "should match for an instance when the association is present" do
    Model.new.should have_one(:address)
  end

  it "should not match for a class when the association is not present" do
    Model.should_not have_one(:foo)
  end
  
  it "should not match for an instance when the association is not present" do
    Model.new.should_not have_one(:foo)
  end
end

describe "'have_and_belong_to_many' matcher" do
  it "should have the label 'model to have and belong to many <association>'" do
    have_and_belong_to_many(:foos).description.should == "model to have and belong to many foos"
  end
  
  it "should match for a class when the association is present" do
    Model.should have_and_belong_to_many(:categories)
  end
  
  it "should match for an instance when the association is present" do
    Model.new.should have_and_belong_to_many(:categories)
  end

  it "should not match for a class when the association is not present" do
    Model.should_not have_and_belong_to_many(:foos)
  end
  
  it "should not match for an instance when the association is not present" do
    Model.new.should_not have_and_belong_to_many(:foos)
  end
end