##
## Vedis Test
##

assert("Vedis#set, Vedis#get") do
  v = Vedis.new
  v.set "hoge", "fuga"
  assert_equal "fuga", v.get("hoge")
  v.close
end

assert("Vedis#set, Vedis#get by fixnum value") do
  v = Vedis.new
  v.set "hoge", 1
  assert_equal "1", v.get("hoge")
  v.close
end

assert("Vedis#set, Vedis#get by sym") do
  v = Vedis.new
  v.set :hoge, "fuga"
  assert_equal "fuga", v.get(:hoge)
  v.close
end

assert("Vedis#[]=, Vedis#[]") do
  v = Vedis.new
  v["hoge"] = "fuga"
  assert_equal "fuga", v["hoge"]
  v.close
end

assert("Vedis#[]=, Vedis#[] by fixnum value") do
  v = Vedis.new
  v["hoge"] = 1
  assert_equal "1", v["hoge"]
  v.close
end

assert("Vedis#[]=, Vedis#[] by sym") do
  v = Vedis.new
  v[:hoge] = "fuga"
  assert_equal "fuga", v[:hoge]
  v.close
end

assert("Vedis#[] by On-Disk Data Store") do
  v = Vedis.new "/tmp/mruby-vedis-test.db"
  v[:hoge] = "fuga"
  assert_equal "fuga", v[:hoge]
  v.close
end

assert("Vedis#exec") do
  v = Vedis.new
  r1 = v.exec "MSET username james age 27 mail dude@example.com"
  r2 = v.exec "MGET username age mail"
  assert_equal nil, r1 
  assert_equal ["james", "27", "dude@example.com"] , r2 
  v.close
end

assert("Vedis#append") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_equal(true, v.append("hoge", " bbb"))
  assert_equal("aaa bbb", v["hoge"])
  assert_equal(true, v.append("fuga", "ccc"))
  assert_equal("ccc", v["fuga"])
  v.close
end

assert("Vedis#append, by sym") do
  v = Vedis.new
  v[:hoge] = "aaa"
  assert_equal(true, v.append(:hoge, " bbb"))
  assert_equal("aaa bbb", v[:hoge])
  assert_equal(true, v.append(:fuga, "ccc"))
  assert_equal("ccc", v[:fuga])
  v.close
end

assert("Vedis#<<") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_equal(true, v << {:fuga => "ccc", :hoge => " bbb"})
  assert_equal("aaa bbb", v["hoge"])
  assert_equal("ccc", v["fuga"])
  v.close
end

assert("Vedis#exist?") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_true(v.exists?("hoge"))
  assert_false(v.exists?("fuga"))
  v.close
end

assert("Vedis#exist?, by sym") do
  v = Vedis.new
  v[:hoge] = "aaa"
  assert_true(v.exists?(:hoge))
  assert_false(v.exists?(:fuga))
  v.close
end

assert("Vedis#strlen") do
  v = Vedis.new
  v["hoge"] = "aaa"
  assert_equal(3, v.strlen("hoge"))
  assert_equal(0, v.strlen("fuga"))
  v.close
end

assert("Vedis#strlen, by sym") do
  v = Vedis.new
  v[:hoge] = "aaa"
  assert_equal(3, v.strlen(:hoge))
  assert_equal(0, v.strlen(:fuga))
  v.close
end
