describe Note do

  before(:each) { @note = Note.new(content: 'My test content.') }

  subject { @note }

  it { should respond_to(:content) }

  it "#content returns a string" do
    expect(@note.content).to match 'My test content.'
  end

end
