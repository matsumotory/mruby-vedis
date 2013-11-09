# mruby-vedis
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
- In-Memory Data Store

```ruby
v = Vedis.new

v["test"] = "bbb"
v.set :fuga, "aaa"
v[:hoge] = 2

p v[:test]      #=> "bbb"
p v.get "fuga"  #=> "aaa"
p v["hoge"]     #=> "222"

v.close
```

- On-Disk Data Store

```ruby
v = Vedis.new "/tmp/hoge.vdb"

v["test"] = "bbb"
v.set :fuga, "aaa"
v[:hoge] = 2

p v[:test]      #=> "bbb"
p v.get "fuga"  #=> "aaa"
p v["hoge"]     #=> "222"

v.close
```

## License
under the Sleepycat License:
- see LICENSE file
