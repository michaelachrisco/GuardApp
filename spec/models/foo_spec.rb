require 'rails_helper'
describe Foo do
  it 'is invalid without a name' do
    is_expected.to validate_presence_of(:name)
  end
  it 'is invalid without a key' do
    is_expected.to validate_presence_of(:key)
  end
end
