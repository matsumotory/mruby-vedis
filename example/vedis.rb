v = Vedis.new

v["test"] = "bbb"
v.set :fuga, "aaa"
v[:hoge] = 2
r1 = v.exec "MSET username james age 27 mail dude@example.com"
r2 = v.exec "MGET username age mail"

p v.class
p v[:test]      #=> "bbb"
p v.get "fuga"  #=> "aaa"
p v["hoge"]     #=> "222"
p r1
p r2

v.close

