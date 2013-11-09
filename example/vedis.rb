v = Vedis.new

v["test"] = "bbb"
v.set :fuga, "aaa"
v[:hoge] = 2

p v.class
p v[:test]      #=> "bbb"
p v.get "fuga"  #=> "aaa"
p v["hoge"]     #=> "222"

v.close

