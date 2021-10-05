# frozen_string_literal: true

require_relative 'base_class'

class CartsRequests < Base
  def post_cart(token, payload)
    self.class.post('/carrinhos', headers: { "Authorization": token, "Content-Type": 'application/json' },
                                  body: payload.to_json)
  end
end
