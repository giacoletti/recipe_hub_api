module DecodeService
  def self.attach_image(resource, base64_string)
    split_data = split_base64_string(base64_string)
    decoded_data = Base64.decode64(split_data[:image_data])
    io = StringIO.new
    io.puts(decoded_data)
    io.rewind
    resource.image.attach(
      io: io,
      filename: "#{resource.name}.#{split_data[:suffix]}",
      content_type: split_data[:type]
    )
  end

  def self.split_base64_string(base64_string)
    base64_string =~ /^data:(.*?);(.*?),(.*)$/
    split_data = {}
    split_data[:type] = Regexp.last_match(1)
    split_data[:encoder] = Regexp.last_match(2)
    split_data[:image_data] = Regexp.last_match(3)
    split_data[:suffix] = Regexp.last_match(1).split('/').last
    split_data
  end
end
