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

assert("Vedis#exec") do
  v = Vedis.new
  r1 = v.exec "MSET username james age 27 mail dude@example.com"
  r2 = v.exec "MGET username age mail"
  r1 == nil and r2 == ["james", "27", "dude@example.com"]
end

assert("Vedis#append") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_equal(true, v.append("hoge", " bbb"))
  assert_equal("aaa bbb", v["hoge"])
  assert_equal(true, v.append("fuga", "ccc"))
  assert_equal("ccc", v["fuga"])
end

assert("Vedis#append, by sym") do
  v = Vedis.new
  v[:hoge] = "aaa"
  assert_equal(true, v.append(:hoge, " bbb"))
  assert_equal("aaa bbb", v[:hoge])
  assert_equal(true, v.append(:fuga, "ccc"))
  assert_equal("ccc", v[:fuga])
end

assert("Vedis#<<") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_equal(true, v << {:fuga => "ccc", :hoge => " bbb"})
  assert_equal("aaa bbb", v["hoge"])
  assert_equal("ccc", v["fuga"])
end

assert("Vedis#exist?") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_true(v.exists?("hoge"))
  assert_false(v.exists?("fuga"))
end

assert("Vedis#exist?, by sym") do
  v = Vedis.new
  v[:hoge] = "aaa"
  assert_true(v.exists?(:hoge))
  assert_false(v.exists?(:fuga))
end

assert("Vedis#strlen") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_equal(3, v.strlen("hoge"))
  assert_equal(0, v.strlen("fuga"))
end

assert("Vedis#strlen, by sym") do
  v = Vedis.new
  v[:hoge] = "aaa"
  assert_equal(3, v.strlen(:hoge))
  assert_equal(0, v.strlen(:fuga))
end
