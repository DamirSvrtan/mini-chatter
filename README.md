#Mini Chatter

Minimalistic real-time chat application (merely 100 lines of code) using only [Ruby](https://www.ruby-lang.org/en/), [Rack](http://rack.github.io/) and [Websocket-Rack](https://github.com/imanel/websocket-rack). Not for use, just as a basic concept. There is also an exact same application using [Faye](http://faye.jcoglan.com/) over [here](https://github.com/DamirSvrtan/mini-chatter-faye).

#Screenshot:
![alt text](http://oi60.tinypic.com/2n7mn15.jpg "Chatter index")

#Usage:

```ruby
git clone git@github.com:DamirSvrtan/mini-chatter.git
cd mini-chatter
bundle install
thin -R config.ru start
```
