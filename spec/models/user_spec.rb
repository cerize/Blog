require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "requires a first name" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:first_name)
    end

    it "requires a last name" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:last_name)
    end

    it "requires an email" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:email)
    end

    it "requires a password" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:password)
    end

    it "requires a password with at least 6 characters" do
      u = User.new
      u.password = "12345"
      u.valid?
      expect(u.errors).to have_key(:password)
    end

    it "requires a unique email" do
      u = FactoryGirl.create(:user)
      u1 = User.new email: u.email
      u1.valid?
      expect(u1.errors).to have_key(:email)
    end
  end

  describe ".full_name" do
    it "concatenates the first name and last name" do
      u = FactoryGirl.build(:user)
      expect(u.full_name).to include("#{u.first_name}", "#{u.last_name}")
    end

    it "returns the first name if the last name is missing" do
      u = FactoryGirl.build(:user, {last_name: nil})
      expect(u.full_name).to eq(u.first_name)
    end
  end

  describe "password generating" do
    it "generates a password digest on creation" do
      u = FactoryGirl.build(:user)
      expect(u.password_digest).to be
    end
  end
end
