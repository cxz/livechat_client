require "test_helper"

describe Livechat::Client::Tickets do
  before do
    @zendesk = Livechat::Client.new do |config|
      config.account = ENDPOINT
      config.basic_auth EMAIL, PASSWORD
    end

#     @ticket_id = ENV["LIVE"] ? @livechat.tickets[-1]["id"] : 123
  end

  describe "Tickets API" do
    it "should fit this API" do
#       # POST
#       ticket = @livechat.tickets.create do |t|
#         t[:subject] = "help, my toilet fell into the toilet"
#         t[:description] = "not my fault"
#       end

#       # GET
#       @livechat.tickets(ticket.id).fetch
# 
#       # PUT
#       @livechat.tickets(ticket.id).update do |t|
#         t[:set_tags] = "yikes"
#       end
# 
#       # DELETE
#       @livechat.tickets(ticket.id).delete
    end
  end

end
