module FileSharedMethods
  def spec_file_path(filename)
    'spec/fixtures/files/' + filename
  end

  def spec_upload_file(file_path, content_type)
    Rack::Test::UploadedFile.new(file_path, content_type)
  end

  def api_uploaded_file(file_path, content_type)
    {
      'tempfile' => spec_upload_file(file_path, content_type),
      'filename' => file_path.split('/').last,
      'type' => content_type,
      'head' => ''
    }
  end
end
