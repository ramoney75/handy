#
# Cookbook Name:: gnome
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
#

execute "groupinstall" do
	command "yum groupinstall -y basic-desktop desktop-platform x11 fonts"
	action :run
end

cookbook_file "/etc/inittab" do
	  source "inittab" # this is the value that would be inferred from the path parameter
	  mode "0644"
end

execute "enable epel2" do
  command "yum install -y http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
  action :run
  not_if {File.exists? '/etc/yum.repos.d/epel.repo'}
end

cookbook_file "/etc/yum.repos.d/google-chrome.repo" do
	source "google-chrome.repo"
	mode "0644"
end

#generic dev
package "google-chrome-stable" do
	action :install
end

#generic dev
package "gvim" do
	action :install
end

#generic dev
package "vim" do
  action :install
end

#tds gem dep
package "freetds" do
	action :install
end

#nokogiri dep
package "libxml2-devel" do
	action :install
end

#nokogiri dep
package "libxslt-devel" do
	action :install
end

#generic dev
package "git" do
	action :install
end
