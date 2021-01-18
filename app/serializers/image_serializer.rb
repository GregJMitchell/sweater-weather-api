class ImageSerializer
  include JSONAPI::Serializer
  attribute :image do |image|
    {
      location: image.location,
      image_url: image.image_url,
      credit: image.credit
    }
  end
end
