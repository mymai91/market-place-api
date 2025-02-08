require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'user with a valid email should be valid' do
    user = User.new(email: 'test@test.org', password: 'password123')

    assert user.valid?
  end

  test 'user with a invalid email should be valid' do
    user = User.new(email: 'test', password: 'password123')

    assert_not user.valid?
  end

  test 'user with a taken email should be invalid' do
    other_user = users(:one)

    user = User.new(email: other_user.email, password: 'password123')

    assert_not user.valid?
  end
end
