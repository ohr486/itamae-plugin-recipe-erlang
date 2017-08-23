%w(erlang erlang-*).each do |pkg|
  package pkg do
    action :remove
  end
end

%w(wget).each do |pkg|
  package pkg do
    action :install
  end
end

case node[:platform]
when "redhat", "fedora", "amazon"
  # TODO: add if need
else
  raise "Sorry, unsupported platform."
end
