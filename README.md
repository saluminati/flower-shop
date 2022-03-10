

A flower shop sells their flowers in bundles and charges their customers on a bundled basis. If the shop sells roses in bundles of 5 and 10, and a customer orders 15, they will get a bundle of 10 and a bundle of 5.

## Getting started
### Install the gem

Add this to your Gemfile
```
gem 'flower_shop', :git => 'git://github.com/saluminati/flower-shop.git'
```
### Configure in your project
#### Option 1 ( By providing the inventory items as array ) 


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

#### Option 2 ( By providing the path of the file containing inventory items ) 


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


### Place order example
```ruby
order_items = FlowerShop.place_order(quantity: 10, product_code: 'A80')
```
This method will find the product by its product code and consume minimal bundles to fulfill orders and return the bundles array

# Still having issues ?
[Download the repo containing sample code](https://github.com/saluminati/flower_shop_sample_code)

## Approach
Created this gem with the intention of scaling it in the future. The main feature of this gem is to utilize the minimal number of bundles to save volume and match the ordered quantity.

For that, I have created a ``InventorySorterBySpace`` class which receives bundles of a product and order quantity, it sort the bundles by descending order and tries to fill the biggest bundles first and then moves to smaller bundles. Ultimately it creates a combination of all possible combinations the way you can arrange the bundles to accommodate the given ordered quantity of flowers.

Finally, it picks the best combination which saves the most space and matches the ordered quantity.

## Trade-offs
Since ``InventorySorterBySpace`` creates all the possible combinations of bundles and then picks the best which saves us volume, as the inventory grows and each product has more bundles sizes available, this process can become costly. 

To minimize this, for now, I am filtering the bundles list matching with the ordered quantity, for example:

**Bundles available for a product:** ``[100, 80, 50, 10, 5, 3, 2]``
**Ordered quantity:** ``20``
**filtered bundles will become:** ``[10, 5, 3, 2]``

With this approach, our iterations will be smaller and not performance hungry as the inventory grows.


## TODOs
- place_order method is by default saving space by minimal bundles of flowers, in the future, it can be done by introducing a sort_by price, space, specials etc.

- Add a method to list the available products from the inventory
