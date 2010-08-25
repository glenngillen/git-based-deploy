def set(*args)
  if args.first == :web_server
    lib_path = File.dirname(__FILE__)
    load "#{lib_path}/#{args.last.to_s}.rb"
  end
  super(*args)
end

def value(setting, default = nil)
  if respond_to?(setting) && !send(setting).nil?
    send(setting)
  else
    default
  end
end

def run(cmd, options = {}, &block)
  options.merge!(:env => { "PATH" => "#{ruby_path}:$PATH" }) if value(:ruby_path)
  super(cmd, options, &block)
end

def sudo_put(data, target)
  tmp = "#{shared_path}/~tmp-#{rand(9999999)}"
  put data, tmp
  on_rollback { run "rm #{tmp}" }
  sudo "cp -f #{tmp} #{target} && rm #{tmp}"
end