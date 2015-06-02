require 'spec/rack_helper'

describe Avito::Api, type: :controller do
  describe '/api' do
    subject {  get '/api' }
    it { is_expected.to be_ok }
  end
end
