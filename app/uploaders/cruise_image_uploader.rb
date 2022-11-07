class CruiseImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "cruises/#{model.id}/#{mounted_as}/"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
