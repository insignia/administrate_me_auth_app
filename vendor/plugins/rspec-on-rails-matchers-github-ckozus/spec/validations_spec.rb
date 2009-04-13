require File.dirname(__FILE__) + '/spec_helper'

class PseudoActiveRecord < ActiveRecord::Base
  # Prevent ActiveRecord initialisation, as we don't have a database
  def initialize; end
    
  # Fake some ActiveRecord behaviour
  def id; 1; end
  def method_missing(symbol, *params)
    send $1 if (symbol.to_s =~ /(.*)_before_type_cast$/)
  end
  def transfer_attributes(params)
    params.each do | name, value |
      self.send("#{name}=", value) if self.respond_to?("#{name}=")
    end
  end
end

describe "'validate_presence_of' matcher" do
  class PresenceModel < PseudoActiveRecord
    attr_accessor :name
    validates_presence_of :name
  end

  before do
    @model = PresenceModel.new
  end
  
  it "should have the label 'model to validate the presence of <attr>'" do
    validate_presence_of(:foo).description.should == "model to validate the presence of foo"
  end
  
  it "should match when the validation is present" do
    @model.should validate_presence_of(:name)
  end
  
  it "should not match when the validation is not present" do
    @model.should_not validate_presence_of(:foo)
  end
end

describe "'validate_length_of' matcher" do
  describe "using 'within'" do
    class LengthWithinModel < PseudoActiveRecord
      attr_accessor :name
      validates_length_of :name, :within => 2...20
    end

    before do
      @model = LengthWithinModel.new
    end

    it "should have the label 'model to validate the length of <attr> within <min> and <max>'" do
      validate_length_of(:foo, :within => 1...2).description.should == "model to validate the length of foo within 1 and 2"
    end
  
    it "should match when the validation is present" do
      @model.should validate_length_of(:name, :within => 2...20)
    end
  
    it "should not match when the minimum accepted length is too low" do
      @model.should_not validate_length_of(:name, :within => 3...20)
    end
  
    it "should not match when the minimum accepted length  is too high" do
      @model.should_not validate_length_of(:name, :within => 1...20)
    end
  
    it "should not match when the maximum accepted length is too low" do
      @model.should_not validate_length_of(:name, :within => 2...21)
    end
  
    it "should not match when the maximum accepted length  is too high" do
      @model.should_not validate_length_of(:name, :within => 2...19)
    end
  
    it "should not match when the validation is not present" do
      @model.should_not validate_length_of(:foo, :within => 1...2)
    end
  end

  describe "using 'minimum'" do
    class LengthMinimumModel < PseudoActiveRecord
      attr_accessor :name
      validates_length_of :name, :minimum => 2
    end

    before do
      @model = LengthMinimumModel.new
    end

    it "should have the label 'model to validate the length of <attr> within <min> and Infinity'" do
      validate_length_of(:foo, :minimum => 1).description.should == "model to validate the length of foo within 1 and Infinity"
    end
  
    it "should match when the validation is present" do
      @model.should validate_length_of(:name, :minimum => 2)
    end
  
    it "should not match when the minimum accepted length is too low" do
      @model.should_not validate_length_of(:name, :minimum => 3)
    end
  
    it "should not match when the minimum accepted length  is too high" do
      @model.should_not validate_length_of(:name, :minimum => 1)
    end
  
    it "should not match when the validation is not present" do
      @model.should_not validate_length_of(:foo, :minimum => 1)
    end
  end
  
  describe "using 'maximum'" do
    class LengthMinimumModel < PseudoActiveRecord
      attr_accessor :name
      validates_length_of :name, :maximum => 20
    end

    before do
      @model = LengthMinimumModel.new
    end

    it "should have the label 'model to validate the length of <attr> within 0 and <max>'" do
      validate_length_of(:foo, :maximum => 2).description.should == "model to validate the length of foo within 0 and 2"
    end
  
    it "should match when the validation is present" do
      @model.should validate_length_of(:name, :maximum => 20)
    end
  
    it "should not match when the maximum accepted length is too low" do
      @model.should_not validate_length_of(:name, :maximum => 21)
    end
  
    it "should not match when the maximum accepted length  is too high" do
      @model.should_not validate_length_of(:name, :maximum => 19)
    end
  
    it "should not match when the validation is not present" do
      @model.should_not validate_length_of(:foo, :maximum => 1)
    end
  end

  describe "using 'is'" do
    class LengthIsModel < PseudoActiveRecord
      attr_accessor :name
      validates_length_of :name, :is => 4
    end

    before do
      @model = LengthIsModel.new
    end

    it "should have the label 'model to validate the length of <attr> within <length> and <length>'" do
      validate_length_of(:foo, :is => 3).description.should == "model to validate the length of foo within 3 and 3"
    end
  
    it "should match when the validation is present" do
      @model.should validate_length_of(:name, :is => 4)
    end
  
    it "should not match when the validation is not present" do
      @model.should_not validate_length_of(:foo, :is => 4)
    end
  end
