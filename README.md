LiveChat API Ruby Client
=======================

Connection
----------

Basic Auth over HTTPS is currently the supported way to authenticate API requests.

```ruby
require "livechat"

@livechat = LiveChat::Client.new do |config|
  config.login = "joe@example.com"
  config.api_key = ""
end
```


Collections
-----------
Collections are an implementation detail of this gem, they are Enumerable objects. The intention is to make fetching results that span across "pages"
transparent or fetching a specific page of results easily. Collections define:

  * `fetch`        - perform actual GET request manually, returns response body as JSON or XML
  * `each`         - iterate the individual results of the collection (calling `fetch` on your behalf)
  * `next_page`    - GET next page of results for that collection
  * `per_page(50)` - change the number of results for a page of results
  * `page(3)`      - GET specific page of results

Collections of resources are fetched as lazily as possible. For example `@livechat.agents` does not hit the API until it is iterated over
(by calling `each`) or until an item is asked for (e.g., `@livechat.users[0]`).

This allows us chain methods in cool ways like:

  * `@livechat.agents.create({ ... data ... })`
  * `@livechat.agents(123).update({ ... data ... })`
  * `@livechat.agents(123).delete`

GET requests are not made until the last possible moment. Calling `fetch` will return the HTTP response (first looking in the cache). If you
want to avoid the cached result you can call `fetch(true)` which will force the client to update its internal cache with the latest HTTP response.

PUT (update), POST (create) and DELETE (delete) requests are fired immediately.



Agents
-----

**GET**

You may fetch agents individually by id

```ruby
@livechat.agents(123)                       # return agent by id
```

all users

```ruby
@livechat.agents                          # all agents
@livechat.agents.each {|user| ..code.. }  # iterate over requested agents
@livechat.agents.per_page(100)            # all users in account (v2 should accept `?per_page=NUMBER`)
@livechat.agents.page(2)                    # all users in account (v1 currently accepts `?page=NUMBER`)
@livechat.agents.next_page                  # all users in account (v1 currently accepts `?page=NUMBER`)
```

a list of users matching criteria

```ruby
@livechat.users("Bobo")                    # all users with name matching all or part of "Bobo"
@livechat.users("Bobo", :role => :admin)   # all users with name matching all or part of "Bobo" who are admins
@livechat.users(:role => :agent)           # all users who are agents
@livechat.users(:role => "agent")          # all users who are agents
@livechat.users(:group => 123)             # all users who are members of group id
@livechat.users(:organization => 123)      # all users who are members of organization id
@livechat.user(123).identities             # all identities in account for a given user
```

**POST**

A successful POST will return the created user in the response body along with a Location header with the URI to the newly created resource

```ruby
# create user from hash
@livechat.users.create({:name => "Bobo Yodawg",
                       :email => "bc@email.com",
                       :remote_photo_url => "http://d.com/image.png",
                       :roles => 4})

# create user with block
@livechat.users.create do |user|
  user[:name] = "Bobo Yodawg"
  user[:email] = "bc@email.com"
  user[:remote_photo_url] = "http://d.com/image.png"
  user[:roles] = 4
end
```

**PUT**

A successful PUT will return the updated user in the response body

edit user with hash

```ruby
@livechat.users(123).update({:remote_photo_url => "yo@dawg.com"})
```

or edit user with block

```ruby
@livechat.users(123).update do |user|
  user[:remote_photo_url] = "yo@dawg.com"
end
```

**DELETE**

```ruby
@livechat.users(123).delete
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
