action :download do
  file_name = new_resource.file_name
     
  if node['s3cmd']['config_dir']
    config_dir = node['s3cmd']['config_dir']
  else
    config_dir = node['etc']['passwd'][node['s3cmd']['user']]['dir']
  end
      
  cmd = Download.new.command :file_name   => file_name,
                             :bucket      => new_resource.bucket,
                             :object_name => new_resource.object_name,
                             :force       => new_resource.force,
                             :config_dir  => config_dir


  Chef::Log.info("Downloading from s3 with cmd: #{cmd}")

  execute "Downloading from s3 with cmd: #{cmd}" do
    command cmd
    user node['s3cmd']['user']
  end

  file file_name do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end
  
  new_resource.updated_by_last_action(true)
  
end

action :upload do
  file_name = new_resource.file_name
  
  if node['s3cmd']['config_dir']
    config_dir = node['s3cmd']['config_dir']
  else
    config_dir = node['etc']['passwd'][node['s3cmd']['user']]['dir']
  end
  
  raise Errno::ENOENT, "File #{file_name} not found." unless ::File.exists? file_name

  cmd = Upload.new.command :headers     => new_resource.headers,
                           :file_name   => file_name,
                           :bucket      => new_resource.bucket,
                           :object_name => new_resource.object_name,
                           :acl_public  => new_resource.acl_public,
                           :force       => new_resource.force,
                           :config_dir  => config_dir

  Chef::Log.info("Uploading to s3 with cmd: '#{cmd}'")
  
  execute "Uploading to S3 with cmd: '#{cmd}'" do
    command cmd
    user node['s3cmd']['user']
  end
  
  new_resource.updated_by_last_action(true)
  
end

