Flower Shop

A flower shop sells their flowers in bundles and charges their customers on a bundled basis. If the shop sells roses in bundles of 5 and 10, and a customer orders 15, they will get a bundle of 10 and a bundle of 5.

## Getting started
### Install the gem
```
gem 'flower_shop', :git => 'git://github.com/saluminati/flower-shop.git'
```
### Configure in your project
#### Option 1 ( By providing the inventory items as array) 


```ruby
require 'flower_shop'


FlowerShop.configure  do |config|
	config.inventory_type = 'array'
	config.inventory_meta_deta = [
			'Rose Anita A80 5@40',
			'Rose Ballerina b22 10@40.33'
			]
end
```

#### Option 2 ( By providing the path of the file containing inventory items) 


```ruby
require 'flower_shop'


FlowerShop.configure  do |config|
	config.inventory_type = 'file'
	config.inventory_meta_deta = 'file_path'
end
```
**Inventory Item format**

 Inventory item should be in the correct format, correct formats examples:
```
Rose Anita A80 5@40

Rose,Anita,A80,5@40
```
 **File path should be absolute**

The system is constructed from multiple distinct components:

### Place order example
```ruby
order_items = FlowerShop.place_order(quantity: 10, product_code: 'A80')
```
This method will find the product by its product code and consume minimal bundles to fulfill orders and return the bundles array

# Still having issues
[Download the repo containing sample code](https://github.com/saluminati/flower_shop_sample_code)


## TODOs
- place_order method is by default saving space by minimal bundles of flowers, in the future, it can be done by introducing a sort_by price, space, specials etc.

- Add a method to list the available products from the inventory
