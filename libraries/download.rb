class Download

  def command(args)
    bucket        = args[:bucket]
    object_name   = args[:object_name]
    file_name     = args[:file_name]
    force         = args[:force] ? '--force' : ''
    config_dir    = args[:config_dir]

    object_url = "s3://#{File.join bucket, object_name}"
            
    cmd =  "s3cmd #{force} --config #{config_dir}/.s3cfg get #{object_url} #{file_name}"
  end

end