end

describe "'validate_uniqueness_of' matcher" do
  class UniquenessModel < PseudoActiveRecord
    attr_accessor :name
    validates_uniqueness_of :name
  end

  before do
    @model = UniquenessModel.new
    mock_column = mock('ActiveRecord::ConnectionAdapters::Column')
    mock_column.stub!(:text?).and_return(false)
    UniquenessModel.stub!(:columns_hash).and_return('name' => mock_column, 'foo' => mock_column)
    UniquenessModel.stub!(:quoted_table_name).and_return('uniqeness_models')
  end
  
  it "should have the label 'model to validate the uniqueness of <attr>'" do
    validate_uniqueness_of(:foo).description.should == "model to validate the uniqueness of foo"
  end
  
  it "should match when the validation is present" do
    @model.should validate_uniqueness_of(:name)
  end
  
  it "should not match when the validation is not present" do
    @model.should_not validate_uniqueness_of(:foo)
  end
end

describe "'validate_confirmation_of' matcher" do
  class ConfirmationModel < PseudoActiveRecord
    attr_accessor :name
    validates_confirmation_of :name
  end

  before do
    @model = ConfirmationModel.new
  end
  
  it "should have the label 'model to validate the confirmation of <attr>'" do
    validate_confirmation_of(:foo).description.should == "model to validate the confirmation of foo"
  end
  
  it "should match when the validation is present" do
    @model.should validate_confirmation_of(:name)
  end
  
  it "should not match when the validation is not present" do
    @model.should_not validate_confirmation_of(:foo)
  end
end

describe "'validate_inclusion_of' matcher" do
  class InclusionModel < PseudoActiveRecord
    STATES = %w{open closed}
    attr_accessor :state
    validates_inclusion_of :state, :in => STATES
  end

  before do
    @model = InclusionModel.new
    @model.stub!(:inspect).and_return( "#<InclusionModel id: nil, state: nil, foo: nil>")
  end

  it "should have the label 'model to validate the inclusion of <attr> on list <list>'" do
    validate_inclusion_of(:state, :in => InclusionModel::STATES).description.should == 'model to validate the inclusion of state on list ["open", "closed"]'
  end

  it "should match when the validation is present" do
    @model.should validate_inclusion_of(:state, :in => InclusionModel::STATES)
  end

  it "should not match when the validation uses a different list" do
    @model.should_not validate_inclusion_of(:state, :in => %w{foo bar})
  end

  it "should not match when the validation is not present" do
    @model.should_not validate_inclusion_of(:foo, :in => %w{foo bar})
  end
end

describe "'validate_numericality_of' matcher" do
  class NumericalityModel < PseudoActiveRecord
    attr_accessor :number
    validates_numericality_of :number
  end

  before do
    @model = NumericalityModel.new
    @model.stub!(:inspect).and_return( "#<NumericalityModel id: nil, number: nil, foo: nil>")
  end
  
  it "should have the label 'model to validate the numericality of <attr>'" do
    validate_numericality_of(:foo).description.should == "model to validate the numericality of foo"
  end
  
  it "should match when the validation is present" do
    @model.should validate_numericality_of(:number)
  end
  
  it "should not match when the validation is not present" do
    @model.should_not validate_numericality_of(:foo)
  end
end

