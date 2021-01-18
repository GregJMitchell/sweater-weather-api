require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  it 'API key creation' do
    user = create :user
    expect(user.api_key).to_not be_nil
  end

  it 'Keys are unique' do
    users = create_list(:user, 5)

    keys = users.map { |user| user.api_key }

    i = 0
    keys.any? do |key|
      i += 1
      key == keys[i]
    end
  end
end
