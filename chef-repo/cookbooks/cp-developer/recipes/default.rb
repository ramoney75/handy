#
# Cookbook Name:: cp-developer
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
execute 'Setup developer folders' do
  folder = "~#{node.user_to_create}/projects/rea"
  command "mkdir -p #{folder}"
  user "#{node.user_to_create}"
  group "users"
  creates folder
end

execute 'Setup rvm' do
  folder = "~#{node.user_to_create}/.rvm"
  command "su --command=\"curl -L https://get.rvm.io | bash -s stable --without-gems='rvm rubygems-bundler'\" - #{node.user_to_create}"
  creates folder
end

execute 'Install ree' do
  command "~#{node.user_to_create}/.rvm/bin/rvm install ree-1.8.7-2012.02"
  user    "#{node.user_to_create}"
  group   "users"
  not_if  "~#{node.user_to_create}/.rvm/bin/rvm use ree-1.8.7-2012.02"
end

package 'mysql-devel' do
  action :install
end

package 'mysql-server' do
  action :install
end

cookbook_file '/etc/my.cnf' do
  source "my.cnf"
  owner 'root'
  group 'root'
end

execute "checkout cp-agentadmin" do
  homedir = `echo ~#{node.user_to_create}`.chomp
  folder = "#{homedir}/projects/rea/cp-agentadmin"
  action :run
  user "#{node.user_to_create}"
  group "users"
  repository = 'git@git.realestate.com.au:/customer-systems/cp-agentadmin.git'
  command "git clone #{repository} #{folder}"
  creates folder
end

execute "checkout cp-domain" do
  homedir = `echo ~#{node.user_to_create}`.chomp
  folder = "#{homedir}/projects/rea/cp-domain"
  action :run
  user "#{node.user_to_create}"
  group "users"
  repository = 'git@git.realestate.com.au:/customer-systems/cp-domain.git'
  command "git clone #{repository} #{folder}"
  creates folder
end
