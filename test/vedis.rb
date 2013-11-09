##
## Vedis Test
##

assert("Vedis#set, Vedis#get") do
  v = Vedis.new
  v.set "hoge", "fuga"
  v.get("hoge") == "fuga"
end

assert("Vedis#set, Vedis#get by fixnum value") do
  v = Vedis.new
  v.set "hoge", 1
  v.get("hoge") == "1"
end

assert("Vedis#set, Vedis#get by sym") do
  v = Vedis.new
  v.set :hoge, "fuga" 
  v.get(:hoge) == "fuga"
end

assert("Vedis#[]=, Vedis#[]") do
  v = Vedis.new
  v["hoge"] = "fuga" 
  v["hoge"] == "fuga"
end

assert("Vedis#[]=, Vedis#[] by fixnum value") do
  v = Vedis.new
  v["hoge"] = 1
  v["hoge"] == "1"
end

assert("Vedis#[]=, Vedis#[] by sym") do
  v = Vedis.new
  v[:hoge] = "fuga"
  v[:hoge] == "fuga"
end

assert("Vedis#[] by On-Disk Data Store") do
  v = Vedis.new "/tmp/mruby-vedis-test.db"
  v[:hoge] = "fuga"
  v[:hoge] == "fuga"
end

