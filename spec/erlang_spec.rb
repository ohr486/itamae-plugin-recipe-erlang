require "spec_helper"

describe file("/root/.kerlrc") do
  it { should be_file }
end

describe file("/etc/profile.d/kerl.sh") do
  it { should be_file }
  its(:content) { should match /20\.0/ }
end

describe file("/usr/bin/kerl") do
  it { should be_file }
  it { should be_executable }
end

describe command("source /etc/profile.d/kerl.sh && \
                  erl -eval 'io:format(erlang:system_info(otp_release)), halt().' -noshell") do
  its(:stdout) { should contain("20") }
end
