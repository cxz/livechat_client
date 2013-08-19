LiveChat API Ruby Client
=======================

## Install

Via rubygems.org:

```
$ gem install livechat_client
```

To build and install the development branch yourself from the latest source:

```
$ git clone git@github.com:cxz/livechat_client.git
$ cd livechat_client
$ git checkout -b develop
$ rake gem
$ gem install pkg/livechat-client-{version}
```


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
@livechat.agents                          # all agents
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


[Canned responses](http://developers.livechatinc.com/rest-api/#!canned-responses)
-----------


**List all canned responses**
```ruby
  @livechat.canned_responses
```

**Get a single canned response**
```ruby
  @livechat.canned_responses(3151)
```

**Create a new canned response**
```ruby
  @livechat.canned_responses.create do |r|
    r[:text] = 'Have a great day, goodbye.'
    r[:tags] = ['cu', 'bye']
  end
```

**Update a canned response**
```ruby
  @livechat.canned_responses(3151).update do |r|
    r[:tags] = ['bye']
  end
```

**Remove a canned response**
```ruby
  @livechat.canned_responses(3151).delete
```



[Chats](http://developers.livechatinc.com/rest-api/#!chats)
-----------

**Get list of chats**
```ruby
  @livechat.chats
```

**Get single chat**
```ruby
  @livechat.chats('MH022RD0K5')
```

**Send chat transcript to e-mail**
```ruby
  @livechat.chats('MH022RD0K5').send_transcript(:to => 'john.doe@mycompany.com')
```


[Goals](http://developers.livechatinc.com/rest-api/#!goals)
-----------


**List all goals**
```ruby
  @livechat.goals
```

**Get a single goal details**
```ruby
  @livechat.goals(1181)
```

**Mark goal as successful**
```ruby
  @livechat.goals(1181).mark_as_successful(:visitor_id => 1)
```

**Add a new goal**
```ruby
  @livechat.goals.create do |goal|
    goal[:name] = 'new goal'
    goal[:type] = 'url'
  end
```

**Update a goal**
```ruby
  @livechat.goals(2231).update do |goal|
    goal[:name] = 'updated goal'
  end
```

**Remove a goal**
```ruby
  @livechat.goals(2231).delete
```


[Groups](http://developers.livechatinc.com/rest-api/#!groups)
-----------


**List all groups**
```ruby
  @livechat.groups
```

**Get a single group details**
```ruby
  @livechat.groups(2)
```

**Create a new group**
```ruby
  @livechat.groups.create do |goal|
    group[:name] = 'Human Resources'
    group[:agents] = ['jenny.doe@mycompany.com', 'john.doe@mycompany.com']
  end
```

**Update a group**
```ruby
  @livechat.groups(3).update do |goal|
    group[:name] = 'Quality Assurance'
    group[:agents] = ['jane.doe@mycompany.com']
  end
```

**Remove a group**
```ruby
  @livechat.groups(4).delete
```

[Reports](http://developers.livechatinc.com/rest-api/#!reports)
-----------

**Get dashboard data**
```ruby
  @livechat.reports.dashboard
```

**Get dashboard data for agent**
```ruby
  @livechat.reports.dashboard(:agent => 'john.doe@mycompany.com')
```

**Get dashboard data for group**
```ruby
  @livechat.reports.dashboard(:group => 1)
```

**Get chats report**
```ruby
  @livechat.reports.chats(:date_from => '2013-01-01')
```

**Get ratings report**
```ruby
  @livechat.reports.ratings(:group => 1)
```

**Get ratings ranking**
```ruby
  @livechat.reports.ratings_ranking(:group => 1)
```

**Get queued visitors report**
```ruby
  @livechat.reports.queued_visitors(:date_from => '2013-01-01')
```

**Get queue waiting times report**
```ruby
  @livechat.reports.queued_visitors_waiting_times(:date_from => '2013-01-01')
```

**Get availability report**
```ruby
  @livechat.reports.availability
```

**Get chatting time report**
```ruby
  @livechat.reports.chatting_time
```

**Get goals report**
```ruby
  @livechat.reports.goals
```


[Status](http://developers.livechatinc.com/rest-api/#!status)
-----------

**Get status**
```ruby
  @livechat.status(:group => 0)
```


[Visitors](http://developers.livechatinc.com/rest-api/#!visitors)
-----------

**List all visitors**
```ruby
  @livechat.visitors
```

**List only chatting visitors**
```ruby
  @livechat.visitors.chatting
```

**Add custom visitor details**
```ruby
  @livechat.visitors('S1352647457.ac951bfe2e').add_details do |detail|
    detail[:license_id] = '12345'
    detail[:token] = '26132406c42c96ba61ed42689b70f719'
    detail[:id] = 'my-app'
    detail[:fields] = [{:name => 'Age', :value => 36}]
  end
```


Contributing
------------


Ways you can help:

  * report bugs
  * writing/fixing documentation
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
Copyright (c) 2013 Alexandre Maia

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
