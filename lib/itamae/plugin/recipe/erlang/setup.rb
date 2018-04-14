# --- SETTINGS ---

erlang_version = node[:erlang][:version]
erlang_configure_options = node[:erlang][:configure_options]
erlang_enable_apps = node[:erlang][:enable_apps]
erlang_disable_apps = node[:erlang][:disable_apps]

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
    erlang_disable_apps: erlang_disable_apps
  )
end

# --- INSTALL ---

execute "# get kerl" do
  not_if "test -e /usr/bin/kerl"
  cwd "/usr/bin"
  command "wget https://raw.githubusercontent.com/kerl/kerl/master/kerl; chmod a+x /usr/bin/kerl"
end

execute "KERL_BUILD_BACKEND=git kerl update releases"

execute "KERL_BUILD_BACKEND=git kerl build #{erlang_version} #{erlang_version}" #do
#  not_if "test -e /usr/local/kerl/builds/#{erlang_version}"
#end

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
