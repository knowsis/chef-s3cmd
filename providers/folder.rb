
action :sync do  
     
  if node['s3cmd']['config_dir']
    config_dir = node['s3cmd']['config_dir']
  else
    config_dir = node['etc']['passwd'][node['s3cmd']['user']]['dir']
  end
      
  cmd = Sync.new.command     :source   => new_resource.source,
                             :dest      => new_resource.destination,                             
                             :config_dir  => config_dir
  
  execute "Syncing with cmd: #{cmd}" do
    command cmd
    user node['s3cmd']['user']
  end
  
  new_resource.updated_by_last_action(true)
  
end
