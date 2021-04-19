require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  # this method run before everyone in our test
  def setup
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
    assert @category.valid? #can we instantiate a new category instance variable and it's valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid? #if this return true, the test fails
  end

  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end
