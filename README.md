LiveChat API Ruby Client
=======================

Connection
----------

Basic Auth over HTTPS is used to authenticate API requests.

```ruby
require "livechat"

@livechat = LiveChat::Client.new do |config|
  config.login = "joe@example.com"
  config.api_key = ""
end
```

[Agents](http://developers.livechatinc.com/rest-api/#!agents)
-----

**List all agents**

```ruby
@livechat.agents.fetch                    # all agents
@livechat.agents.each {|user| ..code.. }  # iterate over requested agents
```

**Get a single agent details**
```ruby
@livechat.agents('john.doe@mycompany.com')
```

**Create a new agent**
```ruby
@livechat.agents.create do |a|
  a[:login] = @alice_id
  a[:name] = 'Alice'
end
```

**Update an agent**
```ruby
@livechat.agents(@jane_id).update do |a|
  a[:job_title] = 'Tester'
  a[:status] = 'not accepting chats'
end
```

**Reset an API key**
```ruby
  @livechat.agents('john.doe@mycompany.com').reset_api_key
```

**Remove an agent**
```ruby
  @livechat.agents('john.doe@mycompany.com').delete
```


Canned responses
-----------



Chats
-----------



Goals
-----------




Groups
-----------


Reports
-----------



Status
-----------



Visitors
-----------


Contributing
------------


Ways you can help:

  * report bugs
  * writing/fixing documentation
  * writing specifications (provide suggestions for API v2)
  * writing code (refactoring, strengthening areas that are weak, catching typos)

Note on Patches/Pull Requests
-----------------------------
  * Fork the project.
  * Make your feature addition or bug fix.
  * Add tests for it. This is important so we don't break it in a future version unintentionally.
  * Commit
  * Send a pull request. Bonus points for topic branches.

MIT License
-----------
Copyright (c) 2013 LiveChat Inc

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
