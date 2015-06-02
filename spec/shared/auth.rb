shared_examples 'unauthorized request' do
  it 'return 401 status' do
    expect(subject.status).to eq 401
  end
end
