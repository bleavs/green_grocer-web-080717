def consolidate_cart(cart)
  # code here
  consolidated = {}
  
  cart.each do |food|
      food.each do |item, info|
          if !consolidated.keys.include?(item)
              info[:count] = 1
              consolidated[item] = info
          else
              consolidated[item][:count] += 1
          end
          
      end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # code here
  coupon_hash = {}
  
  cart.each do |item, info|
      coupon_hash[item] = info
      
      coupons.each do |coupon|
          if item == coupon[:item]
              if info[:count] >= coupon[:num]
                  info[:count] -= coupon[:num]
              
                  if coupon_hash.include?(item + " W/COUPON")
                      coupon_hash[item + " W/COUPON"][:count] += 1
                  else
                      coupon_hash[item + " W/COUPON"] = {
                          :price => coupon[:cost],
                          :clearance => info[:clearance],
                          :count => 1
                  }
                  end
              end
         end
      end
   end
  coupon_hash
end

def apply_clearance(cart)
  # code here
  clearance_hash = {}
  cart.each do |item, info|
      if info[:clearance]
          info[:price] = (info[:price] * 0.8).round(2)
      end
      clearance_hash[item] = info
  end
  clearance_hash
end

def checkout(cart, coupons)
  # code here
  total = 0.00
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  cart.each do |item, info|
      total += (info[:price] * info[:count])
  end
  
  if total > 100
      total *= 0.9
  end
  
  total
end
