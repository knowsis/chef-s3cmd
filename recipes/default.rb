#
# Cookbook Name:: s3cmd
# Recipe:: default
# Frederico Araujo (fred.the.master@gmail.com)
# https://github.com/fred/chef-s3cmd
#

Chef::Log.info("Installing necessary python packages (python, pyton-setuptools, python-distutils-extra)")

package "python"
package "python-setuptools"
package "python-distutils-extra"

Chef::Log.info("Downloading tarball from github to #{Chef::Config[:file_cache_path]}/master.tar.gz")

remote_file "#{Chef::Config[:file_cache_path]}/master.tar.gz" do
  source node['s3cmd']['url']
  mode "0644"
end

Chef::Log.info("Unzipping tarball and running the setup.py install command")

bash "install-s3cmd" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  tar xzvf master.tar.gz
  cd s3cmd*
  python setup.py install
  EOH
end

if node['s3cmd']['config_dir']
  home_folder = node['s3cmd']['config_dir']
else
  home_folder = node['etc']['passwd'][node['s3cmd']['user']]['dir']
end

Chef::Log.info("Creating s3cmd config file (#{home_folder}/.s3cfg)")

template "#{home_folder}/.s3cfg" do
  source "s3cfg.erb"  
  owner node['s3cmd']['user']
  group node['s3cmd']['user']
  mode 0600
  variables :key => node['s3cmd'][:access_key] ? node['s3cmd'][:access_key] : nil, 
            :secret => node['s3cmd'][:secret_key] ? node['s3cmd'][:secret_key] : nil
end
