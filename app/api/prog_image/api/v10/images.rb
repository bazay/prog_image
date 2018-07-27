module ProgImage
  module Api
    class V10::Images < Grape::API
      helpers ProgImage::Helpers::ImagesHelper

      namespace :images do
        desc 'Upload an image to storage'
        params do
          requires :image_file, type: File, desc: 'The multipart file to upload'
        end
        post '/' do
          if image_upload_form.persist
            present image_upload_form, with: ProgImage::Entities::Image
          else
            say_unprocessable_entity_for image_upload_form
          end
        end

        desc 'View a stored image'
        params do
          requires :key, type: String, desc: 'The key returned when performing POST request for an image'
          optional :extension, type: String,
            desc: "The extension of the image extension you want to convert to, e.g. 'PNG', 'JPG', 'TIFF', etc"
        end
        get '/' do
          if image_key_exists?
            perform_image_conversion!
          else
            say_not_found
          end
        end
      end
    end
  end
end
