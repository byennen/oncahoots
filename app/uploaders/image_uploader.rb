# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  # def default_url
  #   ActionController::Base.helpers.asset_path("fallback/#{model.class.to_s.underscore}/#{version_name}.png")
  # end
  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :small do
    process :resize_to_fill => [77, 77]
  end
  version :thumb do
    process :resize_to_fill => [100, 100]
  end
  version :medium do
    process :resize_to_fill => [145, 145]
  end
  version :large do
    process :resize_to_fill => [185, 185]
  end

  version :xlarge do
    process :resize_to_fill => [226, 226]
  end

  version :xxlarge do
    process :resize_to_fill => [240, 240]
  end

  version :album do
    process :resize_to_fill => [670, 250]
  end

  version :album_photo do
    process :resize_to_fill => [670, 400]
  end

  version :club do
    process :resize_to_fill => [764, 320]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
