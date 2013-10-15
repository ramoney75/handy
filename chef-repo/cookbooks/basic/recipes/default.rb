#
# Cookbook Name:: basic
# Recipe:: default
#
# Copyright 2012, Ramon Huisman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
execute "setting timezone to australia" do
	command "ln -sf /usr/share/zoneinfo/Australia/Melbourne /etc/localtime"
end

execute "setting password algorithm to sha-512" do
	command "authconfig --passalgo=sha512 --update"
end

def print_attributes
  p node
  "some_string"
end

user "#{node.user_to_create}" do
  comment "#{node.user_to_create}"
  gid "users"
  shell "/bin/bash"
end

cookbook_file "/etc/sudoers" do
  mode '0440'
  owner 'root'
  group 'root'
  source 'sudoers'
  action :create
end


chef_sudo "#{node.user_to_create}" do
  user "#{node.user_to_create}"
  commands ["ALL"]
  host "ALL"
  nopasswd false
end

execute "setting password for #{node.user_to_create} to 'changeme'" do
  command "echo changeme|passwd --stdin #{node.user_to_create}"
end

execute "create .ssh directory if it does not exist yet" do
  command "mkdir -p ~#{node.user_to_create}/.ssh/"
end

execute "copying ssh files from host to guest." do
  command "cp /mnt/ssh/* ~#{node.user_to_create}/.ssh/"
end
