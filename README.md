# mruby-vedis   [![Build Status](https://travis-ci.org/matsumoto-r/mruby-vedis.png?branch=master)](https://travis-ci.org/matsumoto-r/mruby-vedis)
vedis binding by mruby.
vedis is an embeddable datastore C library built with over 70 commands similar in concept to Redis but without the networking layer since Vedis run in the same process of the host application.
Please see [vedis pages](http://vedis.symisc.net/index.html).
## install by mrbgems 
- add conf.gem line to `build_config.rb` 

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :git => 'https://github.com/matsumoto-r/mruby-vedis.git'
end
```
## example 
```ruby
# In-Memory
v = Vedis.new

# On-Disk
# v = Vedis.new "/path/to/vedis.db"

# sym ok
v["test"] = "bbb"
v[:hoge] = 2
v[:foo] = 3
v.set :fuga, "aaa"

# exec
r1 = v.exec "MSET username james age 27 mail dude@example.com"
r2 = v.exec "MGET username age mail"

p v["test"]     #=> "bbb"
p v[:hoge]      #=> "2"
p v["foo"]      #=> "3"
p v.get :fuga   #=> "aaa"
p r1            #=> nil
p r2            #=> ["james", "27", "dude@example.com"]
```

## License
under the Sleepycat License:
- see LICENSE file
