require 'spec_helper'
require 'first'

describe 'shenaningns with double' do
  it 'is playground' do
    dbl = double("Some Collaborator", :foo => 3, :bar => 4)
    expect(dbl.foo).to eq(3)
    expect(dbl.bar).to eq(4)
  end

  context 'with initializer' do
    it 'displays normal name from real class' do
      ceo = Employee.new(name: 'Blabla')
      expect(ceo.name).to eq 'Blabla'
      job = Job.new(ceo)
      expect(job.ceo_name).to eq 'Blabla'
    end
    
    it 'displays doubled name but not from a real class' do
      ceo = double(Employee, name: 'John')
      job = Job.new(ceo)
      expect(job.ceo_name).to eq 'John'
    end
  end

  context 'with call to a different class method' do
    # this is usefull for testing and stubbing Rails log

    # note: if there are calls of 'info' with diffrent param than
    #       'hello from a new job' then it will crash with 'received unexpected message'
    it 'spy on class method BEFORE you invoked the code' do
      fake_log = class_double(Log).
        as_stubbed_const(:transfer_nested_constants => true)

      expect(fake_log).to receive(:info).with('hello from a new job!')

      job = Job.new
      job.log_me!
    end

    it 'spy on class method AFTER you invoked the code' do
      allow(Log).to receive(:info)

      job = Job.new
      job.log_me!

      expect(Log).to have_received(:info).with('hello from a new job!')
    end
  end


  describe "have_received - a smaoke test" do
    
    # Message expectations put an example's expectation at the start, before you've invoked the
    # code-under-test. Many developers prefer using an arrange-act-assert (or given-when-then)
    # pattern for structuring tests. Spies are an alternate type of test double that support this
    # pattern by allowing you to expect that a message has been received after the fact, using
    # have_received.  

    it "passes when the message has been received" do
      invitation = spy('invitation')
      invitation.deliver
      expect(invitation).to have_received(:deliver)
    end
  end
end

