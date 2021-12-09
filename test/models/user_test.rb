require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "User", email: "user@example.com",
                     phone: "+3333333333", password: 'foobar',
                     password_confirmation: 'foobar')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "username should not be too short" do
    @user.username = "a"
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "username validation should accept valid names" do
    valid_names = %w[user Userrrrrrrr USER Us_Er]
    valid_names.each do |valid_names|
      @user.username = valid_names
      assert @user.valid?, "#{valid_names.inspect} should be valid"
    end
  end

  test "username validation should reject invalid names" do
    valid_names = %w[u__ser |User| U.s.e.r u.ser]
    valid_names.each do |valid_names|
      @user.username = valid_names
      assert_not @user.valid?, "#{valid_names.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.phone = "+9876543210"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "phone should be present" do
    @user.phone = "     "
    assert_not @user.valid?
  end

  test "phone should not be too short" do
    @user.phone = "+" + "3" * 7
    assert_not @user.valid?
  end

  test "phone should not be too long" do
    @user.phone = "+" + "3" * 16
    assert_not @user.valid?
  end

  test "phone validation should accept valid numbers" do
    valid_phones = %w[+3333333333 +4444444444444]
    valid_phones.each do |valid_phones|
      @user.phone = valid_phones
      assert @user.valid?, "#{valid_phones.inspect} should be valid"
    end
  end

  test "phone validation should reject invalid numbers" do
    valid_phones = %w[+333(33)33333 333(33)33333 33333333333 +3333333-33-3
                      3333333-33-3 ++3333333333 eeeeeeeeee EEEEEEEEE]
    valid_phones.each do |valid_phone|
      @user.phone = valid_phone
      assert_not @user.valid?, "#{valid_phone.inspect} should be invalid"
    end
  end

  test "phone numbers should be unique" do
    duplicate_user = @user.dup
    @user.email = "ddddddddd@ddddd.dddd"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
