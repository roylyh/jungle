require "rails_helper"

RSpec.describe Product, type: :model do
  describe "validations" do
    it "will indeed save successfully if a product with all four fields set" do
      @category = Category.new
      @category.name = "Fruits"
      @category.save
      @product = Product.new
      @product.category_id = @category.id
      @product.name = "Apple"
      @product.price_cents = 100
      @product.quantity = 10
      @product.save
      expect(@product.errors).to be_empty
    end

    it "validates: name, presence: true" do
      @category = Category.new
      @category.name = "Fruits"
      @category.save
      @product = Product.new
      @product.category_id = @category.id
      @product.name = nil
      @product.price_cents = 100
      @product.quantity = 10
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "validates: price, presence: true" do
      @category = Category.new
      @category.name = "Fruits"
      @category.save
      @product = Product.new
      @product.category_id = @category.id
      @product.name = "Banana"
      @product.price_cents = nil
      @product.quantity = 10
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Price cents can't be blank"
    end

    it "validates: quantity, presence: true" do
      @category = Category.new
      @category.name = "Fruits"
      @category.save
      @product = Product.new
      @product.category_id = @category.id
      @product.name = "Water Melon"
      @product.price_cents = 1200
      @product.quantity = nil
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "validates: category, presence: true" do
      @product = Product.new
      @product.category_id = nil
      @product.name = "Strawberry"
      @product.price_cents = 200
      @product.quantity = 10
      @product.save
      expect(@product.errors).not_to be_empty
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
