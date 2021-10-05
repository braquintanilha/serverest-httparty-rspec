require_relative 'base_class'

class UsersRequests < Base
    def get_all_users
        self.class.get('/usuarios/')
    end

    def get_user_by_id(id)
        self.class.get("/usuarios/#{id}")
    end

    def delete_user(id)
        self.class.delete("/usuarios/#{id}")
    end

    def post_user(payload)
        self.class.post('/usuarios', headers: { "Content-Type": "application/json" }, body: payload)
    end

    def put_user(id, payload)
        self.class.put("/usuarios/#{id}", headers: { "Content-Type": "application/json" }, body: payload)
    end
end
