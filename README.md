# mruby-vedis   [![Build Status](https://travis-ci.org/matsumoto-r/mruby-vedis.png?branch=master)](https://travis-ci.org/matsumoto-r/mruby-vedis)
Binding vedis for mruby.

Vedis is a embeddable datastore and self-contained C library that supports over 70 commands similar to Redis.

The major difference from Redis is no networking layer since Vedis runs in the same process of the host application.

Please see the official [Vedis homepage](http://vedis.symisc.net/index.html) for more detail.

## Install by mrbgems

Add the following line to `build_config.rb`:

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'matsumoto-r/mruby-vedis'
end
```

## Usage

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

## Benchmark comparing Vedis with Redis

### Simple benchmark

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

### Results

```bash
$ mruby test_vedis_redis.rb
Redis: passed time 10.785598 sec
Vedis: passed time 0.06595 sec
```

## License

mruby-vedis is licensed under the Sleepycat License, see the LICENSE file.
