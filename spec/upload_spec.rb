require File.expand_path("../", __FILE__) + '/spec_helper'

describe Upload do
  before do
    @upload = Upload.new
    @args = { :acl_public  => true,
              :bucket      => 'b',
              :object_name => 'dir/obj',
              :headers     => { 'h1' => 'v1', 'h2' => 'v2' },
              :file_name   => '/tmp/file' }
    @r = "s3cmd --acl-public --add-header='h1':'v1' --add-header='h2':'v2' put /tmp/file s3://b/dir/obj"
  end

  it "should return the comand to upload the given file" do
    @upload.command(@args).should == @r
  end

  it "should remove leading slashes from obj file" do
    @args[:object_name] = '/dir/obj'
    @upload.command(@args).should == @r
  end
end
