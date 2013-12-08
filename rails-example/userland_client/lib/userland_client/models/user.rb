module UserlandClient
  class User
    include Virtus.model

    attribute :login, String
    attribute :password, String

    def self.login(login, password)
      Userland.get('/users/login', body: {login: login, password: password})
    end
  end
end
