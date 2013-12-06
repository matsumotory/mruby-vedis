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
## simple benchmark Vedis compared with Redis
- benchmark code

```ruby
class SimpleBenchmark

  def initialize(width = 0)
    @width = width
  end

  def measure(label)
    start = Time.now
    yield if block_given?
    passed = Time.now - start

    puts "#{make_fixed_label(label)}passed time #{passed} sec"
  end

  def make_fixed_label(label)
   if @width - label.length > 0
      label + ' ' * (@width - label.length)
    else
      label
    end
  end

end

benchmark = SimpleBenchmark.new
r = Redis.new "127.0.0.1", 6379
v = Vedis.new
n = 100000

[r, v].each do |kvs|
  benchmark.measure("#{kvs.class}: ") do
    n.times do |t|
      kvs.set t.to_s, t.to_s
    end
  end
end

r.close
v.close
```

- result

```bash
$ mruby test_vedis_redis.rb 
Redis: passed time 10.785598 sec
Vedis: passed time 0.06595 sec
```

## License
under the Sleepycat License:
- see LICENSE file
