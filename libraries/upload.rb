class Upload

  def command(args)
    @headers    = args[:headers]

    acl_public  = args[:acl_public] ? '--acl-public' : ''
    bucket      = args[:bucket]
    object_name = args[:object_name]
    file_name   = args[:file_name]
    config_dir  = args[:config_dir]
    
    object_url = "s3://#{File.join bucket, object_name}"
    
    cmd =  "s3cmd #{acl_public} --config #{config_dir}/.s3cfg #{headers} put #{file_name} #{object_url}"
        
  end

  def headers
    @headers.map {|k,v| "--add-header='#{k}':'#{v}'"}.join(' ')
  end

end
