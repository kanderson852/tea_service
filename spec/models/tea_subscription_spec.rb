require 'rails_helper'

describe TeaSubscription do
  describe 'relationships' do
    it {should belong_to(:tea)}
    it {should belong_to(:subscription)}
  end
end
