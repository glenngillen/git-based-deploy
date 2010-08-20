def run(cmd, options = {}, &block)
  options.merge!(:env => { "PATH" => "#{ruby_path}:$PATH" }) if ruby_path
  super(cmd, options, &block)
end

def sudo_put(data, target)
  tmp = "#{shared_path}/~tmp-#{rand(9999999)}"
  put data, tmp
  on_rollback { run "rm #{tmp}" }
  sudo "cp -f #{tmp} #{target} && rm #{tmp}"
end