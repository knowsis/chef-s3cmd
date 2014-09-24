class Sync

  def command(args)
    source        = args[:source]    
    dest     = args[:destination]    
    config_dir    = args[:config_dir]    
            
    cmd =  "s3cmd --config #{config_dir}/.s3cfg sync #{source} #{dest}"
  end

end
