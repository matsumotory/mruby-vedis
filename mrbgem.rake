MRuby::Gem::Specification.new('mruby-vedis') do |spec|
  spec.license = 'Sleepycat License'
  spec.authors = 'MATSUMOTO Ryosuke'
  spec.version = '0.0.1'

  require 'open3'

  vedis_dir = "#{build_dir}/vedis"

  def run_command env, command
    STDOUT.sync = true
    puts "build: [exec] #{command}"
    Open3.popen2e(env, command) do |stdin, stdout, thread|
      print stdout.read
      fail "#{command} failed" if thread.value != 0
    end
  end

  FileUtils.mkdir_p build_dir

  if ! File.exist? vedis_dir
    Dir.chdir(build_dir) do
      e = {}
      run_command e, 'git clone https://github.com/symisc/vedis.git'
    end
  end

  objs = Dir.glob("#{vedis_dir}/*.{c,cpp,cxx,cc,m,asm,s,S}").map do |f|
    objfile(f.relative_path_from(vedis_dir).to_s.pathmap("#{vedis_dir}/%X"))
  end

  build.libmruby << objs
  spec.cc.include_paths << vedis_dir
end
