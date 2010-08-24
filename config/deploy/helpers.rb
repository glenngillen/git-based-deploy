def set(*args)
  if args.first == :web_server
    lib_path = File.dirname(__FILE__)
    load "#{lib_path}/#{args.last.to_s}.rb"
  end
  super(*args)
end

def run(cmd, options = {}, &block)
  if respond_to?(:ruby_path) && !ruby_path.nil?
    options.merge!(:env => { "PATH" => "#{ruby_path}:$PATH" })
  end
  super(cmd, options, &block)
end

def sudo_put(data, target)
  tmp = "#{shared_path}/~tmp-#{rand(9999999)}"
  put data, tmp
  on_rollback { run "rm #{tmp}" }
  sudo "cp -f #{tmp} #{target} && rm #{tmp}"
end