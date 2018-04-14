# --- SETTINGS ---

erlang_version = node[:erlang][:version]
erlang_configure_options = node[:erlang][:configure_options]
erlang_enable_apps = node[:erlang][:enable_apps]
erlang_disable_apps = node[:erlang][:disable_apps]
kerl_build_backend = node[:erlang][:kerl][:build_backend] || "tarball"

directory "/usr/local/kerl" do
  mode  "0755"
  owner "root"
  group "root"
end

template "/root/.kerlrc" do
  action :create
  source "templates/kerlrc.erb"
  owner "root"
  group "root"
  mode "644"
  variables(
    erlang_version: erlang_version,
    erlang_configure_options: erlang_configure_options,
    erlang_enable_apps: erlang_enable_apps,
    erlang_disable_apps: erlang_disable_apps,
    kerl_build_backend: kerl_build_backend
  )
end

# --- INSTALL ---

execute "# get kerl" do
  not_if "test -e /usr/bin/kerl"
  cwd "/usr/bin"
  command "wget https://raw.githubusercontent.com/kerl/kerl/master/kerl; chmod a+x /usr/bin/kerl"
end

execute "kerl update releases"

execute "kerl build #{erlang_version} #{erlang_version}" do
  not_if "test -e /usr/local/kerl/builds/#{erlang_version}"
end

execute "# activate erlang" do
  not_if "test -e /usr/local/kerl/erlang/#{erlang_version}"
  command "kerl install #{erlang_version} /usr/local/kerl/erlang/#{erlang_version}"
end

# profile

template "/etc/profile.d/kerl.sh" do
  action :create
  source "templates/kerl.sh.erb"
  owner "root"
  group "root"
  mode "644"
  variables(erlang_version: erlang_version)
end
