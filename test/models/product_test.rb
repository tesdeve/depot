require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products   

  test "product attributes must not be empty" do 
    product = Product.new
    assert product.invalid?
    assert product.valid? == false

    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end  


  test 'product price must be positive' do 
    product = Product.new(title: 'Book to be Added 10 Chars',
                          description: 'Good Book',
                          image_url:  '7apps.jpg')

    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0 
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0.01
    assert product.valid?

  end 

  def new_product(image_url) 
    Product.new(title: 'A Book with 10 Characters', 
                description: 'Good Read', 
                price: 1, 
                image_url: image_url) 
  end  


  test "image url" do 
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg 
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |image_url| 
      assert new_product(image_url).valid?, "#{image_url} is valid"  
    end

    bad.each do |image_url| 
      assert new_product(image_url).invalid?, "#{image_url} is invalid}"
    end 

  end

  test 'title must be unique' do 
    product = Product.new(title: products(:one).title, description: 'Good Book',
                               image_url:  '7apps.jpg', price: 1) 
    assert product.invalid?

    #assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end 

  test 'title must be at least ten characters' do 
    product = Product.new(title: "the bor",
                          description: 'Good Borok',
                          image_url:  '7apps.jpg', 
                          price: 10)

    assert product.invalid? 
    assert product.errors[:title].any? 
  end

end
