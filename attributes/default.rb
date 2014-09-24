#
# Cookbook Name:: s3cmd
# Recipe:: default
#
# Frederico Araujo (fred.the.master@gmail.com)
# https://github.com/fred/chef-s3cmd
#


# Url to download the tarball from latest master branch from github.
default['s3cmd']['url'] = 'https://github.com/s3tools/s3cmd/archive/v1.5.0-beta1.tar.gz'
default['s3cmd']['user'] = 'root'
default['s3cmd']['config_dir'] = '/root'
