def run(cmd)
  if ruby_path
    super("export PATH=#{ruby_path}:$PATH && #{cmd}")
  else
    super(cmd)
  end
end

def sudo_put(data, target)
  tmp = "#{shared_path}/~tmp-#{rand(9999999)}"
  put data, tmp
  on_rollback { run "rm #{tmp}" }
  sudo "cp -f #{tmp} #{target} && rm #{tmp}"
end