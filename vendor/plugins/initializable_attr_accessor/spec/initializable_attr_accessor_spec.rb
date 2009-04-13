require File.dirname(__FILE__) + '/../lib/initializable_attr_accessor.rb'

class SomeClass
  initializable_attr_accessor :first_name, :last_name
end

describe SomeClass do

  it "should allow attributes be initialized with a hash" do
    @some_instance = SomeClass.new(:first_name => 'Carlos', :last_name => 'Kozuszko')
    @some_instance.first_name.should == 'Carlos'
    @some_instance.last_name.should == 'Kozuszko'
  end

  it "should allow attributes be initialized with a list of parameters" do
    @some_instance = SomeClass.new('Carlos', 'Kozuszko')
    @some_instance.first_name.should == 'Carlos'
    @some_instance.last_name.should == 'Kozuszko'
  end

end

