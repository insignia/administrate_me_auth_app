require File.dirname(__FILE__) + '/spec_helper'

describe 'View matchers' do
  before do
    @response = mock 'response'
    @matcher = mock 'tag matcher'
    @matcher.stub!(:matches?).with(@response).and_return true
  end

  describe "'have_form_posting_to' matcher" do
    it 'should have the label "have a form submitting via POST to \'<target>\'"' do
      have_form_posting_to(:foo).description.should == "have a form submitting via POST to 'foo'"
    end
    
    it 'should wrap have_tag("form[method=post][action=<action>]")' do
      should_receive(:have_tag).with("form[method=post][action=foo]").and_return @matcher
      @response.should have_form_posting_to(:foo)
    end
  end

  describe "'have_form_puting_to' matcher" do
    it 'should have the label "have a form submitting via PUT to \'<target>/<id>\'"' do
      have_form_puting_to(:foo, 1).description.should == "have a form submitting via PUT to 'foo/1'"
    end
    
    it 'should wrap have_tag("form[method=post][action=<action>]")' do
      should_receive(:have_tag).with("form[method=post][action=foo/1]").and_return @matcher
      should_receive(:have_tag).with("input[name=_method][type=hidden][value=put]").and_return @matcher
      @response.should have_form_puting_to(:foo, 1)
    end
  end

  describe "'have_label_for' matcher" do
    it 'should have the label "have a label for \'<attribute>\' with value of \'<text>\'"' do
      have_label_for(:foo, 'bar').description.should == "have a label for 'foo' with value of 'bar'"
    end
    
    it 'should wrap have_tag("label[for=<attribute>]")' do
      should_receive(:have_tag).with("label[for=foo]").and_return @matcher
      @response.should have_label_for(:foo, 'bar')
    end
    
    it 'should also check the text'
  end

  describe "'with_label_for' matcher" do
    it 'should have the label "with a label for \'<attribute>\' with value of \'<text>\'"' do
      with_label_for(:foo, 'bar').description.should == "with a label for 'foo' with value of 'bar'"
    end
    
    it 'should wrap with_tag("label[for=<attribute>]")' do
      should_receive(:with_tag).with("label[for=foo]").and_return @matcher
      @response.should with_label_for(:foo, 'bar')
    end
    
    it 'should also check the text'
  end

  describe "'have_text_field_for' matcher" do
    it 'should have the label "have a text field for \'<attribute>\'"' do
      have_text_field_for(:foo).description.should == "have a text field for 'foo'"
    end
    
    it 'should wrap have_tag("input#<attribute>[type=text]")' do
      should_receive(:have_tag).with("input#foo[type=text]").and_return @matcher
      @response.should have_text_field_for(:foo)
    end
  end

  describe "'with_text_field_for' matcher" do
    it 'should have the label "with a text field for \'<attribute>\'"' do
      with_text_field_for(:foo).description.should == "with a text field for 'foo'"
    end
    
    it 'should wrap with_tag("input#<attribute>[type=text]")' do
      should_receive(:with_tag).with("input#foo[type=text]").and_return @matcher
      @response.should with_text_field_for(:foo)
    end
  end

  describe "'have_text_area_for' matcher" do
    it 'should have the label "have a text area for \'<attribute>\'"' do
      have_text_area_for(:foo).description.should == "have a text area for 'foo'"
    end
    
    it 'should wrap have_tag("textarea#<attribute>[type=text]")' do
      should_receive(:have_tag).with("textarea#foo[type=text]").and_return @matcher
      @response.should have_text_area_for(:foo)
    end
  end

  describe "'with_text_area_for' matcher" do
    it 'should have the label "with a text area for \'<attribute>\'"' do
      with_text_area_for(:foo).description.should == "with a text area for 'foo'"
    end
    
    it 'should wrap with_tag("textarea#<attribute>[type=text]")' do
      should_receive(:with_tag).with("textarea#foo[type=text]").and_return @matcher
      @response.should with_text_area_for(:foo)
    end
  end

  describe "'have_password_field_for' matcher" do
    it 'should have the label "have a password field for \'<attribute>\'"' do
      have_password_field_for(:foo).description.should == "have a password field for 'foo'"
    end
    
    it 'should wrap have_tag("input#<attribute>[type=password]")' do
      should_receive(:have_tag).with("input#foo[type=password]").and_return @matcher
      @response.should have_password_field_for(:foo)
    end
  end

  describe "'with_password_field_for' matcher" do
    it 'should have the label "with a password field for \'<attribute>\'"' do
      with_password_field_for(:foo).description.should == "with a password field for 'foo'"
    end
    
    it 'should wrap with_tag("input#<attribute>[type=password]")' do
      should_receive(:with_tag).with("input#foo[type=password]").and_return @matcher
      @response.should with_password_field_for(:foo)
    end
  end

  describe "'have_checkbox_for' matcher" do
    it 'should have the label "have a checkbox for \'<attribute>\'"' do
      have_checkbox_for(:foo).description.should == "have a checkbox for 'foo'"
    end
    
    it 'should wrap have_tag("input#<attribute>[type=checkbox]")' do
      should_receive(:have_tag).with("input#foo[type=checkbox]").and_return @matcher
      @response.should have_checkbox_for(:foo)
    end
  end

  describe "'with_checkbox_for' matcher" do
    it 'should have the label "with a checkbox for \'<attribute>\'"' do
      with_checkbox_for(:foo).description.should == "with a checkbox for 'foo'"
    end
    
    it 'should wrap with_tag("input#<attribute>[type=checkbox]")' do
      should_receive(:with_tag).with("input#foo[type=checkbox]").and_return @matcher
      @response.should with_checkbox_for(:foo)
    end
  end

  describe "'have_submit_button' matcher" do
    it 'should have the label "have a submit button"' do
      have_submit_button.description.should == "have a submit button"
    end
    
    it 'should wrap have_tag("input[type=submit]")' do
      should_receive(:have_tag).with("input[type=submit]").and_return @matcher
      @response.should have_submit_button
    end
  end

  describe "'with_submit_button' matcher" do
    it 'should have the label "with a submit button"' do
      with_submit_button.description.should == "with a submit button"
    end
    
    it 'should wrap with_tag("input[type=submit]")' do
      should_receive(:with_tag).with("input[type=submit]").and_return @matcher
      @response.should with_submit_button
    end
  end

  describe "'have_link_to' matcher" do
    it 'should have the label "have a link to \'<link>\'"' do
      have_link_to('foo', 'bar').description.should == "have a link to 'foo'"
    end
    
    it 'should wrap have_tag("a[href=<link>]", "<text")' do
      should_receive(:have_tag).with('a[href=foo]', 'bar').and_return @matcher
      @response.should have_link_to('foo', 'bar')
    end
  end

  describe "'with_link_to' matcher" do
    it 'should have the label "with a link to \'<link>\'"' do
      with_link_to('foo', 'bar').description.should == "with a link to 'foo'"
    end
    
    it 'should wrap with_tag("a[href=<link>]", "<text")' do
      should_receive(:with_tag).with('a[href=foo]', 'bar').and_return @matcher
      @response.should with_link_to('foo', 'bar')
    end
  end
end