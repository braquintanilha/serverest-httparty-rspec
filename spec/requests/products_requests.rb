# frozen_string_literal: true

require_relative 'base_class'

class ProductsRequests < Base
  def get_all_products
    self.class.get('/produtos')
  end

  def get_product_by_id(id)
    self.class.get("/produtos/#{id}")
  end

  def delete_product(token, id)
    self.class.delete("/produtos/#{id}", headers: { "Authorization": token })
  end

  def post_product(token, payload)
    self.class.post('/produtos', headers: { "Authorization": token, "Content-Type": 'application/json' },
                                 body: payload.to_json)
  end

  def put_product(token, id, payload)
    self.class.put("/produtos/#{id}", headers: { "Authorization": token, "Content-Type": 'application/json' },
                                      body: payload.to_json)
  end
end
