require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    before(:each) do
      @user = User.new
      @user.first_name = "First"
      @user.last_name = "Last"
      @user.email = "last_first@123.com"
      @user.password = "password"
      @user.password_confirmation = "password"
    end

    it "saves successfully when all fields of user are set" do
      @user.save
      expect(@user.errors).to be_empty
    end
    # Step 2
    it "validates password and password_confirmation should be same" do
      @user.password_confirmation = "passwordwrong"
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it "validates: password, presence: true" do
      @user.password = nil
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it "validates: password_confirmation, presence: true" do
      @user.password_confirmation = nil
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
    end
    it "validates: email, presence: true" do
      @user.email = nil
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it "validates: first name, presence: true" do
      @user.first_name = nil
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it "validates: last name, presence: true" do
      @user.last_name = nil
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it "validates: emails must be unique" do
      @user.save
      @user2 = User.new
      @user2.first_name = "First2"
      @user2.last_name = "Last2"
      @user2.email = "last_first@123.com"
      @user2.password = "password2"
      @user2.password_confirmation = "password2"
      @user2.save
      expect(@user2.errors).not_to be_empty
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end
    it "validates: emails must be not case sensitive " do
      @user.save
      @user2 = User.new
      @user2.first_name = "First2"
      @user2.last_name = "Last2"
      @user2.email = "LAST_FIRST@123.COM"
      @user2.password = "password2"
      @user2.password_confirmation = "password2"
      @user2.save
      expect(@user2.errors).not_to be_empty
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end
    # Step 3
    it "validates: password minimum length 6 (length == 6)" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.save
      expect(@user.errors).to be_empty
    end
    it "validates: password minimum length 6 (length < 6)" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
  end

  describe ".authenticate_with_credentials" do
    before(:each) do
      @user = User.new
      @user.first_name = "First"
      @user.last_name = "Last"
      @user.email = "Last_First@123.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
    end
    it "returns instance of user when successfully authenticated" do
      user = User.authenticate_with_credentials("last_first@123.com", "password")
      expect(user).to be_instance_of(User)
    end
    it "returns nil when failed authenticated" do
      user1 = User.authenticate_with_credentials("last_first@123.com", "passwordwrong")
      user2 = User.authenticate_with_credentials("last_first_wrong@123.com", "password")
      expect(user1).to be_nil
      expect(user2).to be_nil
    end
    it "returns instance of user when successfully authenticated (edge cases)" do
      user1 = User.authenticate_with_credentials(" last_first@123.com", "password")
      user2 = User.authenticate_with_credentials("last_first@123.com ", "password")
      user3 = User.authenticate_with_credentials(" last_first@123.com ", "password")
      user4 = User.authenticate_with_credentials("Last_first@123.com", "password")
      expect(user1).to be_instance_of(User)
      expect(user2).to be_instance_of(User)
      expect(user3).to be_instance_of(User)
      expect(user4).to be_instance_of(User)
    end
    it "returns instance of user when successfully authenticated(wrong case on email)" do
      user = User.authenticate_with_credentials("lasT_firsT@123.com", "password")
      expect(user).to be_instance_of(User)
    end
  end
end
