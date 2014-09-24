require File.expand_path("../", __FILE__) + '/spec_helper'

describe Download do
  before do
    @download = Download.new
    @args = { :bucket      => 'bucket',
              :object_name => 'dir/obj',
              :file_name   => '/tmp/file',
              :force       => true }
    @r = "s3cmd --force get s3://bucket/dir/obj /tmp/file"
  end

  it "should return the comand to download the given file" do
    @download.command(@args).should == @r
  end

  it "should remove leading slashes from obj file" do
    @args[:object_name] = '/dir/obj'
    @download.command(@args).should == @r
  end
end
