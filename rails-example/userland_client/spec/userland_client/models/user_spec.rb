describe User do
  describe "#login" do
    it "passes the request back to userland" do
      Userland::User.login(@login, @password)
      pending "figure out how to mock this.."
    end
  end
end
