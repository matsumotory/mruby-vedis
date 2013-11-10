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

