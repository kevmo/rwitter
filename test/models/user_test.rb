require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Data validation

  def setup
    @user = User.new(name: "Example Name", email: "User@email.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # Presence validation


  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  # Length validation

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "@" * 244 + "@example.com"
    assert_not @user.valid?
  end


  # Format validation

  test "email validation should accept valid addresses" do
    valid_addys = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
                     first.last@gmail.jp alice+bob@baz.cn]

    valid_addys.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should not accept invalid addresses" do
    invalid_addys = %w[user@example,com user_at_foo.org user.name@example
                       foo@bar+bax.com]

    invalid_addys.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should not be valid"
    end
  end

  # Uniqueness validation

  test "email addresses should be unique" do
    dupe_user = @user.dup
    dupe_user.email = @user.email.upcase
    @user.save
    assert_not dupe_user.valid?
  end

end
